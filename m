From: Lada.Trimasova@synopsys.com (Lada Trimasova)
Date: Tue, 19 Jan 2016 14:53:57 +0000
Subject: [PATCH] Fixing io-pgtable-arm build failure
In-Reply-To: <1452696481-2030-1-git-send-email-ltrimas@synopsys.com>
References: <1452696481-2030-1-git-send-email-ltrimas@synopsys.com>
Message-ID: <1453215237.7041.10.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, 2016-01-13 at 17:48 +0300, Lada Trimasova wrote:

Trying to build kernel for ARC with both options
CONFIG_COMPILE_TEST and CONFIG_IOMMU_IO_PGTABLE_LPAE enabled
(which happened really in "allyesconfig") I'm seeing this:
---------------->8----------------
$ make ARCH=arc
...sic...
CC drivers/iommu/io-pgtable-arm.o
linux/drivers/iommu/io-pgtable-arm.c: In
function ?__arm_lpae_alloc_pages?:
linux/drivers/iommu/io-pgtable-arm.c:221:3:
error: implicit declaration of function ?dma_map_single?
[-Werror=implicit-function-declaration]
dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
^
linux/drivers/iommu/io-pgtable-arm.c:221:42:
error: ?DMA_TO_DEVICE? undeclared (first use in this function)
dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
^
---------------->8----------------
and so on.

IOMMU_IO_PGTABLE_LPAE depends on DMA API.
So io-pgtable-arm.c should include linux/dma-mapping.h.

Signed-off-by: Lada Trimasova <ltrimas at synopsys.com<mailto:ltrimas@synopsys.com>>
Cc: Alexey Brodkin <abrodkin at synopsys.com<mailto:abrodkin@synopsys.com>>
Cc: Vineet Gupta <vgupta at synopsys.com<mailto:vgupta@synopsys.com>>
Cc: Will Deacon <will.deacon at arm.com<mailto:will.deacon@arm.com>>
Cc: Joerg Roedel <joro at 8bytes.org<mailto:joro@8bytes.org>>
---
 drivers/iommu/io-pgtable-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7df9777..0b1aca0 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/dma-mapping.h>

 #include <asm/barrier.h>



Please treat this as a polite reminder to review that patch sometime soon.

Regards,
Lada Trimasova.
