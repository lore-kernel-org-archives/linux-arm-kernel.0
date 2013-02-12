From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 12 Feb 2013 05:12:40 +0100
Subject: [v2 3/3] ARM: tegra: Unify Device tree board files
In-Reply-To: <5119849B.1070300@wwwdotorg.org>
References: <1360562743-21689-1-git-send-email-hdoyu@nvidia.com><1360562743-21689-3-git-send-email-hdoyu@nvidia.com><5119849B.1070300@wwwdotorg.org>
Message-ID: <20130212.061240.2083183700176617607.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Tue, 12 Feb 2013 00:54:03 +0100:

> > -obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra.o
> > -obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
> > -obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= board-dt-tegra114.o
> > +obj-y					+= tegra.o
> > +
> 
> I think I'd be tempted to move that line together with all the others
> that don't depend on some config option.

In arch/arm/mach-tegra/Makefile, we have:

obj-y                                   += common.o
obj-y                                   += io.o
obj-y                                   += irq.o
obj-y					+= fuse.o
obj-y					+= pmc.o
.....

Should we have a single entry for them as well?

obj-y:= common.o io.o irq.o fuse.o pmc.o flowctrl.o powergate.o apbio.o pm.o \
	reset.o reset-handler.o sleep.o tegra.o

I think that this moval could be done another patch.

> >  static void __init harmony_init(void)
> >  {
> > -#ifdef CONFIG_TEGRA_PCI
> >  	int ret;
> >  
> >  	ret = harmony_pcie_init();
> >  	if (ret)
> >  		pr_err("harmony_pcie_init() failed: %d\n", ret);
> > -#endif
> >  }
> 
> Why drop those ifdefs? Does the code still compile (link) if built for
> Tegra30-only or Tegra114-only, where the Tegra PCI driver won't be
> enabled, and hence those functions don't exist?

This function itself will be dropped by the following IS_ENABLED().

> >  static void __init paz00_init(void)
> > @@ -129,6 +128,9 @@ static void __init tegra_dt_init_late(void)
> >  
> >  	tegra_init_late();
> >  
> > +	if (IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
> > +		return;
> 
> I don't think that's going to help any link issues, so I'd drop it and
> keep this function simple.

As explained in the above, a complier will drop unnecessary functions
automatically with this IS_ENABLED(), which could save many ifdefs.

> After all, what if someone wants to add some
> non-PCI-related entry into board_init_funcs[]?

I originally thought that one should try to solve those board specific
problems with DT basically and this tegra specific board_init_funcs[]
was left only for the legacy support during DT transition.
