From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 20 Jul 2016 18:04:35 +0100
Subject: [PATCH v7 15/15] arm: gic: allow 32-bit compilation
In-Reply-To: <20160720170435.28090-1-andre.przywara@arm.com>
References: <20160720170435.28090-1-andre.przywara@arm.com>
Message-ID: <20160720170435.28090-16-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM GIC code is shared between ARM and arm64, though the header
files from the Linux kernel are actually different, reflecting the
different level of GIC emulation support between the two architectures.
Since it is conceivable that ARM will gain GICv3 (and possibly ITS)
emulation support too, lets conditionally define those missing
symbols in the source file until an upcoming ARM header update eventually
includes those.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 7fd0768..cd4f518 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -19,6 +19,14 @@
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST 3
 #endif
 
+#ifndef KVM_VGIC_ITS_ADDR_TYPE
+#define KVM_VGIC_ITS_ADDR_TYPE 4
+#endif
+
+#ifndef KVM_VGIC_V3_ITS_SIZE
+#define KVM_VGIC_V3_ITS_SIZE (2 * SZ_64K)
+#endif
+
 #define IRQCHIP_GIC 0
 
 static int gic_fd = -1;
-- 
2.9.0
