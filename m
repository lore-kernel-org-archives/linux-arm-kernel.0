From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 16:43:00 +0100
Subject: [PATCH v2 0/3] ARM: shmobile: r8a73a4: DT PM domain support
Message-ID: <1424187783-6390-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series enables DT support for PM domains on the Renesas
R-Mobile APE6 (r8a73a4) SoC.  As a bonus, it also allows the use of the
R-Mobile Reset driver to restart the system.

This series builds further upon the DT PM Domain support for R-Mobile
A1 (r8a7740) and SH-Mobile AG5 (sh73a0).  Due to the similarity of the
SYSC System-Controller on the various SH-Mobile/R-Mobile SoCs, and the
abstraction of PM domains in DT, the same driver can handle r8a73a4,
without any additional modifications, and without changing the DT
bindings.

root at ape6evm:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
           /device                                      runtime status
----------------------------------------------------------------------
a2is                            off
a2rv                            off
a3r                             off              a2rv, a2is
a4sf                            off
a3vc                            off
a3mp                            off
a4mp                            off              a3mp, a3vc
a4lc                            off
a4l                             off
a3bc                            on
a4bc                            on               a3bc
d4                              on
c4cl                            off
c4ma                            off
a2kl                            off
a3km                            off              a2kl
a2sl                            on
a3sm                            on               a2sl
a2us                            off
a3sp                            on               a2us
    /devices/platform/e60b0000.i2c                      suspended
    /devices/platform/dma-multiplexer/e6700020.dma-controller  suspended
    /devices/platform/e6c40000.serial                   active
    /devices/platform/ee100000.sd                       active
    /devices/platform/ee120000.sd                       active
    /devices/platform/ee200000.mmc                      active
a3ex                            off
a3sg                            off
c4                              on               a3sg, a3ex, a3sp, a3sm, a3km
    /devices/platform/e61c0000.interrupt-controller     unsupported
    /devices/platform/e61c0200.interrupt-controller     unsupported
    /devices/platform/fec10000.bus                      active
c5                              on               c4, c4ma, c4cl, d4, a4bc, a4l, a4lc, a4mp, a4sf, a3r
    /devices/platform/e6050000.pfc                      unsupported
    /devices/platform/e6130000.timer                    suspended
    /devices/platform/e61f0000.thermal                  active
root at ape6evm:~#

Dependencies:
  - Patch 1 (DT binding doc) depends on Simon's tag renesas-dt2-for-v3.20,
    which should be upstream tonight,
  - Patch 2 (dtsi) depends on the series "[PATCH v4 0/6] ARM: shmobile:
    r8a73a4/ape6evm: Complete multiplatform support",
  - Patch 3 (drivers/sh) depends functionally on patch 2, and literally on
    the series "[PATCH v3 0/2] ARM: shmobile: sh73a0: Enable DT PM domain
    support".

Thanks for applying!

Geert Uytterhoeven (3):
  PM / Domains: R-Mobile SYSC: Document R-Mobile APE6 (r8a73a4) binding
  ARM: shmobile: r8a73a4 dtsi: Add PM domain support
  drivers: sh: Disable PM runtime for multi-platform r8a73a4 with genpd

 .../bindings/power/renesas,sysc-rmobile.txt        |   1 +
 arch/arm/boot/dts/r8a73a4.dtsi                     | 177 +++++++++++++++++++++
 drivers/sh/pm_runtime.c                            |   2 +-
 3 files changed, 179 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
