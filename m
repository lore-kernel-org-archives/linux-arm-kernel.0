From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 14:55:01 +0200
Subject: [PATCH] firmware: bcm47xx_nvram: fix typo / build error
Message-ID: <8565906.sPkd1C9Bg3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change to the new __ioread32_copy() helper used the
DIV_ROUND_UP macro incorrectly:

drivers/firmware/broadcom/bcm47xx_nvram.c: In function 'nvram_find_and_copy':
drivers/firmware/broadcom/bcm47xx_nvram.c:110:30: error: macro "DIV_ROUND_UP" requires 2 arguments, but only 1 given

The same commit also changed the behavior of the code in big-endian
builds to no longer perform byte swaps, which looks intentional
but was not part of the patch description.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 31e2fab1c36b ("FIRMWARE: bcm47xx_nvram: Use __ioread32_copy() instead of open-coding")

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 8f46e6e394b1..0c2f0a61b0ea 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -107,7 +107,7 @@ found:
 	}
 	/* proceed reading data after header */
 	__ioread32_copy(nvram_buf + sizeof(*header), header + 1,
-			DIV_ROUND_UP(nvram_len / 4));
+			DIV_ROUND_UP(nvram_len, 4));
 	nvram_buf[NVRAM_SPACE - 1] = '\0';
 
 	return 0;
