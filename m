From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 8 Jul 2016 08:48:40 +0200
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <146776885213.35356.11565744417822933094@resonance>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <146776885213.35356.11565744417822933094@resonance>
Message-ID: <20733b68-9529-bdb9-2a7d-576c8193f15c@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06.07.2016 03:34, Michael Turquette wrote:
> Hi!
>
> Quoting Dirk Behme (2016-06-30 03:32:32)
>> Some clocks might be used by the Xen hypervisor and not by the Linux
>> kernel. If these are not registered by the Linux kernel, they might be
>> disabled by clk_disable_unused() as the kernel doesn't know that they
>> are used. The clock of the serial console handled by Xen is one
>> example for this. It might be disabled by clk_disable_unused() which
>> stops the whole serial output, even from Xen, then.
>
> This whole thread had me confused until I realized that it all boiled
> down to some nomenclature issues (for me).
>
> This code does not _register_ any clocks. It simply gets them and
> enables them, which is what every other clk consumer in the Linux kernel
> does. More details below.
>
>>
>> Up to now, the workaround for this has been to use the Linux kernel
>> command line parameter 'clk_ignore_unused'. See Xen bug
>>
>> http://bugs.xenproject.org/xen/bug/45
>
> clk_ignore_unused is a band-aid, not a proper medical solution. Setting
> that flag will not turn clocks on for you, nor will it guarantee that
> those clocks are never turned off in the future. It looks like you
> figured this out correctly in the patch below but it is worth repeating.
>
> Also the new CLK_IS_CRITICAL flag might be of interest to you, but that
> flag only exists as a way to enable clocks that must be enabled for the
> system to function (hence, "critical") AND when those same clocks do not
> have an accompanying Linux driver to consume them and enable them.
>
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
>>  - Rebase against git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.8
>>  - Add changes to Documentation/devicetree/bindings/arm/xen.txt
>>
>>  Documentation/devicetree/bindings/arm/xen.txt | 11 +++++++
>>  arch/arm/xen/enlighten.c                      | 47 +++++++++++++++++++++++++++
>>  2 files changed, 58 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
>> index c9b9321..55dfd3b 100644
>> --- a/Documentation/devicetree/bindings/arm/xen.txt
>> +++ b/Documentation/devicetree/bindings/arm/xen.txt
>> @@ -17,6 +17,17 @@ the following properties:
>>    A GIC node is also required.
>>    This property is unnecessary when booting Dom0 using ACPI.
>>
>> +Optional properties:
>> +
>> +- clocks: one or more clocks to be registered.
>
> s/registered/consumed/
>
> For appropriate DT binding script to steal I picked one at random:
>
> Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>
>> +  Xen hypervisor drivers might replace native drivers, resulting in
>> +  clocks not registered by these native drivers. To avoid that these
>> +  unregistered clocks are disabled, then, e.g. by clk_disable_unused(),
>> +  register them in the hypervisor node.
>> +  An example for this are the clocks of the serial driver. If the clocks
>> +  used by the serial hardware interface are not registered by the serial
>> +  driver the serial output might stop once clk_disable_unused() is called.
>> +
>>  To support UEFI on Xen ARM virtual platforms, Xen populates the FDT "uefi" node
>>  under /hypervisor with following parameters:
>>
>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> index 47acb36..5c546d0 100644
>> --- a/arch/arm/xen/enlighten.c
>> +++ b/arch/arm/xen/enlighten.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/of_fdt.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/of_address.h>
>> +#include <linux/clk-provider.h>
>
> s/clk-provider.h/clk.h/
>
> clk-provider.h is only used for providers and this bit of code is a
> consumer.


It seems we need clk-provider.h for of_clk_get_parent_count()?


>>  #include <linux/cpuidle.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/cpu.h>
>> @@ -444,6 +445,52 @@ static int __init xen_pm_init(void)
>>  }
>>  late_initcall(xen_pm_init);
>>
>> +/*
>> + * Check if we want to register some clocks, that they
>> + * are not freed because unused by clk_disable_unused().
>> + * E.g. the serial console clock.
>> + */
>> +static int __init xen_arm_register_clks(void)
>> +{
>> +       struct clk *clk;
>> +       struct device_node *xen_node;
>> +       unsigned int i, count;
>> +       int ret = 0;
>> +
>> +       xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
>> +       if (!xen_node) {
>> +               pr_err("Xen support was detected before, but it has disappeared\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       count = of_clk_get_parent_count(xen_node);
>> +       if (!count)
>> +               goto out;
>> +
>> +       for (i = 0; i < count; i++) {
>> +               clk = of_clk_get(xen_node, i);
>
> Is there a struct device we can use here?


It doesn't look so. Julien?


> It would be better to use
> devm_clk_get if possible.


Best regards

Dirk
