From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Mon, 31 Oct 2016 21:59:08 +0100
Subject: [PATCH] ARM: BCM5301X: Add back handler ignoring external
 imprecise aborts
In-Reply-To: <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
References: <20161029111229.26875-1-zajec5@gmail.com>
 <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
Message-ID: <6e252703-0010-83ae-fa14-57352add007a@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/31/2016 07:08 PM, Scott Branden wrote:
> Hi Rafal,
> 
> 
> On 16-10-29 04:12 AM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> Since early BCM5301X days we got abort handler that was removed by
>> commit 937b12306ea79 ("ARM: BCM5301X: remove workaround imprecise abort
>> fault handler"). It assumed we need to deal only with pending aborts
>> left by the bootloader. Unfortunately this isn't true for BCM5301X.
>>
>> When probing PCI config space (device enumeration) it is expected to
>> have master aborts on the PCI bus. Most bridges don't forward (or they
>> allow disabling it) these errors onto the AXI/AMBA bus but not the
>> Northstar (BCM5301X) one.
> Should we only add this workaround code if CONFIG_PCI is on then?

I think all the supported northstar devices have a PCIe controller. We
could add such a CONFIG_PCI check, but I do not see a big advantage.

>> iProc PCIe controller on Northstar seems to be some older one, without
>> a control register for errors forwarding. It means we need to workaround
>> this at platform level. All newer platforms are not affected by this
>> issue.
>>
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> ---
>>  arch/arm/mach-bcm/bcm_5301x.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/mach-bcm/bcm_5301x.c
>> b/arch/arm/mach-bcm/bcm_5301x.c
>> index c8830a2..fe067f6 100644
>> --- a/arch/arm/mach-bcm/bcm_5301x.c
>> +++ b/arch/arm/mach-bcm/bcm_5301x.c
>> @@ -9,14 +9,42 @@
>>  #include <asm/hardware/cache-l2x0.h>
>>
>>  #include <asm/mach/arch.h>
>> +#include <asm/siginfo.h>
>> +#include <asm/signal.h>
>> +
>> +#define FSR_EXTERNAL        (1 << 12)
>> +#define FSR_READ        (0 << 10)
>> +#define FSR_IMPRECISE        0x0406
>>
>>  static const char *const bcm5301x_dt_compat[] __initconst = {
>>      "brcm,bcm4708",
>>      NULL,
>>  };
>>
>> +static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
>> +                  struct pt_regs *regs)
>> +{
>> +    /*
>> +     * We want to ignore aborts forwarded from the PCIe bus that are
>> +     * expected and shouldn't really be passed by the PCIe controller.
>> +     * The biggest disadvantage is the same FSR code may be reported
>> when
>> +     * reading non-existing APB register and we shouldn't ignore that.
>> +     */
>> +    if (fsr == (FSR_EXTERNAL | FSR_READ | FSR_IMPRECISE))
>> +        return 0;

How often does this happen? Would it be useful to add a log message here?

>> +
>> +    return 1;
>> +}
>> +
>> +static void __init bcm5301x_init_early(void)
>> +{
>> +    hook_fault_code(16 + 6, bcm5301x_abort_handler, SIGBUS, BUS_OBJERR,
>> +            "imprecise external abort");
>> +}
>> +
>>  DT_MACHINE_START(BCM5301X, "BCM5301X")
>>      .l2c_aux_val    = 0,
>>      .l2c_aux_mask    = ~0,
>>      .dt_compat    = bcm5301x_dt_compat,
>> +    .init_early    = bcm5301x_init_early,
>>  MACHINE_END
>>
> 
> Regards,
> Scott
