From: jiri.prchal@aksignal.cz (=?UTF-8?B?UHJjaGFsIEppxZnDrQ==?=)
Date: Wed, 20 Jun 2012 10:15:04 +0200
Subject: [PATCH]  mmc: at91: fix bus speed
Message-ID: <4FE18688.4000700@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch change minimum and maximum clock speed because some noname cards doesn't work during init even at 375kHz and 
new cards (SD v. 3.0) can run at 50 or 100 MHz.
Also aded clkdiv register overrun fix when setting low speeds.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---

--- linux/linux-3.5-rc3/drivers/mmc/host/at91_mci.c.orig	2012-06-17 02:25:17.000000000 +0200
+++ linux/linux-3.5-rc3/drivers/mmc/host/at91_mci.c	2012-06-18 11:01:49.751415984 +0200
@@ -724,6 +724,10 @@ static void at91_mci_set_ios(struct mmc_
  		else
  			clkdiv = (at91_master_clock / ios->clock) / 2;

+		/* set maximum divider */
+		if (clkdiv > 255)
+			clkdiv = 255;
+
  		pr_debug("clkdiv = %d. mcck = %ld\n", clkdiv,
  			at91_master_clock / (2 * (clkdiv + 1)));
  	}
@@ -948,8 +952,8 @@ static int __init at91_mci_probe(struct
  	}

  	mmc->ops = &at91_mci_ops;
-	mmc->f_min = 375000;
-	mmc->f_max = 25000000;
+	mmc->f_min = 200000; /* not all cards can run at 375kHz */
+	mmc->f_max = 100000000; /* new cards can run at 100MHz */
  	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
  	mmc->caps = 0;
