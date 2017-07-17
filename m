From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Jul 2017 07:48:09 +0200
Subject: [PATCH 3/3] ARM: s3c24xx: Do not confuse local define with Kconfig
In-Reply-To: <1500270489-14749-1-git-send-email-krzk@kernel.org>
References: <1500270489-14749-1-git-send-email-krzk@kernel.org>
Message-ID: <1500270489-14749-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop CONFIG_ prefix from a local DEBUG_RESUME define guarding some
debugging code to avoid any confusion with Kconfig options.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/sleep.S | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/sleep.S b/arch/arm/mach-s3c24xx/sleep.S
index d833d616bd2e..b859268fa8da 100644
--- a/arch/arm/mach-s3c24xx/sleep.S
+++ b/arch/arm/mach-s3c24xx/sleep.S
@@ -33,10 +33,11 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
 
-/* CONFIG_DEBUG_RESUME is dangerous if your bootloader does not
+/*
+ * S3C24XX_DEBUG_RESUME is dangerous if your bootloader does not
  * reset the UART configuration, only enable if you really need this!
-*/
-//#define CONFIG_DEBUG_RESUME
+ */
+//#define S3C24XX_DEBUG_RESUME
 
 	.text
 
@@ -71,13 +72,13 @@ ENTRY(s3c_cpu_resume)
 	str	r12, [ r14, #0x54 ]
 #endif
 
-#ifdef CONFIG_DEBUG_RESUME
+#ifdef S3C24XX_DEBUG_RESUME
 	mov	r3, #'L'
 	strb	r3, [ r2, #S3C2410_UTXH ]
 1001:
 	ldrb	r14, [ r3, #S3C2410_UTRSTAT ]
 	tst	r14, #S3C2410_UTRSTAT_TXE
 	beq	1001b
-#endif /* CONFIG_DEBUG_RESUME */
+#endif /* S3C24XX_DEBUG_RESUME */
 
 	b	cpu_resume
-- 
2.7.4
