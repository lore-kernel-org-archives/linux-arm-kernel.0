From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  5 Aug 2015 10:58:04 +0200
Subject: [PATCH v4 0/6] ARM: shmobile: r8a7740/sh73a0 DT Cache Handling
Message-ID: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series add L1 and L2 cache descriptions to DT for r8a7740 and
sh73a0, and migrates the shmobile DT-based generic r8a7740 and
armadillo legacy platforms from calling l2x0_of_init() to the generic
l2c OF initialization.

Note that the conversion to the generic l2c OF initialization is not
done yet for sh73a0, as this initializes the L2 cache earlier, breaking
the (fragile) sh73a0 secondary CPU bringup code.

Also note that this conversion should be done on r8a7778, and r8a7779,
too.

Changes compared to v3 ("[PATCH v3 0/6] ARM: l2c / shmobile: r8a7740 : Shared
Override",
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340636.html):
  - "l2c: Add support for the "arm,shared-override" property" was split
    off into an independent patch, and is now queued for v4.3 in
    arm/for-next,
  - Dropped armadillo legacy migration, as it no longer exists,
  - Added sh73a0 L1 and L2 DT cache description.

Changes compared to v2 ("[PATCH v2 0/5] ARM: shmobile: r8a7740/armadillo:
Migrate to generic l2c OF",
http://www.spinics.net/lists/devicetree/msg68176.html):
  - Add DT support for Shared Override,
  - Setting Shared Override is done only if CMA is not available (as
    Russell claims it's not needed if CMA is available),
  - Use 0/~0 in machine_desc.l2c_aux_{val,mask}, as DT now supports
    "arm,shared-override".

Changes compared to v1:
  - Fix interrupt reference in DT,
  - Describe L2 better in DT,
  - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE in
    machine_desc.l2c_aux_{val,mask}, as there's no DT property for
    this.
  - Add L1 cache to DT.

Dependencies:
  - This series applies to renesas-devel-20150805-v4.2-rc5,
  - Patch 2 depends on patch 1,
  - Patch 4 depends on patch 2,
  - Patch 5 depends on patch 1 and on "ARM: 8395/1: l2c: Add support for
    the "arm,shared-override" property" in arm/for-next,
  - Patch 6 depends on patch 5.

Given C code patches depending on DT patches in the same branch are
frowned upon, I think it would be best if patch 1 (and patch 3, if
anyone thinks we may fix the secondary CPU bringup issue during the next
3 months) are queued for v4.3. The other patches can be queued for
2016^H^H^H^Hv4.4.

I've been running this on r8a7740/armadillo and sh73a0/kzm9g during the
past 9 months.

Thanks!

Geert Uytterhoeven (6):
  ARM: shmobile: r8a7740 dtsi: Add L2 cache-controller node
  ARM: shmobile: r8a7740 dtsi: Add L1 cache information to CPU node
  ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node
  ARM: shmobile: sh73a0 dtsi: Add L1 cache information to CPU nodes
  ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
  ARM: shmobile: r8a7740: Remove mapping of L2 cache controller
    registers

 arch/arm/boot/dts/r8a7740.dtsi         | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/sh73a0.dtsi          | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c | 18 ++----------------
 3 files changed, 61 insertions(+), 16 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
