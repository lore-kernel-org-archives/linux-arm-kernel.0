From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:05:47 +0200
Subject: [PATCH 1/3] pcmcia: journada720: use sa1100 pin interfaces correctly
In-Reply-To: <1402002349-1984057-1-git-send-email-arnd@arndb.de>
References: <1402002349-1984057-1-git-send-email-arnd@arndb.de>
Message-ID: <1402002349-1984057-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit dabd14684bc2 "PCMCIA: sa1111: remove duplicated initializers"
incorrectly moved some code into the pcmcia_jornada720_init, causing
a few build errors, and for unknown reasons, the driver lacks
an inclusion of <linux/io.h>, so we get the build errors, and more:

sa1111_jornada720.c: In function 'pcmcia_jornada720_init':
sa1111_jornada720.c:101:3: error: implicit declaration of function 'IOMEM' [-Werror=implicit-function-declaration]
   GRER |= 0x00000002;
   ^
sa1111_jornada720.c:104:3: warning: passing argument 1 of 'sa1111_set_io_dir' from incompatible pointer type [enabled by default]
   sa1111_set_io_dir(dev, pin, 0, 0);
   ^

This patch uses the SA1111_DEV() to convert the dev pointer to the
correct type before passing it and adds the missing include.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-pcmcia at lists.infradead.org
---
 drivers/pcmcia/sa1111_jornada720.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/sa1111_jornada720.c b/drivers/pcmcia/sa1111_jornada720.c
index 3baa3ef..40e0403 100644
--- a/drivers/pcmcia/sa1111_jornada720.c
+++ b/drivers/pcmcia/sa1111_jornada720.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <asm/hardware/sa1111.h>
@@ -94,6 +95,7 @@ static struct pcmcia_low_level jornada720_pcmcia_ops = {
 int pcmcia_jornada720_init(struct device *dev)
 {
 	int ret = -ENODEV;
+	struct sa1111_dev *sadev = SA1111_DEV(dev);
 
 	if (machine_is_jornada720()) {
 		unsigned int pin = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
@@ -101,12 +103,12 @@ int pcmcia_jornada720_init(struct device *dev)
 		GRER |= 0x00000002;
 
 		/* Set GPIO_A<3:1> to be outputs for PCMCIA/CF power controller: */
-		sa1111_set_io_dir(dev, pin, 0, 0);
-		sa1111_set_io(dev, pin, 0);
-		sa1111_set_sleep_io(dev, pin, 0);
+		sa1111_set_io_dir(sadev, pin, 0, 0);
+		sa1111_set_io(sadev, pin, 0);
+		sa1111_set_sleep_io(sadev, pin, 0);
 
 		sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
-		ret = sa1111_pcmcia_add(dev, &jornada720_pcmcia_ops,
+		ret = sa1111_pcmcia_add(sadev, &jornada720_pcmcia_ops,
 				sa11xx_drv_pcmcia_add_one);
 	}
 
-- 
1.8.3.2
