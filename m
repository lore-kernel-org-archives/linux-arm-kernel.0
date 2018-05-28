From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 28 May 2018 10:40:16 +0200
Subject: [PATCH] arm: cntvoff: Add a function definition when !SMP
Message-ID: <20180528084016.9271-1-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The secure_cntvoff_init function is only compiled if CONFIG_SMP is set to
true. However, that will lead to linking errors if one uses this function
without an ifdef CONFIG_SMP guard, which isn't ideal.

Provide a dumb implementation when CONFIG_SMP is false so that we don't end
up with a compilation error on our hands.

Cc: Olof Johansson <olof@lixom.net>
Cc: Myl?ne Josserand <mylene.josserand@bootlin.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Fixes: cad160ed0a94 ("ARM: shmobile: Convert file to use cntvoff")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/include/asm/secure_cntvoff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/secure_cntvoff.h b/arch/arm/include/asm/secure_cntvoff.h
index 1f93aee1f630..ce96cd781838 100644
--- a/arch/arm/include/asm/secure_cntvoff.h
+++ b/arch/arm/include/asm/secure_cntvoff.h
@@ -3,6 +3,10 @@
 #ifndef __ASMARM_ARCH_CNTVOFF_H
 #define __ASMARM_ARCH_CNTVOFF_H
 
+#ifdef CONFIG_SMP
 extern void secure_cntvoff_init(void);
+#else
+static inline void secure_cntvoff_init(void) {};
+#endif
 
 #endif
-- 
2.17.0
