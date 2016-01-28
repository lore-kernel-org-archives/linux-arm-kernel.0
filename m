From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jan 2016 17:48:48 +0000
Subject: [PATCH 0/2] ARM: shmobile: Move written variables from .text to
 .data
In-Reply-To: <CAGXu5jL7ebTXtPu5_9U4duju2qiWFEYVQmSSgpdMDkWr8tQCvw@mail.gmail.com>
References: <1453993462-12210-1-git-send-email-geert+renesas@glider.be>
 <CAGXu5jL7ebTXtPu5_9U4duju2qiWFEYVQmSSgpdMDkWr8tQCvw@mail.gmail.com>
Message-ID: <20160128174848.GO10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 07:19:34AM -0800, Kees Cook wrote:
> On Thu, Jan 28, 2016 at 7:04 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >         Hi Simon, Magnus,
> >
> > When CONFIG_ARM_KERNMEM_PERMS=y and CONFIG_DEBUG_RODATA=y, the kernel
> > crashes during system suspend:
> >
> >     Freezing user space processes ... (elapsed 0.004 seconds) done.
> >     Freezing remaining freezable tasks ... (elapsed 0.002 seconds)
> >     done.
> >     PM: suspend of devices complete after 111.948 msecs
> >     PM: late suspend of devices complete after 1.086 msecs
> >     PM: noirq suspend of devices complete after 11.576 msecs
> >     Disabling non-boot CPUs ...
> >     Kernel panic - not syncing: Attempted to kill the idle task!
> >     1014ec ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> >     CPU0: stopping
> >
> > This happens because the shmobile assembler sources have several
> > variables that are written to in the .text section, while .text is
> > mapped read-only after kernel bootup if CONFIG_DEBUG_RODATA=y.
> >
> > This series fixes this by moving variables from .text to .data.
> > Note that there's still an issue with shmobile_boot_fn and
> > shmobile_boot_arg in arch/arm/mach-shmobile/headsmp.S.
> > So far I didn't manage to fix this (the code and data are copied to
> > SRAM on some SoCs).  However, currently this are harmless, as these are
> > written during early kernel boot up only, before .text is marked
> > read-only.
> >
> > These issues were uncovered by "[PATCH v2] ARM: mm: flip priority of
> > CONFIG_DEBUG_RODATA". As that patch is planned for queue up (again)
> > soon, it may be a good idea to queue these fixes for v4.5, to avoid a
> > dependency with the arm tree.
> >
> > Tested hard on sh73a0/kzm9g, r8a7791/koelsch.
> > Tested lighter on emev2/kzm9d[*], r8a73a4/ape6evm, r8a7740/armadillo, and
> > r8a7779/marzen[*] ([*] = no remote resume).
> >
> > Thanks!
> >
> > Geert Uytterhoeven (2):
> >   ARM: shmobile: Move shmobile_scu_base from .text to .data
> >   ARM: shmobile: Move shmobile_smp_{mpidr,fn,arg}[] from .text to .data
> >
> >  arch/arm/mach-shmobile/headsmp-scu.S |  6 ------
> >  arch/arm/mach-shmobile/headsmp.S     | 22 ++++++++++++++++------
> >  arch/arm/mach-shmobile/platsmp-scu.c |  3 +++
> >  3 files changed, 19 insertions(+), 12 deletions(-)
> 
> Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> And FWIW, I've now got the RODATA patch back in the patch queue, since
> we're at -rc1:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8501/1

And I'll be dropping it into linux-next for next week (iow, I'll commit
it tomorrow.)

Unfortunately, -rc1 broke some platforms, so Olof's builder isn't going
to get full coverage of it while building only my tree.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
