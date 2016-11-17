From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Nov 2016 18:03:05 +0100
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <fe90b6cc-81b1-772e-ab78-f2199957ec96@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <20161114145143.GM1041@n2100.armlinux.org.uk>
 <fe90b6cc-81b1-772e-ab78-f2199957ec96@samsung.com>
Message-ID: <3360559.T0zQaY0FJ3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 17, 2016 9:50:27 AM CET pankaj.dubey wrote:
> 
> >>> of_scu_enable() which _only_ looks up the SCU address in DT and enables
> >>> it if it finds it, otherwise returning failure.
> >>>
> >>> a9_scu_enable() which tries to use the A9 provided SCU address and
> >>> enables it if it finds it, otherwise returning failure.
> >>>
> 
> OK, In that case I can see need for following four helpers as:
> 
> 1: of_scu_enable() which will __only__ lookup the SCU address in DT and
> enables it if it finds, otherwise return -ENOMEM failure.
> This helper APIs is required and sufficient for most of platforms such
> as exynos, berlin, realview, socfpga, STi, ux500, vexpress, rockchip and
> mvebu
> 
> 2: a9_scu_enable(), which will __only__ use A9 provided SCU address and
> enables it, if address mapped successfully, otherwise returning failure.
> This helper APIs is required and sufficient for two ARM platforms as of
> now tegra and hisi.
> 
> 3: of_scu_get_base() which will lookup the SCU address in DT and if node
> found maps address and returns ioremapped address to caller.
> This helper APIs is required for three ARM plaforms rockchip, mvebu and
> ux500, along with scu_enable() API to enable and find number_of_cores.
> 
> 4: s9_scu_iomap_base() which will internally use s9_scu_get_base() and
> do ioremap of scu address and returns ioremapped address to the caller
> along with ownership (caller has responsibility to unmap it).
> This helper APIs is required to simplify SCU enable and related code in
> two ARM plaforms BCM ans ZX.
>
> For remaining two ARM platforms (IMX and ZYNQ), none of these helpers
> are useful for the time-being, as they need SCU mapping very early of
> boot, where we can't use iomap APIs. So I will drop patches related to
> these platforms in v2 version.
> 
> Please let me know if any concern in this approach.

I think ideally we wouldn't even need to know the virtual address
outside of smp_scu.c. If we can move all users of the address
into that file directly, it could become a local variable and
we change scu_power_mode() and scu_get_core_count() instead to
not require the address argument.

The only user I could find outside of that file is

static int shmobile_smp_scu_psr_core_disabled(int cpu)
{
        unsigned long mask = SCU_PM_POWEROFF << (cpu * 8);

        if ((__raw_readl(shmobile_scu_base + 8) & mask) == mask)
                return 1;

        return 0;
}

which can be done in the same file as well.

> >>> Then callers can decide which of these to call, and what error messages
> >>> to print on their failures.
> >>
> >> Splitting the function in two is probably simpler overall, but
> >> we may still have to look at all the callers: Any platform that
> >> currently tries to map it on any CPU and doesn't warn about the
> >> absence of the device node (or about scu_a9_has_base() == false)
> >> should really continue not to warn about that.
> > 
> > Did you miss the bit where none of of_scu_enable() or a9_scu_enable()
> > should produce any warnings or errors to be printed.  It's up to the
> > caller to report the failure, otherwise doing this doesn't make sense:
> > 
> >       if (of_scu_enable() < 0 && a9_scu_enable() < 0)
> >               pr_err("Failed to map and enable the SCU\n");
> > 
> > because if of_scu_enable() prints a warning/error, then it's patently
> > misleading.
> > 

That's why I said "otherwise we can leave the warning in the caller
after checking the return code of the new APIs." for the case where
we actually need it.

> I will move out error message out of these helpers and let caller
> (platform specific code) handle and print error if required.

Ok.

	Arnd
