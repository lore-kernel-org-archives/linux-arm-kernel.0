From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Jan 2014 09:52:57 -0800
Subject: [PATCH] arm64: Add pdev_archdata for dmamask
In-Reply-To: <y>
References: <y>
Message-ID: <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_mask for a device structure is a pointer. This pointer
needs to be set up before the dma mask can actually be set. Most
frameworks in the kernel take care of setting this up properly but
platform devices that don't follow a regular bus structure may not
ever have this set. As a result, checks such as dma_capable will
always return false on a raw platform device and dma_set_mask will
always return -EIO. Fix this by adding a dma_mask in the
platform_device archdata and setting it to be the dma_mask. Devices
used in other frameworks can change this as needed.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/device.h |    1 +
 arch/arm64/kernel/setup.c       |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index cf98b36..209d40c 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -24,6 +24,7 @@ struct dev_archdata {
 };
 
 struct pdev_archdata {
+	u64 dma_mask;
 };
 
 #endif
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index bd9bbd0..f164347 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -41,6 +41,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/cputype.h>
 #include <asm/elf.h>
@@ -337,3 +338,9 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= c_show
 };
+
+void arch_setup_pdev_archdata(struct platform_device *pdev)
+{
+	pdev->archdata.dma_mask = DMA_BIT_MASK(32);
+	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
+}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
