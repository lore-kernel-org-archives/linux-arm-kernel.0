From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 May 2014 09:14:03 -0700
Subject: [PATCH v3 11/14] ARM64: KVM: fix vgic_bitmap_get_reg function for BE
 64bit case
In-Reply-To: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1399997646-4716-12-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix vgic_bitmap_get_reg function to return 'right' word address of
'unsigned long' bitmap value in case of BE 64bit image.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 virt/kvm/arm/vgic.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 529c336..d0a1a24 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -101,14 +101,34 @@ static u32 vgic_nr_lr;
 
 static unsigned int vgic_maint_irq;
 
+/*
+ * struct vgic_bitmap contains union that provides two view of
+ * the same data. In one case it is an array of registers of
+ * u32 type (.reg), and in the other case it is a bitmape, which is
+ * an array of 'unsgined long' (.reg_ul). It all works well in
+ * case of 32-bit (u32 and 'unsigned long' have the same size).
+ * It alos works well in 64-bit LE, but breaks on 64-bit BE.
+ * In this case word sized register of even index actually resides
+ * in least significant word of 'unsigned long' which has address
+ * at offset plus 4 bytes. And word sized register of odd index
+ * resides at most significant of 'unsigned long' which has offset
+ * minus 4 bytes. Define REG_OFFSET_SWIZZLE that would help to
+ * change offset of register in case of BE 64bit system.
+ */
+#if defined(CONFIG_CPU_BIG_ENDIAN) && BITS_PER_LONG == 64
+#define REG_OFFSET_SWIZZLE	1
+#else
+#define REG_OFFSET_SWIZZLE	0
+#endif
+
 static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
 				int cpuid, u32 offset)
 {
 	offset >>= 2;
 	if (!offset)
-		return x->percpu[cpuid].reg;
+		return x->percpu[cpuid].reg + (offset ^ REG_OFFSET_SWIZZLE);
 	else
-		return x->shared.reg + offset - 1;
+		return x->shared.reg + ((offset - 1) ^ REG_OFFSET_SWIZZLE);
 }
 
 static int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
-- 
1.8.1.4
