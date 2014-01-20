From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 20 Jan 2014 12:32:57 +0100
Subject: commit 40d4511 "can: Disable flexcan driver build for big endian
 CPU on ARM" breaks Flexcan on ARM
Message-ID: <20140120123257.573205a9@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The commit 40d451181a7fa57e32bca4632ae7b22f80861a73
|Author: Guenter Roeck <linux@roeck-us.net>
|Date:   Mon Jan 6 05:21:03 2014 -0800
|
|    can: Disable flexcan driver build for big endian CPU on ARM
|    
|    Building arm:allmodconfig fails with
|    
|    flexcan.c: In function 'flexcan_read':
|    flexcan.c:243:2: error: implicit declaration of function 'in_be32'
|    flexcan.c: In function 'flexcan_write':
|    flexcan.c:248:2: error: implicit declaration of function 'out_be32'
|    
|    in_be32 and out_be32 do not (or no longer) exist for ARM targets.
|    Disable the build for ARM on big endian CPUs.
|    
|    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
|    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|
|diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
|index 9e7d95d..d447b88 100644
|--- a/drivers/net/can/Kconfig
|+++ b/drivers/net/can/Kconfig
|@@ -104,7 +104,7 @@ config CAN_JANZ_ICAN3
| 
| config CAN_FLEXCAN
|        tristate "Support for Freescale FLEXCAN based chips"
|-       depends on ARM || PPC
|+       depends on (ARM && CPU_LITTLE_ENDIAN) || PPC
|        ---help---
|          Say Y here if you want to support for Freescale FlexCAN.
>
completely disables the flexcan driver for all ARM platforms, since the
symbol CPU_LITTLE_ENDIAN does not exist on ARM!


Lothar Wa?mann
