From: user@jinso.co.jp (Nguyen Viet Dung)
Date: Mon,  1 Jul 2013 19:00:10 +0900
Subject: [PATCH 3/4] ARM: shmobile: r8a7790: add I2C clock
In-Reply-To: <1372672810-20609-1-git-send-email-user@jinso.co.jp>
References: <1372672810-20609-1-git-send-email-user@jinso.co.jp>
Message-ID: <1372672810-20609-4-git-send-email-user@jinso.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nguyen Viet Dung <nv-dung@jinso.co.jp>

This patch add clock for I2C bus.

Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index b393592..f4b0f2b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -50,6 +50,7 @@
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR7 0xe615014c
+#define SMSTPCR9 0xE6150994
 
 #define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
@@ -180,6 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP721, MSTP720,
 	MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
@@ -187,6 +189,10 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP931] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 31, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 30, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 29, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 28, 0), /* I2C3 */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP304] = SH_CLK_MSTP32(&cp_clk, SMSTPCR3, 4, 0), /* TPU0 */
@@ -226,6 +232,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("mp",		&mp_clk),
 	CLKDEV_CON_ID("qspi",		&qspi_clk),
 	CLKDEV_CON_ID("cp",		&cp_clk),
+	CLKDEV_CON_ID("peripheral_clk",	&hp_clk),
 
 	/* DIV4 */
 	CLKDEV_CON_ID("sdh",		&div4_clks[DIV4_SDH]),
@@ -249,6 +256,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.7.9.5
