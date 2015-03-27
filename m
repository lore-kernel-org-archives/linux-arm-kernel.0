From: slash.tmp@free.fr (Mason)
Date: Fri, 27 Mar 2015 21:33:41 +0100
Subject: Reading twd_base at run-time
In-Reply-To: <551586E6.3020200@arm.com>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
Message-ID: <5515BEA5.6040307@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heya,

On 27/03/2015 17:35, Marc Zyngier wrote:

> Hi Mason,
> 
> On 27/03/15 16:16, Mason wrote:
>
>> In arch/arm/kernel/smp_twd.c, twd_local_timer_register() receives a
>> struct twd_local_timer argument, which specifies
>>
>>    1) the physical address of twd_base
>>    2) the twd interrupt number
>>
>> There's a helper to fill out the static struct: DEFINE_TWD_LOCAL_TIMER()
>>
>> But it seems to me (please correct me if I'm wrong) that the address
>> of twd_base can be read at run-time, making it one less parameter to
>> specify by hand at compile-time (with the risk that a HW engineer
>> change the address in the next chip with no warning).
> 
> The main problem with that is that said HW engineer has ^%$%^%-up
> PERIPHBASE, and that you can't trust it. I've seen a number of these
> kicking around.

I don't understand your remark, perhaps mine was unclear?

The value of PERIPHBASE is left to the implementer, right?
So the HW engineer picks addrA for revA, then changes his
mind for revB, and picks addrB. No screw-up there, right?

The problem comes when said engineer forgets to notify the
grunts in software that they're supposed to change
#define PERIPH_BASE ADDR_A
to
#define PERIPH_BASE ADDR_B
in the header files for revB.

Looking up PERIPH_BASE at run-time through cp15 solves that
particular issue. Do you disagree?

>> Here's an incomplete patch to express my intent:
>>
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 6591e26..5177db8 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -369,14 +369,14 @@ out_free:
>>          return err;
>>   }
>>   
>> -int __init twd_local_timer_register(struct twd_local_timer *tlt)
>> +int __init twd_local_timer_register(void)
>>   {
>>          if (twd_base || twd_evt)
>>                  return -EBUSY;
>>   
>> -       twd_ppi = tlt->res[1].start;
>> +       twd_ppi = 29;
>>   
>> -       twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
>> +       twd_base = ioremap(scu_a9_get_base() + 0x600, 0x10);
>>          if (!twd_base)
>>                  return -ENOMEM;
>>   
>>
>> As far as I can tell, all platforms use 29 for twd_ppi, but I can make
>> sure if people agree this patch is indeed an improvement.
> 
> I don't think we'll see that many new platforms not using DT, so this
> would effectively remove one line from the helper, and generate a bit of
> churn on platforms that are usually left in a dusty corner...

OK, I understand your point about what is now considered
"legacy" code. I suppose it might even be removed in the
not-too-distant future?

That being said, the principle stands for the of function!

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 172c6a05..94fb0cd 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -391,13 +391,13 @@ static void __init twd_local_timer_of_register(struct device_node *np)
        if (!is_smp() || !setup_max_cpus)
                return;
 
-       twd_ppi = irq_of_parse_and_map(np, 0);
+       twd_ppi = 29;
        if (!twd_ppi) {
                err = -EINVAL;
                goto out;
        }
 
-       twd_base = of_iomap(np, 0);
+       twd_base = ioremap(scu_a9_get_base() + 0x600, 0x10);
        if (!twd_base) {
                err = -ENOMEM;
                goto out;


By the way, have you seen my other thread?
("Dropping "depends on SMP" for HAVE_ARM_TWD")
I CCed you as the author of twd_local_timer_of_register.

Regards.
