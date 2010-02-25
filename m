From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-15?q?M=FCes?=)
Date: Thu, 25 Feb 2010 15:12:15 +0100
Subject: [PATCH2/5] at91_mci: fix timeout errors
Message-ID: <201002251512.16013.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

this is thes second part of my fixes and improvements for the at91_mci driver.

It fixes two timeout errors, one for slow SDHC cards and one for slow users.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>

---
diff -ur linux-2.6.33-rc8-pointer/drivers/mmc/host/at91_mci.c linux-2.6.33-rc8-times/drivers/mmc/host/at91_mci.c
--- linux-2.6.33-rc8-pointer/drivers/mmc/host/at91_mci.c	2010-02-25 14:01:24.603239221 +0100
+++ linux-2.6.33-rc8-times/drivers/mmc/host/at91_mci.c	2010-02-25 14:14:24.211239350 +0100
@@ -756,7 +756,8 @@
 	host->request = mrq;
 	host->flags = 0;
 
-	mod_timer(&host->timer, jiffies +  HZ);
+	/* more than 1s timeout seen with takeMS sdhc cards */
+	mod_timer(&host->timer, jiffies +  2 * HZ);
 
 	at91_mci_process_next(host);
 }
@@ -944,7 +945,8 @@
 			pr_debug("****** Resetting SD-card bus width ******\n");
 			at91_mci_write(host, AT91_MCI_SDCR, at91_mci_read(host, AT91_MCI_SDCR) & ~AT91_MCI_SDCBUS);
 		}
-		mmc_detect_change(host->mmc, msecs_to_jiffies(100));
+		/* 0.5s is needed here because of early switch firing. */
+		mmc_detect_change(host->mmc, msecs_to_jiffies(500));
 	}
 	return IRQ_HANDLED;
 }
---
best regards
 
i. A. Wolfgang M?es
-- 
Auerswald Gesellschaft f?r Datensysteme mbH
Hardware Development
Telefon: +49 (0)5306 9219 562
Telefax: +49 (0)5306 9219 94 
E-Mail: Wolfgang.Mues at Auerswald.de
Web: http://www.auerswald.de
 
--------------------------------------------------------------
Auerswald Gesellschaft f?r Datensysteme mbH
Vor den Grash?fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
