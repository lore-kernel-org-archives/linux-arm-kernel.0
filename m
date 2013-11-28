From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 28 Nov 2013 14:58:53 -0800
Subject: Build warning in drivers/dma/mmp_tdma.c
Message-ID: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My build warning test is failing on this driver please fix:

drivers/dma/mmp_tdma.c:236:8: warning: 'tdcr' may be used
uninitialized in this function [-Wuninitialized]

It's valid as mmp_tdma_control as the direction is specified in
mmp_tdma_control() and may not be one of the two tests in that branch.



I'm also carrying patch to add a missing dependency:

commit 1a4ee91dacedde3e82d8ce6eeace7f16884474f9
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Thu Nov 28 12:27:38 2013 -0800

    dma: mmp_dma depends on CPU_MMP2

    It calls sram_get_gpool() which is only defined if CONFIG_CPU_MMP2=y

    Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 446687cc2334..dad83634cb65 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -287,7 +287,7 @@ config DMA_SA11X0

 config MMP_TDMA
        bool "MMP Two-Channel DMA support"
-       depends on ARCH_MMP
+       depends on ARCH_MMP && CPU_MMP2
        select DMA_ENGINE
        help
          Support the MMP Two-Channel DMA engine.

Is there a different ARCH type that this driver should be depending on?

--
Dan
