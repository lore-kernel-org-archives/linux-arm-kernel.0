From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Nov 2016 20:20:00 +0000
Subject: [PATCH v16 14/15] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
In-Reply-To: <1479304148-2965-15-git-send-email-fu.wei@linaro.org>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-15-git-send-email-fu.wei@linaro.org>
Message-ID: <20161118202000.GP1197@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 09:49:07PM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch add memory-mapped timer register support by using the
> information provided by the new GTDT driver of ACPI.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index c494ca8..0aad60a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1067,7 +1067,28 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>  		       arch_timer_mem_of_init);
>  
>  #ifdef CONFIG_ACPI_GTDT
> -/* Initialize per-processor generic timer */
> +static int __init arch_timer_mem_acpi_init(void)
> +{
> +	struct arch_timer_mem *timer_mem;
> +	int ret = 0;
> +	int i = 0;
> +
> +	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);

Why do you need it zeroed? You don't clear it between iterations, so
either you don't need this, or you have a bug in the loop.

> +	if (!timer_mem)
> +		return -ENOMEM;
> +
> +	while (!gtdt_arch_timer_mem_init(timer_mem, i)) {

Huh?

Why doesn't GTDT expose a function to fill in the entire arch_timer_mem
in one go?

There shouldn't be multiple instances, as far as I am aware. Am I
mistaken?

> +		ret = arch_timer_mem_init(timer_mem);
> +		if (ret)
> +			break;
> +		i++;
> +	}
> +
> +	kfree(timer_mem);
> +	return ret;
> +}


Regardless, arch_timer_mem is small enough that you don't need dynamic
allocaiton. Just put it on the stack, e.g.

static int __init arch_timer_mem_acpi_init(void)
{
	int i = 0;
	struct arch_timer_mem timer_mem;

	while (!gtdt_arch_timer_mem_init(timer_mem, i)) {
		int ret = arch_timer_mem_init();
		if (ret)
			return ret;
		i++
	}

	return 0;
}

Thanks,
Mark.
