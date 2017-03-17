From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Mar 2017 19:05:42 +0000
Subject: [PATCH v21 04/13] clocksource: arm_arch_timer: split
 arch_timer_rate for different types of timer
In-Reply-To: <20170206185015.12296-5-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-5-fu.wei@linaro.org>
Message-ID: <20170317190539.GD15909@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 02:50:06AM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> Currently, arch_timer_rate is used to store the frequency got from per-cpu
> arch-timer or the memory-mapped (MMIO) timers. But those values come from
> different registers which should all be initialized by firmware.
> 
> This patch remove arch_timer_rate, and use arch_timer_sysreg_freq and
> arch_timer_mmio_freq instead.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Thanks for attacking this. Generally, I do think this is the right thing
to do.

However...

> @@ -1070,10 +1077,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
>  	 * Try to determine the frequency from the device tree,
>  	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
>  	 */
> -	if (!arch_timer_rate &&
> -	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
> -		arch_timer_rate = arch_timer_get_mmio_freq(base);
> -	if (!arch_timer_rate) {
> +	if (of_property_read_u32(np, "clock-frequency", &arch_timer_mmio_freq))
> +		arch_timer_mmio_freq = arch_timer_get_mmio_freq(base);
> +	if (!arch_timer_mmio_freq) {
>  		pr_err(FW_BUG "frequency not available for MMIO timer.\n");
>  		ret = -EINVAL;
>  		goto out;

... unfortunately, I believe that this will break some DT platforms that
have been (unintentionally) relying on the way currently allow the
frequency to be probed from either the MMIO timer or the sysreg timer.

So while the above was my suggestion, it was not my best.

For the timebeing, let's leave the single arch_timer_rate, but ensure
that it doesn't get in the way fo the ACPI code, by making the ACPI
probe path:

* Probe the sysreg timers first, using the sysreg cntfrq().

* Probe the MMIO timers second, verifying that each MMIO cntfrq matches
  the already-probed sysreg cntfrq.

... which is what I believe you suggested previously. 

Thanks,
Mark.
