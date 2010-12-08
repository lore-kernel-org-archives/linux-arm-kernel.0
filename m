From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 15:23:29 +0000
Subject: [PATCH v2 5/6] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <1291782501-3909-6-git-send-email-johlstei@codeaurora.org>
References: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>
	<1291782501-3909-6-git-send-email-johlstei@codeaurora.org>
Message-ID: <20101208152329.GI9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 08:28:20PM -0800, Jeff Ohlstein wrote:
> +static inline void cpu_enter_lowpower(void)
> +{
> +	flush_cache_all();
> +}
> +
> +static inline void cpu_leave_lowpower(void)
> +{
> +	pen_release = -1;
> +	smp_wmb();
> +}
> +
> +static inline void platform_do_lowpower(unsigned int cpu)
> +{
> +	/* Just enter wfe for now. */
> +	for (;;) {
> +		asm("wfe");
> +		if (pen_release == cpu) {
> +			/*
> +			 * OK, proper wakeup, we're done
> +			 */
> +			break;
> +		}
> +		smp_rmb();
> +
> +		/*
> +		 * getting here, means that we have come out of WFI without
> +		 * having been woken up - this shouldn't happen
> +		 *
> +		 * The trouble is, letting people know about this is not really
> +		 * possible, since we are currently running incoherently, and
> +		 * therefore cannot safely call printk() or anything else
> +		*/
> +		pr_debug("CPU%u: spurious wakeup call\n", cpu);
> +	}
> +}

BTW, just because Realview and Versatile Express implement their hotplug
CPU tihs way, does not mean that you have to as well.  If you can put the
CPU to sleep properly without keeping it in the kernel, that would be far
more preferable, than having platform_cpu_die() return on hot-plugging.
