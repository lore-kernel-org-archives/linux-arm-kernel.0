From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:41 +0200
Subject: [RFC PATCH 11/15] ARM: uncompress: Call arch_decomp_setup by default
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-11-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the initialization of the ucuart uses arch_decomp_setup,
almost all machines use it, so make this the default behaviour.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/print.c                  |    8 --------
 arch/arm/mach-mmp/include/mach/uncompress.h       |    2 --
 arch/arm/mach-picoxcell/include/mach/uncompress.h |    1 +
 arch/arm/mach-rpc/include/mach/uncompress.h       |    2 --
 arch/arm/mach-s5p64x0/include/mach/uncompress.h   |    2 --
 arch/arm/mach-shmobile/include/mach/uncompress.h  |    2 ++
 arch/arm/mach-ux500/include/mach/uncompress.h     |    2 --
 arch/arm/plat-samsung/include/plat/uncompress.h   |    2 --
 8 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/compressed/print.c b/arch/arm/boot/compressed/print.c
index fbffc99..24a08d4 100644
--- a/arch/arm/boot/compressed/print.c
+++ b/arch/arm/boot/compressed/print.c
@@ -56,8 +56,6 @@ struct uncompress_uart ucuart;
 
 #ifdef ARCH_HAVE_UCUART_GENERIC
 
-#define ARCH_HAVE_DECOMP_SETUP
-
 #include <linux/io.h>
 #include <linux/serial_reg.h>
 #include <linux/amba/serial.h>
@@ -224,13 +222,7 @@ void error(char *x)
 	while(1);	/* Halt */
 }
 
-#ifdef ARCH_HAVE_DECOMP_SETUP
 void inline decomp_setup(void)
 {
 	arch_decomp_setup();
 }
-#else /* ARCH_HAVE_DECOMP_SETUP */
-void inline decomp_setup(void)
-{
-}
-#endif /* ARCH_HAVE_DECOMP_SETUP */
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
index 4cafe10..e9bf8bf 100644
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ b/arch/arm/mach-mmp/include/mach/uncompress.h
@@ -12,8 +12,6 @@
 #define UART2_BASE	(APB_PHYS_BASE + 0x17000)
 #define UART3_BASE	(APB_PHYS_BASE + 0x18000)
 
-#define ARCH_HAVE_DECOMP_SETUP
-
 static inline void arch_decomp_setup(void)
 {
 	if (machine_is_avengers_lite())
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
index f04f368..db46249 100644
--- a/arch/arm/mach-picoxcell/include/mach/uncompress.h
+++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
@@ -17,3 +17,4 @@
  */
 #define putc(c)
 #define flush()
+#define arch_decomp_setup()
diff --git a/arch/arm/mach-rpc/include/mach/uncompress.h b/arch/arm/mach-rpc/include/mach/uncompress.h
index 5ea3974..0fd4b0b 100644
--- a/arch/arm/mach-rpc/include/mach/uncompress.h
+++ b/arch/arm/mach-rpc/include/mach/uncompress.h
@@ -109,8 +109,6 @@ static inline void flush(void)
 {
 }
 
-#define ARCH_HAVE_DECOMP_SETUP
-
 /*
  * Setup for decompression
  */
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
index 8d537eb..00b70b8 100644
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -151,8 +151,6 @@ static inline void arch_enable_uart_fifo(void)
 #define arch_enable_uart_fifo() do { } while(0)
 #endif
 
-#define ARCH_HAVE_DECOMP_SETUP
-
 static void arch_decomp_setup(void)
 {
 	/*
diff --git a/arch/arm/mach-shmobile/include/mach/uncompress.h b/arch/arm/mach-shmobile/include/mach/uncompress.h
index b2b2860..462e84e 100644
--- a/arch/arm/mach-shmobile/include/mach/uncompress.h
+++ b/arch/arm/mach-shmobile/include/mach/uncompress.h
@@ -12,4 +12,6 @@ static inline void flush(void)
 {
 }
 
+#define arch_decomp_setup()
+
 #endif /* __ASM_MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 7e3b48a..eb30110 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -21,8 +21,6 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
-#define ARCH_HAVE_DECOMP_SETUP
-
 static inline void arch_decomp_setup(void)
 {
 	/* Check in run time if we run on an U8500 or U5500 */
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index b10e0be..94fecf9 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -130,8 +130,6 @@ static inline void arch_enable_uart_fifo(void)
 #define arch_enable_uart_fifo() do { } while(0)
 #endif
 
-#define ARCH_HAVE_DECOMP_SETUP
-
 static void
 arch_decomp_setup(void)
 {
-- 
1.7.4.1
