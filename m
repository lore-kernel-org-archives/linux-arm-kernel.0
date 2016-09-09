From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Sep 2016 12:16:03 +0100
Subject: [PATCH 4/6] arm64: KVM: Move GIC accessors to arch_gicv3.h
In-Reply-To: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
References: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
Message-ID: <1473419765-3437-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

Since we are going to share vgic-v3 save/restore code with ARM
keep arch specific accessors separately.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 13 +++++++++++++
 arch/arm64/kvm/hyp/vgic-v3-sr.c     | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 8ec88e5b290f..ae7dbd79e257 100644
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
index 5f8f80b4a224..f2dbd2e76dbd 100644
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
2.1.4
