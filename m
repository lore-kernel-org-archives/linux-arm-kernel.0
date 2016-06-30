From: dirk.behme@gmail.com (Dirk Behme)
Date: Thu, 30 Jun 2016 16:56:40 +0200
Subject: [Xen-devel] [PATCH v2] xen/arm: register clocks used by the
 hypervisor
In-Reply-To: <20160630142136.GE20363@leverpostej>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <20160630142136.GE20363@leverpostej>
Message-ID: <57753328.9060300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.06.2016 16:21, Mark Rutland wrote:
> On Thu, Jun 30, 2016 at 12:32:32PM +0200, Dirk Behme wrote:
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
>>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>> Changes in v2:
>>   - Rebase against git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.8
>>   - Add changes to Documentation/devicetree/bindings/arm/xen.txt
>>
>>   Documentation/devicetree/bindings/arm/xen.txt | 11 +++++++
>>   arch/arm/xen/enlighten.c                      | 47 +++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
>> index c9b9321..55dfd3b 100644
>> --- a/Documentation/devicetree/bindings/arm/xen.txt
>> +++ b/Documentation/devicetree/bindings/arm/xen.txt
>> @@ -17,6 +17,17 @@ the following properties:
>>     A GIC node is also required.
>>     This property is unnecessary when booting Dom0 using ACPI.
>>
>> +Optional properties:
>> +
>> +- clocks: one or more clocks to be registered.
>> +  Xen hypervisor drivers might replace native drivers, resulting in
>> +  clocks not registered by these native drivers. To avoid that these
>> +  unregistered clocks are disabled, then, e.g. by clk_disable_unused(),
>> +  register them in the hypervisor node.
>> +  An example for this are the clocks of the serial driver. If the clocks
>> +  used by the serial hardware interface are not registered by the serial
>> +  driver the serial output might stop once clk_disable_unused() is called.
>
> This shouldn't be described in terms of the Linux implementation details
> like clk_disable_unused. Those can change at any time, and don't define
> the contract as such.


Ok. I remove that from the description. Thanks!


> What exactly is the contract here? I assume that you don't want the
> kernel to alter the state of these clocks in any way,


I don't think so. I think what we want is that the kernel just don't 
disable the (from kernel's point of view) "unused" clocks. I think we 
get this from the fact that using 'clk_ignore_unused' is a working 
workaround for this issue.


> e.g. the rate
> cannot be changed, they must be left always on, parent clocks cannot be
> altered if that would result in momentary jitter.
>
> I suspect it may be necessary to do more to ensure that, but I'm not
> familiar enough with the clocks subsystem to say.
 >
> Are we likely to need to care about regulators, GPIOs, resets, etc? I
> worry that this may be the tip of hte iceberg


I don't think so. If there is a user in the kernel of the clock, fine. 
Then hopefully the user in the kernel knows what he is doing with the 
clock and then he should do what ever he wants. As there is a user in 
the kernel, we don't have to care about 'accidentally' disabling it.

Just let us care about the clocks there is no user.

Best regards

Dirk


>> +
>>   To support UEFI on Xen ARM virtual platforms, Xen populates the FDT "uefi" node
>>   under /hypervisor with following parameters:
>>
>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> index 47acb36..5c546d0 100644
>> --- a/arch/arm/xen/enlighten.c
>> +++ b/arch/arm/xen/enlighten.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/of_fdt.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/of_address.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/cpuidle.h>
>>   #include <linux/cpufreq.h>
>>   #include <linux/cpu.h>
>> @@ -444,6 +445,52 @@ static int __init xen_pm_init(void)
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
>> +	struct clk *clk;
>> +	struct device_node *xen_node;
>> +	unsigned int i, count;
>> +	int ret = 0;
>> +
>> +	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
>> +	if (!xen_node) {
>> +		pr_err("Xen support was detected before, but it has disappeared\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	count = of_clk_get_parent_count(xen_node);
>> +	if (!count)
>> +		goto out;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		clk = of_clk_get(xen_node, i);
>> +		if (IS_ERR(clk)) {
>> +			pr_err("Xen failed to register clock %i. Error: %li\n",
>> +			       i, PTR_ERR(clk));
>> +			ret = PTR_ERR(clk);
>> +			goto out;
>> +		}
>> +
>> +		ret = clk_prepare_enable(clk);
>> +		if (ret < 0) {
>> +			pr_err("Xen failed to enable clock %i. Error: %i\n",
>> +			       i, ret);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	ret = 0;
>> +
>> +out:
>> +	of_node_put(xen_node);
>> +	return ret;
>> +}
>> +late_initcall(xen_arm_register_clks);
>>
>>   /* empty stubs */
>>   void xen_arch_pre_suspend(void) { }
>> --
>> 2.8.0
>>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
>
