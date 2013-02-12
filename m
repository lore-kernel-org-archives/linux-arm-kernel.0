From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 13:50:15 +0000
Subject: [v2 3/3] ARM: tegra: Unify Device tree board files
In-Reply-To: <20130212.070456.532657136988541923.hdoyu@nvidia.com>
References: <5119849B.1070300@wwwdotorg.org> <5119C958.1030304@wwwdotorg.org>
 <20130212.070456.532657136988541923.hdoyu@nvidia.com>
Message-ID: <201302121350.15683.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Hiroshi Doyu wrote:
> > >>>  static void __init paz00_init(void)
> > >>> @@ -129,6 +128,9 @@ static void __init tegra_dt_init_late(void)
> > >>>  
> > >>>   tegra_init_late();
> > >>>  
> > >>> + if (IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
> > >>> +         return;
> > >>
> > >> I don't think that's going to help any link issues, so I'd drop it and
> > >> keep this function simple.
> > > 
> > > As explained in the above, a complier will drop unnecessary functions
> > > automatically with this IS_ENABLED(), which could save many ifdefs.
> > 
> > That sounds extremely brittle. Have you validated this on a wide variety
> > of compiler versions?
> 
> I verified with gcc-4.6.
> IIRC, that's the point of IS_ENABLED() being introduced. Arnd?

It's certainly expected to work with all compilers, yes. If a compiler
cannot remove conditional function calls that depend on a constant
expression, we have a lot of other problems alredy.

However, from what I see above, you have the logic reversed (it
should return if neither TEGRA_2x nor PCI are enabled, rather
than return if one of them is enabled). and it becomes a little
confusing to read.

If you want to get rid of the #ifdef here, I would suggest you put those
into the functions directly, like

static void __init harmony_init(void)
{
        int ret = 0;

        if (IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
		ret = harmony_pcie_init();
        if (ret)
                pr_err("harmony_pcie_init() failed: %d\n", ret);
}

which will turn into an empty function if one of the two is disabled.

Since we are not going to add any other board specfic init functions, you
can also unroll the loop and put everything into tegra_dt_init_late:

/* Board specific fixups, try not add any new ones here */
static void __init tegra_dt_init_late(void)
{
	tegra_powergate_debugfs_init();

	/* so far, these all apply only to tegra2x */
	if (!IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
		return;

	if (of_machine_is_compatible("compal,paz00"))
		tegra_paz00_wifikill_init();
	if (IS_ENABLED(CONFIG_PCI) && of_machine_is_compatible("nvidia,harmony")
		harmony_pcie_init();
	if (IS_ENABLED(CONFIG_PCI) && of_machine_is_compatible("compulab,trimslice")
		tegra_pcie_init(true, true);
}

	Arnd
