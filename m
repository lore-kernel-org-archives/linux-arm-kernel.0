From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Jun 2011 11:39:59 +0100
Subject: [RFC PATCH 4/4] ARM: dt: Add TWD bindings and driver support
In-Reply-To: <20110626080902.GA24241@ponder.secretlab.ca>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
	<1308924659-31894-5-git-send-email-marc.zyngier@arm.com>
	<20110626080902.GA24241@ponder.secretlab.ca>
Message-ID: <4E085DFF.9010600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/11 09:09, Grant Likely wrote:
> On Fri, Jun 24, 2011 at 03:10:59PM +0100, Marc Zyngier wrote:
>> Add device tree support to the arm_smp_twd driver.
>>
>> The DT bindings for the TWD are defined as such:
>> - one timer node per CPU, using corresponding PPI
>>   interrupt controller
>> - provides both timer and watchdog interrupt
>>
>> Tested on RealView PB11MPCore and VExpress.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/twd.txt |   54 ++++++++++++++
>>  drivers/clocksource/arm_smp_twd.c             |   92 +++++++++++++++++++++---
>>  2 files changed, 134 insertions(+), 12 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/twd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/arm/twd.txt
>> new file mode 100644
>> index 0000000..3823a81
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/twd.txt
>> @@ -0,0 +1,54 @@
>> +* ARM Timer Watchdog
>> +
>> +ARM SMP cores are often associated with a TWD providing a per-cpu timer
>> +and a per-cpu watchdog. Usually wired to the PPI interface of a GIC.
>> +
>> +Main node properties:
>> +
>> +- compatible		: "arm,smp-twd", "localtimer"
> 
> "localtimer" isn't a very good compatible value.  Compatible is
> intended to identify the specific hardware, and "localtimer" is a very
> generic name.

This is the early_device class name creeping in. I usually used the
"device_type" property, but been told this wasn't the right way...

Of course, if we get rid of the idea of early devices, this is a moot point.

> Also, as commented on for the gic, I'd like to see some level of
> versioning on the arm,smp-twd string.

There's only one version of TWD at the moment, so I guess I'll tie it to
the CPU core implementation, e.g: "arm,twd-11mpcore", "arm,twd-cortex-a9"...

>> +- reg			: register mapping for the registers.
>> +- #address-cells	: <1>
>> +- #size-cells		: <0>
>> +
>> +Timer sub nodes (one per CPU)
>> +
>> +- interrupt-parent	: phandle to the corresponding gic-ppi.
>> +- interrupts		: <IRQtimer IRQwatchdog> (usually <29 30>)
>> +- reg			: index of the CPU this timer is connected to.
>> +
>> +Example (ARM RealView PB11-MPCore):
>> +
>> +localtimer at 1f000600 {
>> +	compatible = "arm,smp-twd", "localtimer";
>> +	reg = <0x1f000600 0x100>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	/*
>> +	 * One timer per CPU, bound to the corresponding
>> +	 * PPI interface.
>> +	 */
>> +	timer at 0 {
>> +		interrupt-parent = <&gic0ppi0>;
>> +		interrupts = <29 30>;
>> +		reg = <0>;
>> +	};
>> +
>> +	timer at 1 {
>> +		interrupt-parent = <&gic0ppi1>;
>> +		interrupts = <29 30>;
>> +		reg = <1>;
>> +	};
>> +
>> +	timer at 2 {
>> +		interrupt-parent = <&gic0ppi2>;
>> +		interrupts = <29 30>;
>> +		reg = <2>;
>> +	};
>> +
>> +	timer at 3 {
>> +		interrupt-parent = <&gic0ppi3>;
>> +		interrupts = <29 30>;
>> +		reg = <3>;
>> +	};
>> +};
>> diff --git a/drivers/clocksource/arm_smp_twd.c b/drivers/clocksource/arm_smp_twd.c
>> index 65f4669..586acad 100644
>> --- a/drivers/clocksource/arm_smp_twd.c
>> +++ b/drivers/clocksource/arm_smp_twd.c
>> @@ -19,6 +19,9 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/ioport.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>>  #include <linux/clk.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/err.h>
>> @@ -37,11 +40,11 @@
>>  #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
>>  
>>  static void __iomem *twd_base;
>> -static int twd_ppi;
>>  
>>  static struct clk *twd_clk;
>>  static unsigned long twd_timer_rate;
>>  static DEFINE_PER_CPU(bool, irq_reqd);
>> +static DEFINE_PER_CPU(int, twd_irq);
>>  static struct clock_event_device __percpu *twd_evt;
>>  
>>  static void twd_set_mode(enum clock_event_mode mode,
>> @@ -223,7 +226,7 @@ static void __cpuinit twd_setup(void *data)
>>  	clk->rating = 450;
>>  	clk->set_mode = twd_set_mode;
>>  	clk->set_next_event = twd_set_next_event;
>> -	clk->irq = gic_ppi_to_vppi(twd_ppi);
>> +	clk->irq = __get_cpu_var(twd_irq);
>>  	clk->cpumask = cpumask_of(smp_processor_id());
>>  
>>  	pr_debug("Configuring %s on cpu #%d\n", clk->name, smp_processor_id());
>> @@ -290,31 +293,90 @@ static struct notifier_block __cpuinitdata twd_cpu_nb = {
>>  	.notifier_call = twd_cpu_notify,
>>  };
>>  
>> -static int twd_probe(struct platform_device *pdev)
>> +#ifdef CONFIG_OF
>> +static struct device_node *twd_get_timer_node(struct device_node *twd_np,
>> +					      struct device_node *child,
>> +					      int *timer_nr)
>> +{
>> +	child = of_get_next_child(twd_np, child);
>> +	if (child) {
>> +		const __be32 *reg;
>> +		reg = of_get_property(child, "reg", NULL);
>> +		if (!reg)
>> +			*timer_nr = -1;
>> +		else
>> +			*timer_nr = be32_to_cpu(*reg);
> 
> There's a new function that should be done and merged in time for
> v3.1 that will help with reading properties.  Keep an eye out for
> of_getprop_u32()

Yup, spotted. Will use it as soon as it appears in a tree nearby.

	M.
-- 
Jazz is not dead. It just smells funny...
