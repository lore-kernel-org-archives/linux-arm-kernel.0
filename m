From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 19 Dec 2011 18:11:50 +0200
Subject: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
In-Reply-To: <CAB-zwWiTHD38s6Mz_xfxhxBqYph1ctTmhU5dntnp4zHsUwJtHA@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
 <CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
 <CAB-zwWiTHD38s6Mz_xfxhxBqYph1ctTmhU5dntnp4zHsUwJtHA@mail.gmail.com>
Message-ID: <CAMP44s2H7v6dRPXO6eBBNrYAnym_ZLdmKcAQPmYyCC6Wo5qOmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 4:01 AM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> On Thu, Dec 15, 2011 at 6:39 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Are you sure you are not missing something like:
>>
>> ?.clk = "cam_ick",
>
> I believe in this case cam_ick is used as the main clock as it
> supplies both functional and interface.

Are you sure?

>>> +/* isp mmu slave ports */
>>> +static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] = {
>>> + ? ? ? &omap3xxx_l4_core__isp_mmu,
>>> +};
>>> +
>>> +static struct omap_hwmod omap3xxx_isp_mmu_hwmod = {
>>> + ? ? ? .name ? ? ? ? ? = "isp_mmu",
>>> + ? ? ? .class ? ? ? ? ?= &omap3xxx_mmu_hwmod_class,
>>> + ? ? ? .mpu_irqs ? ? ? = omap3xxx_isp_mmu_irqs,
>>> + ? ? ? .main_clk ? ? ? = "cam_ick",
>>
>> It's not "cam_fck"?
>
> AFAIK cam_fck doesn't exist in the code, and CAM_L3_ICK is used as
> both ick/fck according to TRM.

Then maybe the code is wrong.

Look at the OMAP34xx documentation, it says that:

CAM_L3_ICLK -> CAM_FCLK
CAM_L4_ICLK -> CAM_ICLK
CAM_MCLK -> CAM_MCLK
CSI2_96M_FCLK -> CSI2_96M_FCLK

CAM_FCLK
Functional clock (L3 interconnect clock domain)
Functional clock domain.

CAM_ICLK
Interface clock (L4 interconnect clock domain)
Interface clock domain.

Maybe something like this:

--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -2225,8 +2225,17 @@ static struct clk cam_mclk = {
        .recalc         = &followparent_recalc,
 };

+static struct clk cam_fck = {
+       .name           = "cam_fck",
+       .ops            = &clkops_omap2_dflt,
+       .parent         = &l3_ick,
+       .enable_reg     = OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
+       .enable_bit     = OMAP3430_EN_CAM_SHIFT,
+       .clkdm_name     = "cam_clkdm",
+       .recalc         = &followparent_recalc,
+};
+
 static struct clk cam_ick = {
-       /* Handles both L3 and L4 clocks */
        .name           = "cam_ick",
        .ops            = &clkops_omap2_iclk_dflt,
        .parent         = &l4_ick,
@@ -3364,6 +3373,7 @@ static struct omap_clk omap3xxx_clks[] = {
        CLK("omapdss_dss",      "ick",          &dss_ick_3430es1,
 CK_3430ES1),
        CLK("omapdss_dss",      "ick",          &dss_ick_3430es2,
 CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
        CLK(NULL,       "cam_mclk",     &cam_mclk,      CK_34XX | CK_36XX),
+       CLK(NULL,       "cam_fck",      &cam_fck,       CK_34XX | CK_36XX),
        CLK(NULL,       "cam_ick",      &cam_ick,       CK_34XX | CK_36XX),
        CLK(NULL,       "csi2_96m_fck", &csi2_96m_fck,  CK_34XX | CK_36XX),
        CLK(NULL,       "usbhost_120m_fck", &usbhost_120m_fck,
CK_3430ES2PLUS | CK_AM35XX | CK_36XX),

Also, I find this chunk peculiar in drivers/media/video/omap3isp/isp.c:

static const char *isp_clocks[] = {
	"cam_ick",
	"cam_mclk",
	"dpll4_m5_ck",
	"csi2_96m_fck",
	"l3_ick",
};

Looks like the driver is manually calling clk_get() and clk_put() for
the "i3_ick", where I guess the clock framework is supposed to do
that... It's almost as if somebody forgot a dependency somewhere.

>>> + ? ? ? .dev_attr ? ? ? = &isp_mmu_dev_attr,
>>> + ? ? ? .slaves ? ? ? ? = omap3xxx_isp_mmu_slaves,
>>> + ? ? ? .slaves_cnt ? ? = ARRAY_SIZE(omap3xxx_isp_mmu_slaves),
>>> + ? ? ? .flags ? ? ? ? ?= HWMOD_NO_IDLEST,
>>> +};
>>
>> Most of the stuff I see the hwmods is .main_lock = "foo_fck", slave
>> .clk = "foo_ick". Maybe that explains the irq issues you get.
>
> I see irq issues with iva hwmod because tidspbridge doesn't use iommu
> API yet, so if you enable both the mmu hwmod and tidspbridge own mmu
> implementation there will be some conflicts.
>
> I didn't see isp issues though, but I didn't went more than
> booting/enabling with isp mmu.

This is what you said:
Removed clk handling during interrupt, given that in order to receive one,
the device should be powered on in advance.

I'm not sure how this clock stuff works, but I'm guessing the device
is supposed to go to sleep at some points in time, and with your patch
"OMAP3/4: iommu: adapt to runtime pm" it won't, as long as the module
is loaded, unless I'm missing something.

Cheers.

-- 
Felipe Contreras
