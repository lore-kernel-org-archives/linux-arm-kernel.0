From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 17:32:14 +0000
Subject: [v2 3/3] ARM: tegra: Unify Device tree board files
In-Reply-To: <511A6F6C.8090205@wwwdotorg.org>
References: <5119849B.1070300@wwwdotorg.org>
 <201302121350.15683.arnd@arndb.de> <511A6F6C.8090205@wwwdotorg.org>
Message-ID: <201302121732.14960.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Stephen Warren wrote:
> >>>>> I don't think that's going to help any link issues, so I'd drop it and
> >>>>> keep this function simple.
> >>>>
> >>>> As explained in the above, a complier will drop unnecessary functions
> >>>> automatically with this IS_ENABLED(), which could save many ifdefs.
> >>>
> >>> That sounds extremely brittle. Have you validated this on a wide variety
> >>> of compiler versions?
> >>
> >> I verified with gcc-4.6.
> >> IIRC, that's the point of IS_ENABLED() being introduced. Arnd?
> > 
> > It's certainly expected to work with all compilers, yes. If a compiler
> > cannot remove conditional function calls that depend on a constant
> > expression, we have a lot of other problems alredy.
> 
> Removing the function calls isn't guaranteed to remove the body of the
> functions though. Those functions aren't implemented in some separate
> file that's optionally included, but rather are implemented in the same
> object file, now unconditionally, and they in turn reference (with no
> IS_ENABLED logic) other functions that are implemented in conditionally
> linked files.

I think gcc should remove all of that in this case, since board_init_funcs
becomes unused when the only code that references it cannot be reached,
and when that array is gone, the now unused functions would be removed
as well.

We have had bugs with prerelease gcc versions that did not handle cases
like this in the way we want it, but I think all releases get it right.
I don't think it's mandated anywhere in the C99 standard that this is
what happens, but we do rely on it anyway AFAIK.

> > static void __init harmony_init(void)
> > {
> >         int ret = 0;
> > 
> >         if (IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
> >               ret = harmony_pcie_init();
> >         if (ret)
> >                 pr_err("harmony_pcie_init() failed: %d\n", ret);
> > }
> > 
> > which will turn into an empty function if one of the two is disabled.
> 
> That would work.
> 
> However I'd like to avoid changing the body of those two functions at
> all if possible, since I hope the PCIe driver rework will be merged in
> 3.10, and that will allow the Harmony and TrimSlice init functions to be
> removed entirely. I'd rather not have conflicts with the removal patch.

Yes, makes sense.

> > Since we are not going to add any other board specfic init functions, you
> > can also unroll the loop and put everything into tegra_dt_init_late:
> 
> That's not necessarily true. While we certainly don't plan to, I don't
> think we can rule it out; after all, we don't have rfkill bindings and
> yet other boards will need them.

Ok.

	Arnd
