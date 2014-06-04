From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jun 2014 15:33:55 +0200
Subject: [PATCH 1/4] ARM: s5p: cut the custom ARCH_NR_GPIOS definition
In-Reply-To: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1401888838-3126-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of GPIOs defined for the different S5P platforms using
the tricky #define macros are actually as follows:

S5P64x0: 180 GPIOs
S5PC100: 115 GPIOs
S5PV210: 252 GPIOs

The include file <asm-generic/gpio.h> will automatically bump us
to 256 GPIOs which is a nice default value that happens to encompass
all the S5P platform requirements under its roof.

Cut ARCH_NR_GPIOS and the custom spacing macro for extra GPIOs
that is not used anywhere in the kernel.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-s5p64x0/include/mach/gpio.h |  4 ----
 arch/arm/mach-s5pc100/include/mach/gpio.h |  3 ---
 arch/arm/mach-s5pv210/include/mach/gpio.h |  4 ----
 arch/arm/plat-samsung/Kconfig             | 16 ----------------
 4 files changed, 27 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-s5p64x0/include/mach/gpio.h
index 06cd3c9b16ac..cbd325e14477 100644
--- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
+++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
@@ -125,8 +125,4 @@ enum s5p6450_gpio_number {
 
 #define S3C_GPIO_END		S5P64X0_GPIO_END
 
-/* define the number of gpios we need to the one after the last GPIO range */
-
-#define ARCH_NR_GPIOS		(S5P64X0_GPIO_END + CONFIG_SAMSUNG_GPIO_EXTRA)
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index 5e1a924b595f..291c57504bab 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -138,7 +138,4 @@ enum s5p_gpio_number {
 /* It used the end of the S5PC100 gpios */
 #define S3C_GPIO_END		S5PC100_GPIO_END
 
-/* define the number of gpios we need to the one after the MP04() range */
-#define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index 6c8b903c02e4..e6f80d57c38e 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -133,8 +133,4 @@ enum s5p_gpio_number {
 #define S5PV210_GPIO_END	(S5PV210_MP05(S5PV210_GPIO_MP05_NR) + 1)
 #define S3C_GPIO_END		S5PV210_GPIO_END
 
-/* define the number of gpios we need to the one after the MP05() range */
-#define ARCH_NR_GPIOS		(S5PV210_MP05(S5PV210_GPIO_MP05_NR) +	\
-				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 243dfcb2ca0e..68824e617a21 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -120,22 +120,6 @@ config S5P_GPIO_DRVSTR
 	  Internal configuration to get and set correct GPIO driver strength
 	  helper
 
-config SAMSUNG_GPIO_EXTRA
-	int "Number of additional GPIO pins"
-	default 128 if SAMSUNG_GPIO_EXTRA128
-	default 64 if SAMSUNG_GPIO_EXTRA64
-	default 0
-	help
-	  Use additional GPIO space in addition to the GPIO's the SOC
-	  provides. This allows expanding the GPIO space for use with
-	  GPIO expanders.
-
-config SAMSUNG_GPIO_EXTRA64
-	bool
-
-config SAMSUNG_GPIO_EXTRA128
-	bool
-
 config S3C_GPIO_SPACE
 	int "Space between gpio banks"
 	default 0
-- 
1.9.3
