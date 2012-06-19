From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Tue, 19 Jun 2012 11:39:22 -0500
Subject: [PATCH 3/6] ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp
In-Reply-To: <4FE07268.7040606@ti.com>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
 <1339811764-5337-4-git-send-email-omar.luna@linaro.org>
 <4FE07268.7040606@ti.com>
Message-ID: <CALLhW=67d7=4Jx1T4Kn5ddNz7vQ5YeN4AzuOuXrW1_UGYwpG2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On 19 June 2012 07:36, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 6/16/2012 3:56 AM, Omar Ramirez Luna wrote:
...
>> +static struct omap_hwmod omap44xx_ipu_mmu_hwmod = {
>> + ? ? .name ? ? ? ? ? = "ipu_mmu",
>> + ? ? .class ? ? ? ? ?= &omap44xx_mmu_hwmod_class,
>> + ? ? .clkdm_name ? ? = "ducati_clkdm",
>> + ? ? .mpu_irqs ? ? ? = omap44xx_ipu_mmu_irqs,
>> + ? ? .rst_lines ? ? ?= omap44xx_ipu_mmu_resets,
>> + ? ? .rst_lines_cnt ?= ARRAY_SIZE(omap44xx_ipu_mmu_resets),
>> + ? ? .main_clk ? ? ? = "ipu_fck",
>> + ? ? .prcm = {
>> + ? ? ? ? ? ? .omap4 = {
>> + ? ? ? ? ? ? ? ? ? ? .clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
>> + ? ? ? ? ? ? ? ? ? ? .rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
>> + ? ? ? ? ? ? ? ? ? ? .context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
>> + ? ? ? ? ? ? ? ? ? ? .modulemode ? = MODULEMODE_HWCTRL,
>> + ? ? ? ? ? ? },
>> + ? ? },
>> + ? ? .dev_attr ? ? ? = &ipu_mmu_dev_attr,
>> +};
>
> In fact, the MMU_IPU hwmod is now almost the same one than the previous IPU one...
> If we do that we should maybe just rename the IPU -> MMU_IPU and DSP -> MMU_DSP.
>
> But by doing that we will assume that the MMU does represent the subsystem, which is not necessarily super nice.
>
> I guess that a much better representation will be to keep the subsystem (IPU) to handle the PRCM part:
>
> + ? ? ? .main_clk ? ? ? = "ipu_fck",
> + ? ? ? .prcm = {
> + ? ? ? ? ? ? ? .clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
> + ? ? ? ? ? ? ? .rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
> + ? ? ? ? ? ? ? .context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
> + ? ? ? ? ? ? ? .modulemode ? = MODULEMODE_HWCTRL,
>
> And then the MMU_IPU will handle the configuration registers part and the reset + irq.
>
> But then, you will have to create a parent child dependency between your devices to ensure that the IPU subsystem device will be enabled before trying to access the MMU_IPU.
>
> This is what the DSS is about to do to handle the same kind of power dependency. The DSS device is the parent of all the DSS IPs (DISPC, HDMI...) and thus pm_runtime will ensure that the parent is enabled before trying to enable the children.
>
> In term of DT, just to illustrate the situation, it will be something like that:
>
> ipu {
> ? ? ? ?compatible = "simple-bus";
> ? ? ? ?ti,hwmods = "ipu";
>
> ? ? ? ?ipu_mmu: mmu at 4a066000 {
> ? ? ? ? ? ? ? ?compatible = "omap-mmu";
> ? ? ? ? ? ? ? ?ti,hwmods = "mmu_ipu";
> ? ? ? ? ? ? ? ?reg...;
> ? ? ? ? ? ? ? ?irqs...;
> ? ? ? ?}
> }
>
> Is it something you can handle with your current framework?

I agree it would be nice only IPU managed the prcm, however we can't
do that right now because hwmod expects the IP block to be out of
reset to continue the _enable sequence. On IPU both reset lines are
asserted at that point and hence _are_any_hardreset_lines_asserted
check will bail out, and ipu resets can't be lifted without a
configured iommu otherwise it might execute random garbage.

So, for IPU and DSP the mmu must be deasserted and configured before
the processor reset line (which is more like a parking brake) is
deasserted, and the latter should be made before _enable is called so
it can fully execute the enable sequence.

Regards,

Omar
