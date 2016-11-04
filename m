From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  4 Nov 2016 17:31:55 +0000
Subject: [PATCH v8 08/16] arm: gic: allow 32-bit compilation
In-Reply-To: <20161104173203.21168-1-andre.przywara@arm.com>
References: <20161104173203.21168-1-andre.przywara@arm.com>
Message-ID: <20161104173203.21168-9-andre.przywara@arm.com>
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
index 2c1a547..4d12f31 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -18,6 +18,14 @@
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
 static int gic_fd = -1;
 static u64 gic_redists_base;
 static u64 gic_redists_size;
-- 
2.9.0
