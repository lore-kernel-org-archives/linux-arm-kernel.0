From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 11 Dec 2011 10:03:25 +0000
Subject: [PATCH] ARM: MM: Configure the number of banks
In-Reply-To: <1323048539-9573-1-git-send-email-boojin.kim@samsung.com>
References: <1323048539-9573-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <20111211100325.GR14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 10:28:59AM +0900, Boojin Kim wrote:
> This patch configures NR_BANKS by machine specific configuration.
> NR_BANKS should be increased to support bigger than 2GB memory.
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>

I'd much prefer to solve this a different way:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4676c19..d451945 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1126,6 +1126,11 @@ config ARM_TIMER_SP804
 
 source arch/arm/mm/Kconfig
 
+config ARM_NR_BANKS
+	int
+	default 16 if ARCH_EP93XX
+	default 8
+
 config IWMMXT
 	bool "Enable iWMMXt support"
 	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 915696d..23ebc0c 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -192,11 +192,7 @@ static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 /*
  * Memory map description
  */
-#ifdef CONFIG_ARCH_EP93XX
-# define NR_BANKS 16
-#else
-# define NR_BANKS 8
-#endif
+#define NR_BANKS	CONFIG_ARM_NR_BANKS
 
 struct membank {
 	phys_addr_t start;

so we don't introduce new dependencies for having a mach/memory.h.
