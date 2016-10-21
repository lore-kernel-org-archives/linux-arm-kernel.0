From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 12:32:13 +0100
Subject: [PATCH v14 7/9] clocksource/drivers/arm_arch_timer: Refactor the
 timer init code to prepare for GTDT
In-Reply-To: <1475086637-1914-8-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-8-git-send-email-fu.wei@linaro.org>
Message-ID: <20161021113213.GD16630@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 02:17:15AM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch refactor original memory-mapped timer init code:
> (1) extract some subfunction for reusing some common code
>     a. get_cnttidr
>     b. is_best_frame
> (2) move base address and irq code for arch_timer_mem to
> arch_timer_mem_register
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 159 +++++++++++++++++++++--------------
>  1 file changed, 96 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index c7b0040..e78095f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -57,6 +57,7 @@
>  static unsigned arch_timers_present __initdata;
>  
>  static void __iomem *arch_counter_base;
> +static void __iomem *cntctlbase __initdata;
>  
>  struct arch_timer {
>  	void __iomem *base;
> @@ -656,15 +657,49 @@ out:
>  	return err;
>  }
>  
> -static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
> +static int __init arch_timer_mem_register(struct device_node *np, void *frame)
>  {
> -	int ret;
> -	irq_handler_t func;
> +	struct device_node *frame_node = NULL;
>  	struct arch_timer *t;
> +	void __iomem *base;
> +	irq_handler_t func;
> +	unsigned int irq;
> +	int ret;
> +
> +	if (!frame)
> +		return -EINVAL;

Why would we call this without a frame?

> +
> +	if (np) {

... or without a node?

> +		frame_node = (struct device_node *)frame;
> +		base = of_iomap(frame_node, 0);
> +		arch_timer_detect_rate(base, np);

... BANG! (we check base too late, below).

Please as Marc requested several versions ago: split the FW parsing
(ACPI and DT) so that happens first, *then* once we have the data in a
common format, use that to drive poking the HW, requesting IRQs, etc,
completely independent of the source.

In patches, do this by:

(1) adding the data structures
(2) splitting the existing DT probing to use them
(3) Adding ACPI functionality atop

> -static int __init arch_timer_mem_init(struct device_node *np)
> +static int __init get_cnttidr(struct device_node *np, u32 *cnttidr)
>  {
> -	struct device_node *frame, *best_frame = NULL;
> -	void __iomem *cntctlbase, *base;
> -	unsigned int irq, ret = -EINVAL;
> -	u32 cnttidr;
> +	if (!cnttidr)
> +		return -EINVAL;
> +
> +	if (np)
> +		cntctlbase = of_iomap(np, 0);
> +	else
> +		return -EINVAL;

We want to check this for ACPI too, no?

Thanks,
Mark.
