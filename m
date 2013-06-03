From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 03 Jun 2013 10:14:24 +0200
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
In-Reply-To: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
References: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <51AC5060.80806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2013 12:44 PM, Sanjay Singh Rawat wrote:
> The current code considers every wakeup as spurious, which is not
> correct. Handle the same way as other arm platforms are doing.
> 
> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  arch/arm/mach-zynq/hotplug.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
> index c89672b..a1ab22c 100644
> --- a/arch/arm/mach-zynq/hotplug.c
> +++ b/arch/arm/mach-zynq/hotplug.c
> @@ -67,6 +67,13 @@ static inline void zynq_platform_do_lowpower(unsigned int cpu, int *spurious)
>  		dsb();
>  		wfi();
>  
> +		if (pen_release == cpu_logical_map(cpu)) {
> +			/*
> +			 * OK, proper wakeup, we're done
> +			 */
> +			break;
> +		}
> +
>  		/*
>  		 * Getting here, means that we have come out of WFI without
>  		 * having been woken up - this shouldn't happen
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
