From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Sep 2012 16:12:46 +0200
Subject: [PATCH] ARM: Orion5x: ts78xx: Add IOMEM for virtual addresses.
Message-ID: <1348841566-18308-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also convert logical or to + for register offsets from base
addresses. This fixes a number of warnings currently seen in
linux-next:

warning: passing argument 2 of '__raw_writeb' makes pointer from
interger without cast.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index b420327..b0727dc 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -36,7 +36,7 @@
  * FPGA - lives where the PCI bus would be at ORION5X_PCI_MEM_PHYS_BASE
  */
 #define TS78XX_FPGA_REGS_PHYS_BASE	0xe8000000
-#define TS78XX_FPGA_REGS_VIRT_BASE	0xff900000
+#define TS78XX_FPGA_REGS_VIRT_BASE	IOMEM(0xff900000)
 #define TS78XX_FPGA_REGS_SIZE		SZ_1M
 
 static struct ts78xx_fpga_data ts78xx_fpga = {
@@ -50,7 +50,7 @@ static struct ts78xx_fpga_data ts78xx_fpga = {
  ****************************************************************************/
 static struct map_desc ts78xx_io_desc[] __initdata = {
 	{
-		.virtual	= TS78XX_FPGA_REGS_VIRT_BASE,
+		.virtual	= (unsigned long)TS78XX_FPGA_REGS_VIRT_BASE,
 		.pfn		= __phys_to_pfn(TS78XX_FPGA_REGS_PHYS_BASE),
 		.length		= TS78XX_FPGA_REGS_SIZE,
 		.type		= MT_DEVICE,
@@ -80,8 +80,8 @@ static struct mv_sata_platform_data ts78xx_sata_data = {
 /*****************************************************************************
  * RTC M48T86 - nicked^Wborrowed from arch/arm/mach-ep93xx/ts72xx.c
  ****************************************************************************/
-#define TS_RTC_CTRL	(TS78XX_FPGA_REGS_VIRT_BASE | 0x808)
-#define TS_RTC_DATA	(TS78XX_FPGA_REGS_VIRT_BASE | 0x80c)
+#define TS_RTC_CTRL	(TS78XX_FPGA_REGS_VIRT_BASE + 0x808)
+#define TS_RTC_DATA	(TS78XX_FPGA_REGS_VIRT_BASE + 0x80c)
 
 static unsigned char ts78xx_ts_rtc_readbyte(unsigned long addr)
 {
@@ -162,8 +162,8 @@ static void ts78xx_ts_rtc_unload(void)
 /*****************************************************************************
  * NAND Flash
  ****************************************************************************/
-#define TS_NAND_CTRL	(TS78XX_FPGA_REGS_VIRT_BASE | 0x800)	/* VIRT */
-#define TS_NAND_DATA	(TS78XX_FPGA_REGS_PHYS_BASE | 0x804)	/* PHYS */
+#define TS_NAND_CTRL	(TS78XX_FPGA_REGS_VIRT_BASE + 0x800)	/* VIRT */
+#define TS_NAND_DATA	(TS78XX_FPGA_REGS_PHYS_BASE + 0x804)	/* PHYS */
 
 /*
  * hardware specific access to control-lines
-- 
1.7.10.4
