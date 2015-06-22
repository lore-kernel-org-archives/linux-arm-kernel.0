From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 22 Jun 2015 16:50:41 -0400
Subject: [PATCH] ARM: keystone: ecc: add ddr3 ecc interrupt handling
In-Reply-To: <558436C1.3050402@oracle.com>
References: <1434654589-28157-1-git-send-email-vitalya@ti.com>
 <558436C1.3050402@oracle.com>
Message-ID: <55887521.7010708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2015 11:35 AM, santosh shilimkar wrote:
> On 6/18/2015 12:09 PM, Vitaly Andrianov wrote:
>> This patch adds ARM L1/L2 ECC handler support and DDR3 ECC interrupt
>> handling for Keystone II devices, the kernel will reboot if the error
>> is 2-bit error for DDR ECC or L1/L2 ECC error.
>>
>> Signed-off-by: Hao Zhang <hzhang@ti.com>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> ---
>>   arch/arm/mach-keystone/Makefile       |  2 +-
>>   arch/arm/mach-keystone/keystone.c     | 63 ++++++++++++++++++++++++--
>>   arch/arm/mach-keystone/keystone.h     |  1 +
>>   arch/arm/mach-keystone/keystone_ecc.c | 85
>> +++++++++++++++++++++++++++++++++++
>>   arch/arm/mach-keystone/platsmp.c      |  3 +-
>>   5 files changed, 148 insertions(+), 6 deletions(-)
>>   create mode 100644 arch/arm/mach-keystone/keystone_ecc.c
>>

>>
>> @@ -49,6 +54,56 @@ static int keystone_platform_notifier(struct
>> notifier_block *nb,
>>       return NOTIFY_OK;
>>   }
>>
> +RMK. Would like to know if he wish to have below code in
> generic ARM code
>
>> +#define L2_INTERN_ASYNC_ERROR  BIT(30)
>> +
>> +static irqreturn_t arm_l1l2_ecc_err_irq_handler(int irq, void *reg_virt)
>> +{
>> +    int ret = IRQ_NONE;
>> +    u32 status, fault;
>> +
>> +    /* read and clear L2ECTLR CP15 register for L2 ECC error */
>> +    asm("mrc p15, 1, %0, c9, c0, 3" : "=r"(status));
>> +
>> +    if (status & L2_INTERN_ASYNC_ERROR) {
>> +        status &= ~L2_INTERN_ASYNC_ERROR;
>> +        asm("mcr p15, 1, %0, c9, c0, 3" : : "r" (status));
>> +        asm("mcr p15, 0, %0, c5, c1, 0" : "=r" (fault));
>> +        /*
>> +         * Do a machine restart as this is double bit ECC error
>> +         * that can't be corrected
>> +         */
>> +        pr_err("ARM Cortex A15 L1/L2 ECC error, CP15 ADFSR 0x%x\n",
>> +               fault);
>> +        machine_restart(NULL);
>> +        ret = IRQ_HANDLED;
>> +    }
>> +    return ret;
> So your non-double bit errors even though handled returns as IRQ_NONE.

looking at the A15 TRM, I see only single and double bit errors
are documented. There is no discussion about more than 2 bit errors.
Single bit errors don't raise an interrupt. So only case this gets 
called should be for double bit which is handled. So just log an error 
message as below and return IRQ_HANDLED?

pr_err("Unexpected ARM Cortex A15 L1/L2 multi bit error");

Murali

>
>> +}
>> +
>> +static int __init keystone_init_misc(void)


-- 
Murali Karicheri
Linux Kernel, Keystone
