From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 10:04:44 +0100
Subject: [PATCH 1/5] ARM: Add platform support for LSI AXM55xx SoC
In-Reply-To: <80a2523d3e266ed12d5b70ac5518e963e47b27f4.1397552154.git.anders.berg@lsi.com>
References: <cover.1397552154.git.anders.berg@lsi.com>
 <80a2523d3e266ed12d5b70ac5518e963e47b27f4.1397552154.git.anders.berg@lsi.com>
Message-ID: <20140424090444.GF26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:06:10PM +0200, Anders Berg wrote:
> +	adr	r4, 2f
> +	ldmia	r4, {r5, r6}
> +	sub	r4, r4, r5
> +	add	r6, r6, r4
> +1:	ldr	r7, [r6]
> +	cmp	r7, r0
> +	wfene
> +	bne	1b
...
> +2:	.long	.
> +	.long	pen_release
> diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
...
> +/*
> + * Write pen_release in a way that is guaranteed to be visible to all
> + * observers, irrespective of whether they're taking part in coherency
> + * or not.  This is necessary for the hotplug code to work reliably.
> + */
> +static void write_pen_release(int val)
> +{
> +	pen_release = val;
> +	/* Make sure this store is visible to other CPUs */
> +	smp_wmb();
> +	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
> +}

Do you /really/ need to do this pen_release thing on your platform?

> +static void __init axxia_smp_prepare_cpus(unsigned int max_cpus)
> +{
...
> +		/*
> +		 * Release all physical cpus when not in hyp mode since we
> +		 * might want to bring them online later.
> +		 *
> +		 * Also we need to get the execution into kernel code (it's
> +		 * currently executing in u-boot).  u-boot releases the cores
> +		 * from reset in hyp mode.
> +		 */
> +		if (!is_hyp_mode_available()) {
> +			if (cpu != 0) {
> +				u32 tmp = readl(syscon + 0x1010);
> +				writel(0xab, syscon + 0x1000);
> +				tmp &= ~(1 << cpu);
> +				writel(tmp, syscon + 0x1010);
> +			}

As this implies that you can control the release of each CPU from u-boot
individually.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
