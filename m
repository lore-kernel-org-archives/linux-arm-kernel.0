From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:46 +0200
Subject: [PULL 38/50] arm64: KVM: Move GIC accessors to arch_gicv3.h
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-39-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

Since we are going to share vgic-v3 save/restore code with ARM keep
arch specific accessors separately.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/arch_gicv3.h | 13 +++++++++++++
 arch/arm64/kvm/hyp/vgic-v3-sr.c     | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 8ec88e5..ae7dbd7 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -79,6 +79,19 @@
 #include <linux/stringify.h>
 #include <asm/barrier.h>
 
+#define read_gicreg(r)							\
+	({								\
+		u64 reg;						\
+		asm volatile("mrs_s %0, " __stringify(r) : "=r" (reg));	\
+		reg;							\
+	})
+
+#define write_gicreg(v,r)						\
+	do {								\
+		u64 __val = (v);					\
+		asm volatile("msr_s " __stringify(r) ", %0" : : "r" (__val));\
+	} while (0)
+
 /*
  * Low-level accessors
  *
diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index ee1ea63..3947095 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -24,19 +24,6 @@
 #define vtr_to_max_lr_idx(v)		((v) & 0xf)
 #define vtr_to_nr_pri_bits(v)		(((u32)(v) >> 29) + 1)
 
-#define read_gicreg(r)							\
-	({								\
-		u64 reg;						\
-		asm volatile("mrs_s %0, " __stringify(r) : "=r" (reg));	\
-		reg;							\
-	})
-
-#define write_gicreg(v,r)						\
-	do {								\
-		u64 __val = (v);					\
-		asm volatile("msr_s " __stringify(r) ", %0" : : "r" (__val));\
-	} while (0)
-
 static u64 __hyp_text __gic_v3_get_lr(unsigned int lr)
 {
 	switch (lr & 0xf) {
-- 
2.9.0
