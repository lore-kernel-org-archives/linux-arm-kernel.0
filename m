From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 02 Dec 2009 21:58:25 +0800
Subject: [PATCH 4/4]ARM: NUC900: enable uart support for nuc932
Message-ID: <4B167281.1090708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

This patch enables uart support for nuc932.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/clock.h          |    2 ++
 arch/arm/mach-w90x900/cpu.h            |    2 +-
 arch/arm/mach-w90x900/mach-nuc932evb.c |    1 +
 arch/arm/mach-w90x900/nuc932.c         |   10 ++++++++++
 arch/arm/mach-w90x900/nuc932.h         |    1 +
 5 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/clock.h b/arch/arm/mach-w90x900/clock.h
index b9ea2e6..2a2a54a 100644
--- a/arch/arm/mach-w90x900/clock.h
+++ b/arch/arm/mach-w90x900/clock.h
@@ -14,8 +14,10 @@
 
 #ifndef CONFIG_CPU_NUC932
 #define EXTCLK	15000000
+#define UARTCLK	11313600
 #else
 #define EXTCLK	27000000
+#define UARTCLK	57139200
 #endif
 
 void nuc900_clk_enable(struct clk *clk, int enable);
diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
index 4493d4d..300e35b 100644
--- a/arch/arm/mach-w90x900/cpu.h
+++ b/arch/arm/mach-w90x900/cpu.h
@@ -30,7 +30,7 @@
 	.membase	= name##_BA,				\
 	.mapbase	= name##_PA,				\
 	.irq		= IRQ_##name,				\
-	.uartclk	= 11313600,				\
+	.uartclk	= UARTCLK,				\
 	.regshift	= 2,					\
 	.iotype		= UPIO_MEM,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,	\
diff --git a/arch/arm/mach-w90x900/mach-nuc932evb.c b/arch/arm/mach-w90x900/mach-nuc932evb.c
index bcc67d2..9f8a3f9 100644
--- a/arch/arm/mach-w90x900/mach-nuc932evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc932evb.c
@@ -23,6 +23,7 @@ static void __init nuc932evb_map_io(void)
 {
 	nuc932_map_io();
 	nuc932_init_clocks();
+	nuc932_init_uartclk();
 }
 
 static void __init nuc932evb_init(void)
diff --git a/arch/arm/mach-w90x900/nuc932.c b/arch/arm/mach-w90x900/nuc932.c
index 140fa2f..44b1347 100644
--- a/arch/arm/mach-w90x900/nuc932.c
+++ b/arch/arm/mach-w90x900/nuc932.c
@@ -80,6 +80,16 @@ void __init nuc932_map_io(void)
 	nuc900_map_io(nuc932evb_iodesc, ARRAY_SIZE(nuc932evb_iodesc));
 }
 
+/*enable NUC932 uart clock*/
+
+void __init nuc932_init_uartclk(void)
+{
+	struct clk *ck_uart = clk_get(NULL, "uart");
+	BUG_ON(IS_ERR(ck_uart));
+
+	clk_enable(ck_uart);
+}
+
 /*Init NUC932 clock*/
 
 void __init nuc932_init_clocks(void)
diff --git a/arch/arm/mach-w90x900/nuc932.h b/arch/arm/mach-w90x900/nuc932.h
index 4cf1182..e0bafe7 100644
--- a/arch/arm/mach-w90x900/nuc932.h
+++ b/arch/arm/mach-w90x900/nuc932.h
@@ -26,3 +26,4 @@ extern struct sys_timer nuc900_timer;
 extern void nuc932_board_init(void);
 extern void nuc932_init_clocks(void);
 extern void nuc932_map_io(void);
+extern void nuc932_init_uartclk(void);
-- 
1.5.6.3
