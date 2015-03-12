From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 12 Mar 2015 09:46:39 +0800
Subject: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
In-Reply-To: <20150311231141.GG21998@io.lakedaemon.net>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6uWwts6X=Yc2ioBdQizXkF1_YgoNNOsREWirk2MFBVDHg@mail.gmail.com>
 <20150311231141.GG21998@io.lakedaemon.net>
Message-ID: <5500EFFF.2070807@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/12 7:11, Jason Cooper wrote:
> Hey Grant,
>
> On Wed, Mar 11, 2015 at 06:04:50PM +0000, Grant Likely wrote:
>> On 11 Mar 2015 12:42, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>
>>> ACPI kernel uses MADT table for proper GIC initialization. It needs to
>>> parse GIC related subtables, collect CPU interface and distributor
>>> addresses and call driver initialization function (which is hardware
>>> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
>>>
>>> NOTE: This commit allow to initialize GICv1/2 basic functionality.
>>> While now simple GICv2 init call is used, any further GIC features
>>> require generic infrastructure for proper ACPI irqchip initialization.
>>> That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
>>> extension, GICv3/4 and its ITS are considered as next steps.
>>>
>>> CC: Jason Cooper <jason@lakedaemon.net>
>>> CC: Marc Zyngier <marc.zyngier@arm.com>
>>> CC: Thomas Gleixner <tglx@linutronix.de>
>> BTW, Thomas is taking a bit of a break, do he is unlikely to give an ack
>> here in a timely manner. I've not heard from Jason. Personally, I think we
>> can proceed without their ack if everything else is in order (heck, I used
>> to help with the irq subsystem, use me as an ack of you want). The patch is
>> low impact and only had effect for ARM ACPI builds.
> I'm not talking much, but I am tracking and collecting everything for irqchip.
> We do have some other changes in this driver this time around.  So it'd be nice
> if I could take this.
>
> I had reached out to Olof for his thoughts on this and he hasn't had enough
> cycles to look at it.  iirc, Marc reviewed a previous version and was happy with
> the changes.  My only question I had for Olof I'll put below:

Please allow me to explain a little bit before Olof's confirmation, please don't mind if
any offended.

>
>>> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
>>> index 0fe2f71..afd1af3 100644
>>> --- a/drivers/irqchip/irqchip.c
>>> +++ b/drivers/irqchip/irqchip.c
>>> @@ -8,6 +8,7 @@
>>>   * warranty of any kind, whether express or implied.
>>>   */
>>>
>>> +#include <linux/acpi_irq.h>
>>>  #include <linux/init.h>
>>>  #include <linux/of_irq.h>
>>>  #include <linux/irqchip.h>
>>> @@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
>>>  void __init irqchip_init(void)
>>>  {
>>>         of_irq_init(__irqchip_of_table);
>>> +
>>> +       acpi_irq_init();
>>>  }
> Is this in line with Olof's idea that providing a dtb would override ACPI?

Yes, it will. Since ACPI is default OFF (disabled), if a dtb provided, and no acpi=force
passed in the early command line, dtb will be used as system configuration for
boot (dtb is always the prior one for now) [1]. In acpi_gic_init() which called by
acpi_irq_init(), it will return immediately if acpi disabled, so it will not parse
any ACPI table for device configuration.

[1]: [patch 08/21] ARM64 / ACPI: Introduce early_param "acpi=" to enable/disable ACPI

Thanks
Hanjun
