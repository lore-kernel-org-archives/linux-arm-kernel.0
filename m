From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 19:15:27 +0100
Subject: [PATCH] ARM: EXYNOS4: Add support AFTR mode on EXYNOS4210
In-Reply-To: <1310118235-17543-1-git-send-email-jc.lee@samsung.com>
References: <1310118235-17543-1-git-send-email-jc.lee@samsung.com>
Message-ID: <20110708181527.GN4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 06:43:55PM +0900, Jaecheol Lee wrote:
> This patch adds support AFTR(ARM OFF TOP RUNNING) mode in
> cpuidle driver. L2 cache keeps their data in this mode.

This conflicts with my suspend branch.  Please wait until after the
merge window for this patch.

> +void exynos4_cpu_lp(unsigned long arg)

Should be 'static int' now.

> +static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> +				  struct cpuidle_state *state)
> +{
> +	struct cpuidle_state *new_state = state;
> +
> +	/* This mode only can be entered when Core1 is offline */
> +	if (cpu_online(1)) {

What if you had a four code exynos4 tomorrow?

Presumably you actually mean: "can only be entered when other CPUs are
offline" so that should be:
	if (num_cpus_online() != 1) {

> +
> +	l2cc_save[0] = __raw_readl(S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
> +	l2cc_save[1] = __raw_readl(S5P_VA_L2CC + L2X0_POWER_CTRL);
> +	l2cc_save[2] = __raw_readl(S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
> +	l2cc_save[3] = __raw_readl(S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
> +	l2cc_save[4] = __raw_readl(S5P_VA_L2CC + L2X0_AUX_CTRL);
> +
> +	clean_dcache_area(&l2cc_save[0], 5 * sizeof(unsigned long));
> +	outer_clean_range(virt_to_phys(&l2cc_save[0]),
> +			  virt_to_phys(&l2cc_save[4] + sizeof(unsigned long)));

Erm, this is bad news, using internal APIs for this, especially
'clean_dcache_area' which may well become a no-op on systems with
TLBs which can read out of L1 cache...
