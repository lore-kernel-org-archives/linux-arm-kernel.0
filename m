From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 9 Nov 2011 17:56:36 +0800
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
Message-ID: <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for your comments.

On Tue, Nov 8, 2011 at 11:26 PM, Paul Walmsley <paul@pwsan.com> wrote:

>> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] = {
>> + ? ? { .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
>> + ? ? { .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
>> + ? ? { .irq = -1 }
>> +};
>
> Are you sure these are part of the emulation IP? ?We already have those

I am not sure, I just figure out one way to make omap4 pmu work. Since there
are few descriptions in TRM about it, it is a hacking based on [1], :-)

> IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.

I just see it, but looks like the "mpu" hwmod isn't populated as omap_device,
so the CTI irqs aren't requested now. Also, current arm perf code don't handle
three IRQs(one pl310 irq and two CTI irq) inside one device correctly.

So any suggestion about CTI IRQs connecting to which hwmod, so that they can
be found by pmu driver?

>> +/*emu hwmod*/
>> +static struct omap_hwmod omap44xx_emu_hwmod = {
>> + ? ? .name ? ? ? ? ? = "emu",
>> + ? ? .class ? ? ? ? ?= &omap44xx_emu_hwmod_class,
>> + ? ? .clkdm_name ? ? = "emu_sys_clkdm",
>> + ? ? .prcm = {
>> + ? ? ? ? ? ? .omap4 = {
>> + ? ? ? ? ? ? ? ? ? ? .clkctrl_offs = OMAP4_CM_EMU_CLKSTCTRL_OFFSET,
>
> This doesn't look right either: EMU is a clockdomain, not an IP block.

I defined the 'emu' hwmod to control the clock state transition of the EMU
clock domain by writing to CLKTRCTRL.CM_EMU_CLKSTCTRL with standard
hwmod interface(_enable / _idle). Is there any other neat way to do it?

>
>> + ? ? ? ? ? ? ? ? ? ? .modulemode ? = MODULEMODE_HWCTRL,
>> + ? ? ? ? ? ? },
>> + ? ? },
>> + ? ? .mpu_irqs ? ? ? = omap44xx_emu_irqs,
>> +};
>> +
>> ?static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>>
>> ? ? ? /* dmm class */
c
>
>

[1], http://comments.gmane.org/gmane.comp.embedded.pandaboard/168

thanks,
--
Ming Lei
