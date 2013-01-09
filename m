From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 9 Jan 2013 13:13:11 +0530
Subject: [v2 5/9] clocksource: tegra: Enable ARM arch_timer with TSC
In-Reply-To: <20130109.075708.1662067562960541635.hdoyu@nvidia.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com><1357649263-1098-6-git-send-email-hdoyu@nvidia.com><50EC444B.5060206@arm.com>
 <20130109.075708.1662067562960541635.hdoyu@nvidia.com>
Message-ID: <50ED1F8F.4060700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 11:27 AM, Hiroshi Doyu wrote:
> Hi Marc,
>
> Marc Zyngier <marc.zyngier@arm.com> wrote @ Tue, 8 Jan 2013 17:07:39 +0100:
>
>> On 08/01/13 12:47, Hiroshi Doyu wrote:
>>> Add platform enabler for ARM arch_timer(TSC). TSC is more fine grained
>>> timer than TMR0. If it's available, it will be used for clock source
>>> and sched_clock. Otherwise, TMR0 is used. In any case TMR0 is
>>> necessary for clock event.
>>>
>>> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
>>> ---
>>>   .../bindings/arm/tegra/nvidia,tegra114-tsc.txt     |   11 ++++
>>>   drivers/clocksource/tegra20_timer.c                |   65 +++++++++++++++++++-
>>>   2 files changed, 75 insertions(+), 1 deletion(-)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-tsc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-tsc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-tsc.txt
>>> new file mode 100644
>>> index 0000000..9de936a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-tsc.txt
>>> @@ -0,0 +1,11 @@
>>> +NVIDIA Tegra Timer Stamp Counter(TSC)
>>> +
>>> +Required properties:
>>> +- compatible : "nvidia,tegra114-tsc
>>> +- reg : Should contain 1 register ranges(address and length)
>>> +
>>> +Example:
>>> +	tsc {
>>> +		compatible = "nvidia,tegra114-tsc";
>>> +		reg = <0x700f0000 0x20000>;
>>> +	};
>>> diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
>>> index 1d25de8..564266d 100644
>>> --- a/drivers/clocksource/tegra20_timer.c
>>> +++ b/drivers/clocksource/tegra20_timer.c
>>> @@ -30,6 +30,7 @@
>>>   #include <asm/mach/time.h>
>>>   #include <asm/smp_twd.h>
>>>   #include <asm/sched_clock.h>
>>> +#include <asm/arch_timer.h>
>>>
>>>   #define RTC_SECONDS            0x08
>>>   #define RTC_SHADOW_SECONDS     0x0c
>>> @@ -271,10 +272,72 @@ static void __init tegra20_init_tmr(void)
>>>   	clockevents_register_device(&tegra_clockevent);
>>>   }
>>>
>>> +#define TSC_CNTCR		0		/* TSC control registers */
>>> +#define TSC_CNTCR_ENABLE	(1 << 0)	/* Enable */
>>> +#define TSC_CNTCR_HDBG		(1 << 1)	/* Halt on debug */
>>> +
>>> +#define TSC_CNTCV0		0x8		/* TSC counter (LSW) */
>>> +#define TSC_CNTCV1		0xc		/* TSC counter (MSW) */
>>> +#define TSC_CNTFID0		0x20		/* TSC freq id 0 */
>>> +
>>> +static const struct of_device_id tegra_tsc_match[] __initconst = {
>>> +	{ .compatible = "nvidia,tegra114-tsc" },
>>> +	{}
>>> +};
>>> +
>>> +/* FIXME: only secure mode is supported. */
>>
>> And this is a bug, as far as I'm concerned.
>>
>>> +static int tegra_arch_timer_init(void)
>>> +{
>>> +	int err;
>>> +	struct device_node *np;
>>> +	struct clk *clk;
>>> +	void __iomem *tsc_base;
>>> +	u32 freq, val;
>>> +
>>> +	np = of_find_matching_node(NULL, tegra_tsc_match);
>>> +	if (!np)
>>> +		return -ENODEV;
>>> +
>>> +	tsc_base = of_iomap(np, 0);
>>> +	if (!tsc_base)
>>> +		return -ENODEV;
>>> +
>>> +	clk = clk_get_sys("clk_m", NULL);
>>> +	if (IS_ERR(clk)) {
>>> +		freq = 12000000;
>>> +		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
>>> +	} else {
>>> +		freq = clk_get_rate(clk);
>>> +		clk_put(clk);
>>> +	}
>>> +	writel_relaxed(freq, tsc_base + TSC_CNTFID0);
>>> +
>>> +	/* CNTFRQ */
>>> +	asm("mcr p15, 0, %0, c14, c0, 0\n" : : "r" (freq));
>>> +	asm("mrc p15, 0, %0, c14, c0, 0\n" : "=r" (val));
>>> +	BUG_ON(val != freq);
>>
>> No, not again! Like I said last year, this won't fly. So instead of
>> trying to work around a broken firmware, let's do the right thing.
>>
>>> +
>>> +	val = readl_relaxed(tsc_base + TSC_CNTCR);
>>> +	val |= TSC_CNTCR_ENABLE | TSC_CNTCR_HDBG;
>>> +	writel_relaxed(val, tsc_base + TSC_CNTCR);
>>> +
>>> +	err = arch_timer_of_register();
>>
>> What about adding an optional property to the binding, pointing to the
>> required clock? That would solve the above problem in a sensible way,
>> and your kernel wouldn't go bust.
>
> Could you explain a bit more? We have the follwing DT entries related to this:
>
> 	tsc {
> 		compatible = "nvidia,tegra114-tsc";
> 		reg = <0x700f0000 0x20000>;
> 	};
>
> 	...
>
> 	timer {
> 		compatible = "arm,armv7-timer";
> 		interrupts = <1 13 0xf08>,
> 			     <1 14 0xf08>,
> 			     <1 11 0xf08>,
> 			     <1 10 0xf08>;
> 	};
>
Arch timer frequency can be specified in DT since the code
already has provision to extract it. Below is extract
from OMAP5 DT code.

timer {
                                 compatible = "arm,armv7-timer";

                                 interrupts = <1 14 0x308>;
                                 clock-frequency = <6144000>;
                         };

I think thats what Marc is pointing out.

Regards
Santosh
