From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Thu, 30 May 2013 14:45:20 -0700
Subject: [PATCH] arm: Prevent memory aliasing on non-LPAE kernels
Message-ID: <1369950320-22784-1-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some LPAE-capable systems may use a Device Tree containing
memory nodes that describe memory extending beyond the 4GB
physical address boundary. Ignore or truncate these memory
nodes on kernels that have not been built with LPAE
support, to prevent the extended physical addresses from
being truncated and aliasing with physical addresses below
the 4GB boundary.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/kernel/devtree.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index bee7f9d..24bc80b 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -26,6 +26,18 @@

 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
+#ifndef CONFIG_ARM_LPAE
+	if (base > ((phys_addr_t)~0)) {
+		pr_crit("Ignoring memory at 0x%08llx due to lack of LPAE support\n",
+			base);
+		return;
+	}
+
+	if (size > ((phys_addr_t)~0))
+		size = ((phys_addr_t)~0);
+
+	/* arm_add_memory() already checks for the case of base + size > 4GB */
+#endif
 	arm_add_memory(base, size);
 }

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
