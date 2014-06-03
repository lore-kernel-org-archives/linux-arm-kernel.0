From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Jun 2014 21:03:55 -0700
Subject: Exynos induced build error with recent arm-soc
In-Reply-To: <20140602234216.GD933@n2100.arm.linux.org.uk>
References: <20140602234216.GD933@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMjLAoWOAkm-5+HrHDND_TRyBmbA49ugK+bRBZswBhd3wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 2, 2014 at 4:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Spotted with a randconfig today:
>
> arch/arm/mach-exynos/built-in.o: In function `exynos_set_cpu_boot_addr':
> pm_domains.c:(.text+0x19c): undefined reference to `sysram_ns_base_addr'
> arch/arm/mach-exynos/built-in.o:(.data+0x94): undefined reference to `exynos_enter_aftr'
>
> This should be fixed before the merge window...
>
> The failing .config is:
>
> http://www.arm.linux.org.uk/developer/build/file.php?lid=8598
>
> and the resulting build log with errors:
>
> http://www.arm.linux.org.uk/developer/build/result.php?type=log&cid=3001&lid=8600&format=build
>
> Thanks.

Ah, yes, definitely needs fixing. Looks like sysram_base_addr can
cause similar problems if CONFIG_SUSPEND -> CONFIG_PM_SLEEP is enabled
on !SMP.

The setup (and location) for these variables need to be moved out of
platsmp.c. exynos.c seems like as good a place as any in this case.
I'll post a patch separately in a few minutes.


-Olof
