From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:22 +0200
Subject: [PATCH] i2c/nuc900: fix ancient build error
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As far as I can tell, this driver must have produced this error
for as long as it has been merged into the mainline kernel, but
it was never part of the normal build tests:

drivers/i2c/busses/i2c-nuc900.c: In function 'nuc900_i2c_probe':
drivers/i2c/busses/i2c-nuc900.c:601:17: error: request for member 'apbfreq' in something not a structure or union
  ret = (i2c->clk.apbfreq)/(pdata->bus_freq * 5) - 1;
                 ^

This is an attempt to get the driver to build and possibly
work correctly, although I do wonder whether we should just
remove it, as it has clearly never worked.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c at vger.kernel.org
Cc: Wan ZongShun <mcuos.com@gmail.org>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Baruch Siach <baruch@tkos.co.il>
---
 drivers/i2c/busses/i2c-nuc900.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index 36394d7..e3e9f95 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -598,7 +598,7 @@ static int nuc900_i2c_probe(struct platform_device *pdev)
 
 	clk_get_rate(i2c->clk);
 
-	ret = (i2c->clk.apbfreq)/(pdata->bus_freq * 5) - 1;
+	ret = clk_get_rate(i2c->clk)/(pdata->bus_freq * 5) - 1;
 	writel(ret & 0xffff, i2c->regs + DIVIDER);
 
 	/* find the IRQ for this unit (note, this relies on the init call to
-- 
1.8.3.2
