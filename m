From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 03 Aug 2015 06:44:21 +0200
Subject: [PATCH v2 0/4] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <CAAEAJfB3caa+DmJN=Pa8brx0uGC11QA29KJb3NQdJjXTgw-yuA@mail.gmail.com>
 (Ezequiel Garcia's message of "Sun, 2 Aug 2015 23:49:55 -0300")
References: <1436281707-20106-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150717134159.GC10608@kwain> <55A912F0.7080605@vanguardiasur.com.ar>
 <87h9p2is8e.fsf@belgarion.home>
 <CAAEAJfCcdioVQKZs9U3DP6H94BiuQ2qU21DsMKevS5+j+-XEKA@mail.gmail.com>
 <87wpxufw2v.fsf@belgarion.home>
 <CAAEAJfB3caa+DmJN=Pa8brx0uGC11QA29KJb3NQdJjXTgw-yuA@mail.gmail.com>
Message-ID: <87si81m15m.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> writes:

> Just tested linux-next (hence *without* the patchset) and I see
> the same "Wait time out". In other words, pxa3xx-nand is broken
> on PXA :/
>
> Interestingly, the culprit doesn't seem to be in pxa3xx-nand itself.
> Reverting the recent commits on pxa3xx-nand doesn't help.
>
> ce914e6 mtd: nand: pxa3xx: fix build on ARM64
> afca11e mtd: nand: pxa3xx: Switch FIFO draining to jiffies-based timeout
> e5860c1 mtd: pxa3xx_nand: cleanup wait_for_completion handling
> 7c2f717 mtd: pxa3xx_nand: initialiaze pxa3xx_flash_ids to 0
> ed446cc Merge MTD updates into -next
> e423c90 mtd: pxa3xx_nand: fix driver when num_cs is 0
> 2454225 mtd: pxa3xx-nand: handle PIO in threaded interrupt
> 8dad038 mtd: nand: pxa3xx: Fix PIO FIFO draining
> b7e46062 mtd: pxa3xx_nand: make the driver work on big-endian systems
> 5b3e507 mtd: nand: pxa3xx: Use ECC strength and step size devicetree binding
> eee0166 mtd: nand: pxa3xx: Clean pxa_ecc_init() error handling
> 17754ad mtd: nand: pxa3xx: Make of_device_id array const
> e634ce5 mtd: nand: pxa3xx: Print actual ECC strength in error message
>
> Yet v3.18 succeeds to pass a few NAND blocks on nandtest.
>
> Robert: any ideas?
Actually yes, I worked on that this weekend.
Would you try the following patch [1] to see if it works for you ?

The issue I see is that :
 - there is a bug in the clk driver for pxa3xx I introduced (CKEN_AB)
 - and shutting down the GCU clock prevents the NAND from working (I can't
 explain that one yet)

Cheers.

-- 
Robert

[1] Clocks patch
---8>---
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index c677b9ab5367..a47a0c40f937 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -126,7 +126,7 @@ PARENTS(pxa3xx_ac97_bus) = { "ring_osc_60mhz", "ac97" };
 PARENTS(pxa3xx_sbus) = { "ring_osc_60mhz", "system_bus" };
 PARENTS(pxa3xx_smemcbus) = { "ring_osc_60mhz", "smemc" };
 
-#define CKEN_AB(bit) ((CKEN_ ## bit > 31) ? &CKENA : &CKENB)
+#define CKEN_AB(bit) ((CKEN_ ## bit > 31) ? &CKENB : &CKENA)
 #define PXA3XX_CKEN(dev_id, con_id, parents, mult_lp, div_lp, mult_hp,	\
 		    div_hp, bit, is_lp, flags)				\
 	PXA_CKEN(dev_id, con_id, bit, parents, mult_lp, div_lp,		\
@@ -136,6 +136,10 @@ PARENTS(pxa3xx_smemcbus) = { "ring_osc_60mhz", "smemc" };
 			 mult_hp, div_hp, delay)			\
 	PXA3XX_CKEN(dev_id, con_id, pxa3xx_pbus_parents, mult_lp,	\
 		    div_lp, mult_hp, div_hp, bit, pxa3xx_is_ring_osc_forced, 0)
+#define PXA3XX_PBUS_CKENF(dev_id, con_id, bit, mult_lp, div_lp,		\
+			  mult_hp, div_hp, delay, flag)			\
+	PXA3XX_CKEN(dev_id, con_id, pxa3xx_pbus_parents, mult_lp,	\
+		    div_lp, mult_hp, div_hp, bit, pxa3xx_is_ring_osc_forced, flag)
 #define PXA3XX_CKEN_1RATE(dev_id, con_id, bit, parents)			\
 	PXA_CKEN_1RATE(dev_id, con_id, bit, parents,			\
 		       CKEN_AB(bit), (CKEN_ ## bit % 32), 0)
@@ -173,13 +177,13 @@ static struct desc_clk_cken pxa3xx_clocks[] __initdata = {
 
 static struct desc_clk_cken pxa300_310_clocks[] __initdata = {
 
-	PXA3XX_PBUS_CKEN("pxa3xx-gcu", NULL, PXA300_GCU, 1, 1, 1, 1, 0),
-	PXA3XX_PBUS_CKEN("pxa3xx-nand", NULL, NAND, 1, 2, 1, 4, 0),
+	PXA3XX_PBUS_CKENF("pxa3xx-gcu", NULL, PXA300_GCU, 1, 1, 1, 1, 0, CLK_IGNORE_UNUSED),
+	PXA3XX_PBUS_CKENF("pxa3xx-nand", NULL, NAND, 1, 2, 1, 4, 0, CLK_IGNORE_UNUSED),
 	PXA3XX_CKEN_1RATE("pxa3xx-gpio", NULL, GPIO, pxa3xx_13MHz_bus_parents),
 };
 
 static struct desc_clk_cken pxa320_clocks[] __initdata = {
-	PXA3XX_PBUS_CKEN("pxa3xx-nand", NULL, NAND, 1, 2, 1, 6, 0),
+	PXA3XX_PBUS_CKENF("pxa3xx-nand", NULL, NAND, 1, 2, 1, 4, 0, CLK_IGNORE_UNUSED),
 	PXA3XX_PBUS_CKEN("pxa3xx-gcu", NULL, PXA320_GCU, 1, 1, 1, 1, 0),
 	PXA3XX_CKEN_1RATE("pxa3xx-gpio", NULL, GPIO, pxa3xx_13MHz_bus_parents),
 };
@@ -187,7 +191,7 @@ static struct desc_clk_cken pxa320_clocks[] __initdata = {
 static struct desc_clk_cken pxa93x_clocks[] __initdata = {
 
 	PXA3XX_PBUS_CKEN("pxa3xx-gcu", NULL, PXA300_GCU, 1, 1, 1, 1, 0),
-	PXA3XX_PBUS_CKEN("pxa3xx-nand", NULL, NAND, 1, 2, 1, 4, 0),
+	PXA3XX_PBUS_CKENF("pxa3xx-nand", NULL, NAND, 1, 2, 1, 4, 0, CLK_IGNORE_UNUSED),
 	PXA3XX_CKEN_1RATE("pxa93x-gpio", NULL, GPIO, pxa3xx_13MHz_bus_parents),
 };
 
