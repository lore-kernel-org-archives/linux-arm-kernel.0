From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 20 Jan 2014 12:37:02 +0100
Subject: commit 40d4511 "can: Disable flexcan driver build for big endian
 CPU on ARM" breaks Flexcan on ARM
In-Reply-To: <20140120123257.573205a9@ipc1.ka-ro>
References: <20140120123257.573205a9@ipc1.ka-ro>
Message-ID: <52DD0A5E.6010303@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2014 12:32 PM, Lothar Wa?mann wrote:
> Hi,
> 
> The commit 40d451181a7fa57e32bca4632ae7b22f80861a73
> |Author: Guenter Roeck <linux@roeck-us.net>
> |Date:   Mon Jan 6 05:21:03 2014 -0800
> |
> |    can: Disable flexcan driver build for big endian CPU on ARM
> |    
> |    Building arm:allmodconfig fails with
> |    
> |    flexcan.c: In function 'flexcan_read':
> |    flexcan.c:243:2: error: implicit declaration of function 'in_be32'
> |    flexcan.c: In function 'flexcan_write':
> |    flexcan.c:248:2: error: implicit declaration of function 'out_be32'
> |    
> |    in_be32 and out_be32 do not (or no longer) exist for ARM targets.
> |    Disable the build for ARM on big endian CPUs.
> |    
> |    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> |    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |
> |diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> |index 9e7d95d..d447b88 100644
> |--- a/drivers/net/can/Kconfig
> |+++ b/drivers/net/can/Kconfig
> |@@ -104,7 +104,7 @@ config CAN_JANZ_ICAN3
> | 
> | config CAN_FLEXCAN
> |        tristate "Support for Freescale FLEXCAN based chips"
> |-       depends on ARM || PPC
> |+       depends on (ARM && CPU_LITTLE_ENDIAN) || PPC
> |        ---help---
> |          Say Y here if you want to support for Freescale FlexCAN.
>>
> completely disables the flexcan driver for all ARM platforms, since the
> symbol CPU_LITTLE_ENDIAN does not exist on ARM!

Arnd Bergmann posted a better patch, which I'll include in a pull
request once the net tree is open again.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/b60177fc/attachment-0001.sig>
