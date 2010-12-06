From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 15:53:10 +0000
Subject: [PATCH v3] ARM: vexpress: add support for multiple core tiles
In-Reply-To: <1291052921-30695-1-git-send-email-will.deacon@arm.com>
References: <1291052921-30695-1-git-send-email-will.deacon@arm.com>
Message-ID: <20101206155310.GG31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 05:48:41PM +0000, Will Deacon wrote:
> The current Versatile Express BSP defines the MACHINE_START macro
> in the core tile code.
> 
> This patch moves this into the generic board code and introduces
> a method for determining the current tile at runtime, allowing
> the Kernel to have support for multiple tiles compiled in.
> Tile-specific functions are executed via a descriptor struct containing
> the correct implementations for the current tile.

Obviously, this has been broken by the changes to the SMP and GIC code...

> -MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
> -	.boot_params	= PHYS_OFFSET + 0x00000100,
> +#ifdef CONFIG_SMP
> +static unsigned int ct_ca9x4_get_core_count(void)
> +{
> +	return scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
> +}
> +
> +static void ct_ca9x4_smp_enable(void)
> +{
> +	scu_enable(MMIO_P2V(A9_MPCORE_SCU));
> +}
> +#endif

The SMP code is now down to the following:

void __init smp_init_cpus(void)
{
	void __iomem *scu_base = scu_base_addr();
	unsigned int i, ncores;

	ncores = scu_base ? scu_get_core_count(scu_base) : 1;

	/* sanity check */
	if (ncores > NR_CPUS) {
		printk(KERN_WARNING
		       "vexpress: no. of cores (%d) greater than configured "
		       "maximum of %d - clipping\n",
		       ncores, NR_CPUS);
		ncores = NR_CPUS;
	}

	for (i = 0; i < ncores; i++)
		set_cpu_possible(i, true);
}

void __init platform_smp_prepare_cpus(unsigned int max_cpus)
{
	int i;

	/*
	 * Initialise the present map, which describes the set of CPUs
	 * actually populated@the present time.
	 */
	for (i = 0; i < max_cpus; i++)
		set_cpu_present(i, true);

	scu_enable(scu_base_addr());

	/*
	 * Write the address of secondary startup into the
	 * system-wide flags register. The boot monitor waits
	 * until it receives a soft interrupt, and then the
	 * secondary CPU branches to this address.
	 */
	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
	writel(BSYM(virt_to_phys(vexpress_secondary_startup)),
		MMIO_P2V(V2M_SYS_FLAGSSET));
}

The secondary startup addresses could be moved into boot_secondary(),
leaving smp_init_cpus() and platform_smp_prepare_cpus() with the task
of initializing the possible/present bitmaps, and enabling the SCU.

I'm in two minds about that - one is that we know that the SCU on an
A9 or MPCore is going to tell us that CPUs 0..N are present, so we
can move that logic into smp_scu.c.

However, just because there's CPUs 0..N doesn't mean that a platform
would want to use all those CPUs for SMP, so it should be a platform
choice which CPUs get populated into the maps.

The other complication here is that the possible/present bitmaps use
logical CPU numbers, which depending on the platform may or may not
be the same as physical CPU numbers, even though it may be an A9 based
platform.

I think what we want is to not only move the count of cores and scu
enable into the core tile code, but also the bitmap population too.
That may ultimately be the sensible thing if we're eventually going
to indirect smp_init_cpus()/platform_smp_prepare_cpus() in the longer
term.
