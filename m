From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 12:22:50 -0400 (EDT)
Subject: [PATCH v6 4/4] ARM: Add KGDB/KDB FIQ debugger generic code
In-Reply-To: <1403623097-1153-5-git-send-email-daniel.thompson@linaro.org>
References: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-1-git-send-email-daniel.thompson@linaro.org>
 <1403623097-1153-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.LFD.2.11.1406241201180.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Daniel Thompson wrote:

> From: Anton Vorontsov <anton.vorontsov@linaro.org>
> 
> The FIQ debugger may be used to debug situations when the kernel stuck
> in uninterruptable sections, e.g. the kernel infinitely loops or
> deadlocked in an interrupt or with interrupts disabled.
> 
> By default KGDB FIQ is disabled in runtime, but can be enabled with
> kgdb_fiq.enable=1 kernel command line option.
> 
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm/Kconfig                 |   2 +
>  arch/arm/Kconfig.debug           |  18 ++++++
>  arch/arm/include/asm/kgdb.h      |   7 +++
>  arch/arm/kernel/Makefile         |   1 +
>  arch/arm/kernel/kgdb_fiq.c       | 124 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/kgdb_fiq_entry.S |  87 +++++++++++++++++++++++++++
>  6 files changed, 239 insertions(+)
>  create mode 100644 arch/arm/kernel/kgdb_fiq.c
>  create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S

[...]

> +static long kgdb_fiq_setup_stack(void *info)
> +{
> +	struct pt_regs regs;
> +
> +	regs.ARM_sp = __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER) +
> +			THREAD_START_SP;
> +	WARN_ON(!regs.ARM_sp);

Isn't this rather fatal if you can't allocate any stack? Why not using 
BUG_ON(), or better yet propagate a proper error code back?

> +
> +	set_fiq_regs(&regs);
> +	return 0;
> +}
> +
> +/**
> + * kgdb_fiq_enable_nmi - Manage NMI-triggered entry to KGDB
> + * @on: Flag to either enable or disable an NMI
> + *
> + * This function manages NMIs that usually cause KGDB to enter. That is, not
> + * all NMIs should be enabled or disabled, but only those that issue
> + * kgdb_handle_exception().
> + *
> + * The call counts disable requests, and thus allows to nest disables. But
> + * trying to enable already enabled NMI is an error.
> + */
> +static void kgdb_fiq_enable_nmi(bool on)
> +{
> +	static atomic_t cnt;
> +	int ret;
> +
> +	ret = atomic_add_return(on ? 1 : -1, &cnt);
> +	if (ret > 1 && on) {
> +		/*
> +		 * There should be only one instance that calls this function
> +		 * in "enable, disable" order. All other users must call
> +		 * disable first, then enable. If not, something is wrong.
> +		 */
> +		WARN_ON(1);
> +		return;
> +	}

Minor style suggestion:

	/*
	 * There should be only one instance that calls this function
	 * in "enable, disable" order. All other users must call
	 * disable first, then enable. If not, something is wrong.
	 */
	if (WARN_ON(ret > 1 && on))
		return;

Other than that...

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
