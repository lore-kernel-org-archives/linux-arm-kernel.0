From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:34:14 +0200
Subject: [PATCH 4/9] at91: remove AT91_DBGU offset from dbgu register macro
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305045259-23066-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91sam9260.c              |    2 +-
 arch/arm/mach-at91/at91sam9rl.c               |    2 +-
 arch/arm/mach-at91/include/mach/at91_dbgu.h   |   27 +++++++++++++-----------
 arch/arm/mach-at91/include/mach/cpu.h         |    8 +++---
 arch/arm/mach-at91/include/mach/debug-macro.S |   14 ++++++------
 5 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 1f3abb4..291beb7 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -336,7 +336,7 @@ static void __init at91sam9xe_map_io(void)
 {
 	unsigned long cidr, sram_size;
 
-	cidr = at91_sys_read(AT91_DBGU_CIDR);
+	cidr = dbgu_readl(AT91_DBGU, CIDR);
 
 	switch (cidr & AT91_CIDR_SRAMSIZ) {
 		case AT91_CIDR_SRAMSIZ_32K:
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index c8de47f..86fc31c 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -299,7 +299,7 @@ static void __init at91sam9rl_map_io(void)
 {
 	unsigned long cidr, sram_size;
 
-	cidr = at91_sys_read(AT91_DBGU_CIDR);
+	cidr = dbgu_readl(AT91_DBGU, CIDR);
 
 	switch (cidr & AT91_CIDR_SRAMSIZ) {
 		case AT91_CIDR_SRAMSIZ_32K:
diff --git a/arch/arm/mach-at91/include/mach/at91_dbgu.h b/arch/arm/mach-at91/include/mach/at91_dbgu.h
index 6dcaa77..bacf3e8 100644
--- a/arch/arm/mach-at91/include/mach/at91_dbgu.h
+++ b/arch/arm/mach-at91/include/mach/at91_dbgu.h
@@ -16,22 +16,25 @@
 #ifndef AT91_DBGU_H
 #define AT91_DBGU_H
 
+#define dbgu_readl(dbgu, field) \
+	__raw_readl(AT91_VA_BASE_SYS + dbgu + AT91_DBUG_ ## field)
+
 #ifdef AT91_DBGU
-#define AT91_DBGU_CR		(AT91_DBGU + 0x00)	/* Control Register */
-#define AT91_DBGU_MR		(AT91_DBGU + 0x04)	/* Mode Register */
-#define AT91_DBGU_IER		(AT91_DBGU + 0x08)	/* Interrupt Enable Register */
+#define AT91_DBGU_CR		(0x00)	/* Control Register */
+#define AT91_DBGU_MR		(0x04)	/* Mode Register */
+#define AT91_DBGU_IER		(0x08)	/* Interrupt Enable Register */
 #define		AT91_DBGU_TXRDY		(1 << 1)		/* Transmitter Ready */
 #define		AT91_DBGU_TXEMPTY	(1 << 9)		/* Transmitter Empty */
-#define AT91_DBGU_IDR		(AT91_DBGU + 0x0c)	/* Interrupt Disable Register */
-#define AT91_DBGU_IMR		(AT91_DBGU + 0x10)	/* Interrupt Mask Register */
-#define AT91_DBGU_SR		(AT91_DBGU + 0x14)	/* Status Register */
-#define AT91_DBGU_RHR		(AT91_DBGU + 0x18)	/* Receiver Holding Register */
-#define AT91_DBGU_THR		(AT91_DBGU + 0x1c)	/* Transmitter Holding Register */
-#define AT91_DBGU_BRGR		(AT91_DBGU + 0x20)	/* Baud Rate Generator Register */
+#define AT91_DBGU_IDR		(0x0c)	/* Interrupt Disable Register */
+#define AT91_DBGU_IMR		(0x10)	/* Interrupt Mask Register */
+#define AT91_DBGU_SR		(0x14)	/* Status Register */
+#define AT91_DBGU_RHR		(0x18)	/* Receiver Holding Register */
+#define AT91_DBGU_THR		(0x1c)	/* Transmitter Holding Register */
+#define AT91_DBGU_BRGR		(0x20)	/* Baud Rate Generator Register */
 
-#define AT91_DBGU_CIDR		(AT91_DBGU + 0x40)	/* Chip ID Register */
-#define AT91_DBGU_EXID		(AT91_DBGU + 0x44)	/* Chip ID Extension Register */
-#define AT91_DBGU_FNR		(AT91_DBGU + 0x48)	/* Force NTRST Register [SAM9 only] */
+#define AT91_DBGU_CIDR		(0x40)	/* Chip ID Register */
+#define AT91_DBGU_EXID		(0x44)	/* Chip ID Extension Register */
+#define AT91_DBGU_FNR		(0x48)	/* Force NTRST Register [SAM9 only] */
 #define		AT91_DBGU_FNTRST	(1 << 0)		/* Force NTRST */
 
 #endif /* AT91_DBGU */
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index ab00372..0d81087 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -43,12 +43,12 @@
 
 static inline unsigned long at91_cpu_identify(void)
 {
-	return (at91_sys_read(AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
+	return (dbgu_readl(AT91_DBGU, CIDR) & ~AT91_CIDR_VERSION);
 }
 
 static inline unsigned long at91_cpu_fully_identify(void)
 {
-	return at91_sys_read(AT91_DBGU_CIDR);
+	return dbgu_readl(AT91_DBGU, CIDR);
 }
 
 #define ARCH_EXID_AT91SAM9M11	0x00000001
@@ -64,7 +64,7 @@ static inline unsigned long at91_cpu_fully_identify(void)
 
 static inline unsigned long at91_exid_identify(void)
 {
-	return at91_sys_read(AT91_DBGU_EXID);
+	return dbgu_readl(AT91_DBGU, EXID);
 }
 
 
@@ -74,7 +74,7 @@ static inline unsigned long at91_exid_identify(void)
 
 static inline unsigned long at91_arch_identify(void)
 {
-	return (at91_sys_read(AT91_DBGU_CIDR) & AT91_CIDR_ARCH);
+	return (dbgu_readl(AT91_DBGU, CIDR) & AT91_CIDR_ARCH);
 }
 
 #ifdef CONFIG_ARCH_AT91CAP9
diff --git a/arch/arm/mach-at91/include/mach/debug-macro.S b/arch/arm/mach-at91/include/mach/debug-macro.S
index 0f959fa..bc1e0b2 100644
--- a/arch/arm/mach-at91/include/mach/debug-macro.S
+++ b/arch/arm/mach-at91/include/mach/debug-macro.S
@@ -15,23 +15,23 @@
 #include <mach/at91_dbgu.h>
 
 	.macro	addruart, rp, rv
-	ldr	\rp, =(AT91_BASE_SYS + AT91_DBGU)		@ System peripherals (phys address)
-	ldr	\rv, =(AT91_VA_BASE_SYS	+ AT91_DBGU)		@ System peripherals (virt address)
+	ldr	\rp, =(AT91_BASE_SYS + AT91_DBGU)	@ System peripherals (phys address)
+	ldr	\rv, =(AT91_VA_BASE_SYS	+ AT91_DBGU)	@ System peripherals (virt address)
 	.endm
 
 	.macro	senduart,rd,rx
-	strb	\rd, [\rx, #(AT91_DBGU_THR - AT91_DBGU)]	@ Write to Transmitter Holding Register
+	strb	\rd, [\rx, #(AT91_DBGU_THR)]		@ Write to Transmitter Holding Register
 	.endm
 
 	.macro	waituart,rd,rx
-1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR - AT91_DBGU)]		@ Read Status Register
-	tst	\rd, #AT91_DBGU_TXRDY				@ DBGU_TXRDY = 1 when ready to transmit
+1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR)]		@ Read Status Register
+	tst	\rd, #AT91_DBGU_TXRDY			@ DBGU_TXRDY = 1 when ready to transmit
 	beq	1001b
 	.endm
 
 	.macro	busyuart,rd,rx
-1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR - AT91_DBGU)]		@ Read Status Register
-	tst	\rd, #AT91_DBGU_TXEMPTY				@ DBGU_TXEMPTY = 1 when transmission complete
+1001:	ldr	\rd, [\rx, #(AT91_DBGU_SR)]		@ Read Status Register
+	tst	\rd, #AT91_DBGU_TXEMPTY			@ DBGU_TXEMPTY = 1 when transmission complete
 	beq	1001b
 	.endm
 
-- 
1.7.4.1
