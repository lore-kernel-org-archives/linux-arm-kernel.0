From: imirkin@alum.mit.edu (Ilia Mirkin)
Date: Sun, 20 Feb 2011 17:10:51 -0500
Subject: [PATCH] arm: imx: Zero entire imxdma structure
Message-ID: <1298239851-958-1-git-send-email-imirkin@alum.mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The semantic match that finds the problem:
// <smpl>
@@
type T;
identifier x;
@@

T *x;
...
* memset(x, ..., ... * sizeof(x) * ...);
// </smpl>

Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>

---
 arch/arm/mach-imx/dma-v1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Untested, lack of tool chain and hardware. But there's definitely something
odd going on here, and this seemed like the most logical fix.

diff --git a/arch/arm/mach-imx/dma-v1.c b/arch/arm/mach-imx/dma-v1.c
index e9f1769..236f149 100644
--- a/arch/arm/mach-imx/dma-v1.c
+++ b/arch/arm/mach-imx/dma-v1.c
@@ -699,7 +699,7 @@ int imx_dma_request(int channel, const char *name)
 		local_irq_restore(flags);
 		return -EBUSY;
 	}
-	memset(imxdma, 0, sizeof(imxdma));
+	memset(imxdma, 0, sizeof(*imxdma));
 	imxdma->name = name;
 	local_irq_restore(flags); /* request_irq() can block */
 
-- 
1.7.3.4
