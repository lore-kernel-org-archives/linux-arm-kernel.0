From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 18 Jun 2010 07:48:55 +0200
Subject: [PATCH 4/4] pxa2xx/pcmcia: Prepare for pxa320
In-Reply-To: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1276840135-5982-4-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA320 also supports PCMCIA/CF interface. This patch generalizes register access
in pxa2xx_pcmcia so the pxa320 is now supported as well.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_base.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index f370476..3d63d2f 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -85,6 +85,12 @@
 #define MCXX_ASST_SHIFT     (7)
 #define MCXX_HOLD_SHIFT     (14)
 
+#define	PXA2XX_SMC_BASE		(0x48000000)
+#define	PXA3XX_SMC_BASE		(0x4a000000)
+#define	MCMEM_OFFSET		(0x28)
+#define	MCATT_OFFSET		(0x30)
+#define	MCIO_OFFSET		(0x38)
+
 static inline u_int pxa2xx_mcxx_hold(u_int pcmcia_cycle_ns,
 				     u_int mem_clk_10khz)
 {
@@ -115,39 +121,62 @@ static inline u_int pxa2xx_pcmcia_cmd_time(u_int mem_clk_10khz,
 	return (300000 * (pcmcia_mcxx_asst + 1) / mem_clk_10khz);
 }
 
+static inline void pxa2xx_pcmcia_set_reg( uint32_t reg, uint32_t sock,
+					uint32_t val )
+{
+	if (cpu_is_pxa2xx())
+		reg = PXA2XX_SMC_BASE | (reg + (sock << 4));
+	if (cpu_is_pxa320())
+		reg |= PXA3XX_SMC_BASE;
+
+	__REG2(reg, val);
+}
+
 static int pxa2xx_pcmcia_set_mcmem( int sock, int speed, int clock )
 {
-	MCMEM(sock) = ((pxa2xx_mcxx_setup(speed, clock)
+	uint32_t val;
+
+	val = ((pxa2xx_mcxx_setup(speed, clock)
 		& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
 		| ((pxa2xx_mcxx_asst(speed, clock)
 		& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
+	pxa2xx_pcmcia_set_reg(MCMEM_OFFSET, sock, val);
+
 	return 0;
 }
 
 static int pxa2xx_pcmcia_set_mcio( int sock, int speed, int clock )
 {
-	MCIO(sock) = ((pxa2xx_mcxx_setup(speed, clock)
+	uint32_t val;
+
+	val = ((pxa2xx_mcxx_setup(speed, clock)
 		& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
 		| ((pxa2xx_mcxx_asst(speed, clock)
 		& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
+	pxa2xx_pcmcia_set_reg(MCIO_OFFSET, sock, val);
+
 	return 0;
 }
 
 static int pxa2xx_pcmcia_set_mcatt( int sock, int speed, int clock )
 {
-	MCATT(sock) = ((pxa2xx_mcxx_setup(speed, clock)
+	uint32_t val;
+
+	val = ((pxa2xx_mcxx_setup(speed, clock)
 		& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
 		| ((pxa2xx_mcxx_asst(speed, clock)
 		& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
+	pxa2xx_pcmcia_set_reg(MCATT_OFFSET, sock, val);
+
 	return 0;
 }
 
@@ -276,6 +305,11 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 	if (!ops)
 		return -ENODEV;
 
+	if (cpu_is_pxa320() && ops->nr > 1) {
+		dev_err(&dev->dev, "pxa320 supports only one pcmcia slot");
+		return -EINVAL;
+	}
+
 	pxa2xx_drv_pcmcia_ops(ops);
 
 	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
-- 
1.7.1
