From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Thu, 15 Dec 2011 20:01:54 -0600
Subject: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
In-Reply-To: <CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-2-git-send-email-omar.ramirez@ti.com>
 <CAMP44s2WFghH4qPKuwSQJFaoLEmfAtcHB3DRZwNYe4zXTQexfQ@mail.gmail.com>
Message-ID: <CAB-zwWiTHD38s6Mz_xfxhxBqYph1ctTmhU5dntnp4zHsUwJtHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 6:39 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> +/* l4_core -> isp mmu */
>> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__isp_mmu = {
>> + ? ? ? .master ? ? ? ? = &omap3xxx_l4_core_hwmod,
>> + ? ? ? .slave ? ? ? ? ?= &omap3xxx_isp_mmu_hwmod,
>> + ? ? ? .addr ? ? ? ? ? = omap3xxx_isp_mmu_addrs,
>> + ? ? ? .user ? ? ? ? ? = OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>
> Are you sure you are not missing something like:
>
> ?.clk = "cam_ick",

I believe in this case cam_ick is used as the main clock as it
supplies both functional and interface.

>
>> +/* isp mmu slave ports */
>> +static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] = {
>> + ? ? ? &omap3xxx_l4_core__isp_mmu,
>> +};
>> +
>> +static struct omap_hwmod omap3xxx_isp_mmu_hwmod = {
>> + ? ? ? .name ? ? ? ? ? = "isp_mmu",
>> + ? ? ? .class ? ? ? ? ?= &omap3xxx_mmu_hwmod_class,
>> + ? ? ? .mpu_irqs ? ? ? = omap3xxx_isp_mmu_irqs,
>> + ? ? ? .main_clk ? ? ? = "cam_ick",
>
> It's not "cam_fck"?

AFAIK cam_fck doesn't exist in the code, and CAM_L3_ICK is used as
both ick/fck according to TRM.

>
>> + ? ? ? .dev_attr ? ? ? = &isp_mmu_dev_attr,
>> + ? ? ? .slaves ? ? ? ? = omap3xxx_isp_mmu_slaves,
>> + ? ? ? .slaves_cnt ? ? = ARRAY_SIZE(omap3xxx_isp_mmu_slaves),
>> + ? ? ? .flags ? ? ? ? ?= HWMOD_NO_IDLEST,
>> +};
>
> Most of the stuff I see the hwmods is .main_lock = "foo_fck", slave
> .clk = "foo_ick". Maybe that explains the irq issues you get.

I see irq issues with iva hwmod because tidspbridge doesn't use iommu
API yet, so if you enable both the mmu hwmod and tidspbridge own mmu
implementation there will be some conflicts.

I didn't see isp issues though, but I didn't went more than
booting/enabling with isp mmu.

Regards,

Omar
