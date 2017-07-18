From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 18 Jul 2017 16:37:15 +0300
Subject: [PATCH v2 0/7] staging: fsl-mc: make the driver compile on other
 architectures
Message-ID: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Apart from a small change (first patch) which adds a missing comment,
this series make the bus driver compile on other architectures, as per
GregKH comment [1].
Compiled tested on:
 - booke powerpc (corenet{32,64}_smp_defconfig) with this ppc patch [2]
 - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
 - arm64 (defconfig)

[1] https://www.spinics.net/lists/linux-driver-devel/msg100585.html
[2] https://patchwork.ozlabs.org/patch/789474/

version 2 changes
 - use writeq() / writeq_relaxed() / readq_relaxed() instead
   of raw versions (Robin)
 - use linux/io-64-nonatomic-hi-lo.h to make the driver compile
   on 32-bit platforms (Robin)
 - add extra LE <-> CPU so that standard device io may be used (Arnd)

Laurentiu Tudor (7):
  staging: fsl-mc: add missing fsl_mc comment in struct msi_desc
  staging: fsl-mc: use generic memory barriers
  staging: fsl-mc: drop useless gic v3 related #include
  staging: fsl-mc: fix compilation with non-generic msi domain ops
  staging: fsl-mc: fix formating of phys_addr_t on 32 bits
  staging: fsl-mc: rewrite mc command send/receive to work on 32-bits
  staging: fsl-mc: allow the driver compile multi-arch

 drivers/staging/fsl-dpaa2/Kconfig                  |  2 +-
 drivers/staging/fsl-mc/bus/Kconfig                 |  4 +-
 drivers/staging/fsl-mc/bus/fsl-mc-msi.c            |  5 ++-
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |  3 +-
 drivers/staging/fsl-mc/bus/mc-io.c                 |  8 ++--
 drivers/staging/fsl-mc/bus/mc-sys.c                | 45 +++++++++-------------
 include/linux/msi.h                                |  1 +
 7 files changed, 32 insertions(+), 36 deletions(-)

-- 
2.9.4
