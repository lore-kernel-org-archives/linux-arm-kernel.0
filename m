From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  4 May 2015 17:24:26 +0200
Subject: [PATCH v3 0/6] ARM: l2c / shmobile: r8a7740 : Shared Override
Message-ID: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series migrates the shmobile DT-based generic r8a7740 and
armadillo legacy platforms from calling l2x0_of_init() to the generic
l2c OF initialization.

It was sent before as "[PATCH v2 0/5] ARM: shmobile: r8a7740/armadillo:
Migrate to generic l2c OF". Major changes in v3 are the introduction of
the "arm,shared-override" property in DT, and only setting the Shared
Override bit if CMA is not available. Note that not setting this bit may
lead to memory corruption in the presence of other bus masters.

For shmobile, this conversion should be done on sh73a0, r8a7778, and
r8a7779, too.

Several other ARM platforms (berlin, cns3xxx, nomadik, omap, realview,
sti, tegra, vexpress) currently set the Shared Override bit in various
ways. As soon as the first patch in this series is accepted, they can
start specifying the "arm,shared-override" property in their DTSes, and
remove the corresponding board code.

Changes in v3:
  - Add DT support for Shared Override,
  - Setting Shared Override is done only if CMA is not available (as
    Russell claims it's not needed if CMA is available),
  - Use 0/~0 in machine_desc.l2c_aux_{val,mask}, as DT now supports
    "arm,shared-override".

Changes in v2:
  - Fix interrupt reference in DT,
  - Describe L2 better in DT,
  - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE in
    machine_desc.l2c_aux_{val,mask}, as there's no DT property for
    this.
  - Add L1 cache to DT.

Dependencies:
  - Although there are separate patches for ARM code, dtsi, SoC code, and
    board code, there are dependencies among the individual patches:
      - patches 3 and 4 depend on patches 1 and 2,
      - patch 5 depends on patches 3 and 4,
      - patch 6 depends on patch 2.

This was tested on armadillo-legacy and armadillo-multiplatform.

Thanks!

Geert Uytterhoeven (6):
  ARM: l2c: Add DT support for Shared Override
  ARM: shmobile: r8a7740 dtsi: Add L2 cache-controller node
  ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
  ARM: shmobile: armadillo legacy: Migrate to generic l2c OF
    initialization
  ARM: shmobile: r8a7740: Remove mapping of L2 cache controller
    registers
  ARM: shmobile: r8a7740 dtsi: Add L1 cache information to CPU node

 Documentation/devicetree/bindings/arm/l2cc.txt |  6 ++++++
 arch/arm/boot/dts/r8a7740.dtsi                 | 25 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |  8 ++------
 arch/arm/mach-shmobile/setup-r8a7740.c         | 18 ++----------------
 arch/arm/mm/cache-l2x0.c                       | 10 ++++++++++
 5 files changed, 45 insertions(+), 22 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
