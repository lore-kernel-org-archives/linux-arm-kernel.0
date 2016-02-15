From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 13:20:06 +0100
Subject: [PATCH v3 0/2] ARM: shmobile: Avoid writing to .text
Message-ID: <1455538808-6816-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

        Hi Simon, Magnus,

When CONFIG_DEBUG_RODATA=y, the kernel crashes during system suspend:

    Freezing user space processes ... (elapsed 0.004 seconds) done.
    Freezing remaining freezable tasks ... (elapsed 0.002 seconds)
    done.
    PM: suspend of devices complete after 111.948 msecs
    PM: late suspend of devices complete after 1.086 msecs
    PM: noirq suspend of devices complete after 11.576 msecs
    Disabling non-boot CPUs ...
    Kernel panic - not syncing: Attempted to kill the idle task!
    1014ec ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
    CPU0: stopping

This happens because the shmobile assembler sources have several
variables that are written to in the .text section, while .text is
mapped read-only after kernel bootup if CONFIG_DEBUG_RODATA=y.

This series fixes this by moving variables from .text to .bss, or just
removing them.
Note that there's still an issue with shmobile_boot_fn in
arch/arm/mach-shmobile/headsmp.S.  So far I didn't manage to fix this
(the code and data are copied to SRAM on some SoCs).  However, currently
this is mostly harmless, as this is written to during early kernel boot
up only, before .text is marked read-only. It does matter for XIP
(anyone using that with SMP?), so we do want to fix that in the long
run, too.

These issues were uncovered by "[PATCH v2] ARM: mm: flip priority of
CONFIG_DEBUG_RODATA". As that patch is already queued in arm/for-next, I
think all these fixes should be queued for v4.5, to avoid a dependency
with the arm tree.

Changes compared to v2:
  - Use .bss instead of .data, as requested by Nicolas Pitre
    <nicolas.pitre@linaro.org>,
  - Added Acked-by and Reviewed-by.

Changes compared to v1:
  - Dropped "ARM: shmobile: Move shmobile_scu_base from .text to .data",
    which Simon has applied, and queued in soc-for-v4.6 (should be
    soc-for-v4.5?),
  - Added Reviewed-by,
  - Store offsets instead of pointers, as suggested by Nicolas Pitre
    <nicolas.pitre@linaro.org>,
  - Added "ARM: shmobile: Remove shmobile_boot_arg".

Tested hard on sh73a0/kzm9g, r8a7791/koelsch.
Tested lighter on emev2/kzm9d[*], r8a73a4/ape6evm, r8a7740/armadillo, and
r8a7779/marzen[*] ([*] = no remote resume).

Thanks!


Geert Uytterhoeven (2):
  ARM: shmobile: Move shmobile_smp_{mpidr,fn,arg}[] from .text to .bss
  ARM: shmobile: Remove shmobile_boot_arg

 arch/arm/mach-shmobile/common.h       |  1 -
 arch/arm/mach-shmobile/headsmp.S      | 28 ++++++++++++++++------------
 arch/arm/mach-shmobile/platsmp-apmu.c |  1 -
 arch/arm/mach-shmobile/platsmp-scu.c  |  1 -
 4 files changed, 16 insertions(+), 15 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
