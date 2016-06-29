From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 29 Jun 2016 17:49:08 +0200
Subject: [PATCH] xen/arm: register clocks used by the hypervisor
In-Reply-To: <576AAE36.9070501@arm.com>
References: <1466504165-9214-1-git-send-email-dirk.behme@de.bosch.com>
 <576AAE36.9070501@arm.com>
Message-ID: <143393c4-739a-6e29-cbfa-128fdfcb1ed0@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 22.06.2016 17:26, Julien Grall wrote:
> Hello Dirk,
>
> On 21/06/16 11:16, Dirk Behme wrote:
>> Some clocks might be used by the Xen hypervisor and not by the Linux
>> kernel. If these are not registered by the Linux kernel, they might be
>> disabled by clk_disable_unused() as the kernel doesn't know that they
>> are used. The clock of the serial console handled by Xen is one
>> example for this. It might be disabled by clk_disable_unused() which
>> stops the whole serial output, even from Xen, then.
>>
>> Up to now, the workaround for this has been to use the Linux kernel
>> command line parameter 'clk_ignore_unused'. See Xen bug
>>
>> http://bugs.xenproject.org/xen/bug/45
>>
>> too.
>>
>> To fix this, we will add the "unused" clocks in Xen to the hypervisor
>> node. The Linux kernel has to register the clocks from the hypervisor
>> node, then.
>>
>> Therefore, check if there is a "clocks" entry in the hypervisor node
>> and if so register the given clocks to the Linux kernel clock
>> framework and with this mark them as used. This prevents the clocks
>> from being disabled.
>
> This new property would need to be documented in:
>    - linux/Documentation/devicetree/bindings/arm/xen.txt
>    - xen/docs/misc/arm/device-tree/guest.txt


Yes, as already discussed, I'll have a look to that.


>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>>   arch/arm/xen/enlighten.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> index 75cd734..ee6e81f 100644
>> --- a/arch/arm/xen/enlighten.c
>> +++ b/arch/arm/xen/enlighten.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/of_address.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/cpuidle.h>
>>   #include <linux/cpufreq.h>
>>   #include <linux/cpu.h>
>> @@ -381,6 +382,40 @@ static int __init xen_pm_init(void)
>>   }
>>   late_initcall(xen_pm_init);
>>
>> +/*
>> + * Check if we want to register some clocks, that they
>> + * are not freed because unused by clk_disable_unused().
>> + * E.g. the serial console clock.
>> + */
>> +static int __init xen_arm_register_clks(void)
>> +{
>> +    struct clk *clk;
>> +    unsigned int i, count;
>> +    int ret;
>> +
>> +    count = of_clk_get_parent_count(xen_node);
>
> The code in this file has changed quite a lot with the support of ACPI.
> For instance "xen_node" is not anymore a global variable. Can you rebase
> your rework on top of the branch for-linus-4.8?
>
> You can find the branch in:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git


I'll have a look to that, too. Thanks!

Hopefully it won't be too complicated to rebase ;)


>> +    if (!count)
>> +        return 0;
>> +
>> +    for (i = 0; i < count; i++) {
>> +        clk = of_clk_get(xen_node, i);
>> +        if (IS_ERR(clk)) {
>> +            pr_err("Xen failed to register clock %i. Error: %li\n",
>> +                   i, PTR_ERR(clk));
>> +            return PTR_ERR(clk);
>> +        }
>> +
>> +        ret = clk_prepare_enable(clk);
>
> I am not sure why we would want Linux to enable the clock. Should not it
> be already done either by the firmware or Xen?


After having a closer look to that, my understanding:

We have to call clk_prepare(clk) and clk_enable(clk) in this order (and 
clk_prepare_enable() does this in one call) to get the enable count 
incremented

http://lxr.free-electrons.com/source/drivers/clk/clk.c#L751

to prevent clk_disable_unused() to disable this clock.

That does mean that yes, you are right, the (hw-) clock itself is 
already enabled by the firmware or Xen. But we are not really interested 
in enabling the clock, here, but get the Linux kernel's enable_count 
incremented.


> Would it be possible to use the flags CLK_IGNORE_UNUSED instead? So the
> clock will be ignored by clk_disable_unused_subtree.


Yes, using CLK_IGNORE_UNUSED is an option. But ;)

But we can't set it directly in enlighten.c as we can't access the flags 
part of the clock structs from outside the core clock code.

That would mean that we have to to set the clock flags in the device 
tree. What would mean that for each clock we don't want to be disabled 
we have to manipulate the root clock entry of that clock in the device 
tree. While that would be possible, it doesn't sound that easy and I 
wonder if that wouldn't be too complicated to be done in Xen (?)


You will correct me if I'm wrong ;)


Many thanks!

Dirk
