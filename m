From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 20 Mar 2012 22:15:28 -0400
Subject: [PATCH] avr32: fix build failures from mis-naming of atmel_nand.h
Message-ID: <1332296128-16262-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bf4289cba02b8cf770ecd7959ca70839f0dd9d3c (linux-next)

    "ATMEL: fix nand ecc support"

indicated that it wanted to "Move platform data to a common
header include/linux/platform_data/atmel_nand.h" and the new
header even had re-include protectors with:

    #ifndef __ATMEL_NAND_H__

However, the file that was added was simply called atmel.h
and this caused avr32 defconfig to fail with:

  In file included from arch/avr32/boards/atstk1000/setup.c:22:
  arch/avr32/mach-at32ap/include/mach/board.h:10:44: error: linux/platform_data/atmel_nand.h: No such file or directory
  In file included from arch/avr32/boards/atstk1000/setup.c:22:
  arch/avr32/mach-at32ap/include/mach/board.h:121: warning: 'struct atmel_nand_data' declared inside parameter list
  arch/avr32/mach-at32ap/include/mach/board.h:121: warning: its scope is only this definition or declaration, which is probably not what you want
  make[2]: *** [arch/avr32/boards/atstk1000/setup.o] Error 1

Rename the file to match the original intention, and fix up the
users who reference the bad name without the _nand suffix.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: Hans-Christian Egtvedt <egtvedt@samfundet.no>
CC: David Woodhouse <dwmw2@infradead.org>
---
 arch/arm/mach-at91/include/mach/board.h            |    2 +-
 drivers/mtd/nand/atmel_nand.c                      |    2 +-
 .../linux/platform_data/{atmel.h => atmel_nand.h}  |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/platform_data/{atmel.h => atmel_nand.h} (100%)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 544a5d5..aa0e083 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -41,7 +41,7 @@
 #include <sound/atmel-ac97c.h>
 #include <linux/serial.h>
 #include <linux/platform_data/macb.h>
-#include <linux/platform_data/atmel.h>
+#include <linux/platform_data/atmel_nand.h>
 
  /* USB Device */
 struct at91_udc_data {
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 2165576..7b599a9 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -38,7 +38,7 @@
 #include <linux/dmaengine.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
-#include <linux/platform_data/atmel.h>
+#include <linux/platform_data/atmel_nand.h>
 
 #include <mach/cpu.h>
 
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel_nand.h
similarity index 100%
rename from include/linux/platform_data/atmel.h
rename to include/linux/platform_data/atmel_nand.h
-- 
1.7.9.1
