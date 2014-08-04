From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:54 +0200
Subject: [GIT PULL 37/51] ARM64: KVM: fix vgic_bitmap_get_reg function for BE
 64bit case
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-38-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

Fix vgic_bitmap_get_reg function to return 'right' word address of
'unsigned long' bitmap value in case of BE 64bit image.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index b0edc8c..ede8f64 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -98,14 +98,34 @@ static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
 static const struct vgic_ops *vgic_ops;
 static const struct vgic_params *vgic;
 
+/*
+ * struct vgic_bitmap contains unions that provide two views of
+ * the same data. In one case it is an array of registers of
+ * u32's, and in the other case it is a bitmap of unsigned
+ * longs.
+ *
+ * This does not work on 64-bit BE systems, because the bitmap access
+ * will store two consecutive 32-bit words with the higher-addressed
+ * register's bits at the lower index and the lower-addressed register's
+ * bits at the higher index.
+ *
+ * Therefore, swizzle the register index when accessing the 32-bit word
+ * registers to access the right register's value.
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
2.0.0
