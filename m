From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 24 Jul 2015 21:45:13 +0200
Subject: [GIT PULL] pxa for v4.3 - v2
Message-ID: <87si8de3w6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.3 development cycle, the second one after a
small fix triggered by 0-day kernel builder. It is a quite small one, the main
work happening on the drivers side, mostly dmaengine centric work.

For the record, the diff from the previous pull request is in [1].

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.3-v2

for you to fetch changes up to 6d6db340a7e832dc18a6a95d9f9fc79d03ff959e:

  ARM: pxa: Use setup_timer (2015-07-18 12:16:43 +0200)

----------------------------------------------------------------
This is the pxa changes for v4.3 cycle.

There is mostly one evolution on the dma side, to enable cooperation
of the legacy pxa DMA API, and the new dmaengine API.
Once all drivers using DMA are converted, the legacy DMA API should
be removed.

----------------------------------------------------------------
Robert Jarzmik (1):
      ARM: pxa: transition to dmaengine phase 1

Vaishali Thakkar (2):
      ARM: pxa: Use module_platform_driver
      ARM: pxa: Use setup_timer

 arch/arm/mach-pxa/devices.c          | 37 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa25x.c           |  1 +
 arch/arm/mach-pxa/pxa27x.c           |  1 +
 arch/arm/mach-pxa/pxa3xx.c           |  1 +
 arch/arm/mach-pxa/sharpsl_pm.c       |  6 ++----
 arch/arm/mach-pxa/tosa-bt.c          | 15 +--------------
 arch/arm/plat-pxa/dma.c              | 22 ++++++++++-----------
 arch/arm/plat-pxa/include/plat/dma.h | 15 +++++++++++++++
 8 files changed, 69 insertions(+), 29 deletions(-)


Cheers.

--
Robert

[1]
diff --git a/arch/arm/plat-pxa/include/plat/dma.h b/arch/arm/plat-pxa/include/plat/dma.h
index 33ac1a9eb523..28848b344e2d 100644
--- a/arch/arm/plat-pxa/include/plat/dma.h
+++ b/arch/arm/plat-pxa/include/plat/dma.h
@@ -89,7 +89,7 @@ void pxa_free_dma (int dma_ch);
 #if defined(CONFIG_PXA_DMA)
 extern int pxad_toggle_reserved_channel(int legacy_channel);
 #else
-static inline pxad_toggle_reserved_channel(int legacy_channel)
+static inline int pxad_toggle_reserved_channel(int legacy_channel)
 {
        return 0;
 }
