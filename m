From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:56 +0200
Subject: [PULL 48/50] ARM: gic-v3: Work around definition of gic_write_bpr1
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-49-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

A new accessor for gic_write_bpr1 is added to arch_gicv3.h in 4.9,
whilst the CP15 accessors are redifined in a separate branch.
This leads to a horrible clash, where the new accessor ends up with
a crap "asm volatile" definition.

Work around this by carrying our own definition of gic_write_bpr1,
creating a small conflict which will be obvious to resolve.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 996848e..1fee657 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -216,6 +216,15 @@ static inline void gic_write_sre(u32 val)
 	isb();
 }
 
+static inline void gic_write_bpr1(u32 val)
+{
+#if defined(__write_sysreg) && defined(ICC_BPR1)
+	write_sysreg(val, ICC_BPR1);
+#else
+	asm volatile("mcr " __stringify(ICC_BPR1) : : "r" (val));
+#endif
+}
+
 /*
  * Even in 32bit systems that use LPAE, there is no guarantee that the I/O
  * interface provides true 64bit atomic accesses, so using strd/ldrd doesn't
-- 
2.9.0
