From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-15?q?M=FCes?=)
Date: Thu, 25 Feb 2010 15:01:50 +0100
Subject: [PATCH1/5] at91_mci: fix pointer errors
Message-ID: <201002251501.50256.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

this is thes first part of my fixes and improvements for the at91_mci driver.

It fixes two pointer errors, one which lead to memory overwrites if used with 
large chunks of data.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>

---
diff -ur linux-2.6.33-rc8-original/drivers/mmc/host/at91_mci.c linux-2.6.33-rc8-pointer/drivers/mmc/host/at91_mci.c
--- linux-2.6.33-rc8-original/drivers/mmc/host/at91_mci.c	2010-02-12 20:07:45.000000000 +0100
+++ linux-2.6.33-rc8-pointer/drivers/mmc/host/at91_mci.c	2010-02-25 14:01:24.603239221 +0100
@@ -227,11 +227,13 @@
 			for (index = 0; index < (amount / 4); index++)
 				*dmabuf++ = swab32(sgbuffer[index]);
 		} else {
-			memcpy(dmabuf, sgbuffer, amount);
-			dmabuf += amount;
+			char *tmpv = (char *)dmabuf;
+			memcpy(tmpv, sgbuffer, amount);
+			tmpv += amount;
+			dmabuf = (unsigned *)tmpv;
 		}
 
-		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
+		kunmap_atomic(((void*)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);
 
 		if (size == 0)
 			break;

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
