From: PeterHuewe@gmx.de (Peter =?iso-8859-1?q?H=FCwe?=)
Date: Tue, 29 Jun 2010 19:35:39 +0200
Subject: [PATCH] serial: fix rs485 for atmel_serial on avr32
Message-ID: <201006291935.40229.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>

This patch fixes a build failure [1-4] in the atmel_serial code introduced by
patch the patch ARM: 6092/1: atmel_serial: support for RS485
communications (e8faff7330a3501eafc9bfe5f4f15af444be29f5)

The build failure was caused by missing struct field and missing defines
for the avr32 board - the patch fixes this.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
Despite so many reviewers of the original patch no one seemed to 
notice this issue :/

KernelVersion: linux-next-20100629

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2575242/ - first failure
in linux-next, may 11th
[2] http://kisskb.ellerman.id.au/kisskb/buildresult/2816418/ - still
exists as of today
[3] http://kisskb.ellerman.id.au/kisskb/buildresult/2617511/ - first
failure in Linus' tree - May 20th - did really no one notice this?!
[4] http://kisskb.ellerman.id.au/kisskb/buildresult/2813956/ - still
exists in Linus' tree as of today

 arch/avr32/include/asm/ioctls.h             |    3 +++
 arch/avr32/mach-at32ap/include/mach/board.h |    2 ++
 drivers/serial/atmel_serial.c               |    1 +
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/include/asm/ioctls.h b/arch/avr32/include/asm/ioctls.h
index bb32b6f..b7dd324 100644
--- a/arch/avr32/include/asm/ioctls.h
+++ b/arch/avr32/include/asm/ioctls.h
@@ -55,6 +55,9 @@
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
 
+#define TIOCGRS485      0x542E
+#define TIOCSRS485      0x542F
+
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
 #define FIOASYNC	0x5452
diff --git a/arch/avr32/mach-at32ap/include/mach/board.h b/arch/avr32/mach-at32ap/include/mach/board.h
index c7f25bb..6174020 100644
--- a/arch/avr32/mach-at32ap/include/mach/board.h
+++ b/arch/avr32/mach-at32ap/include/mach/board.h
@@ -5,6 +5,7 @@
 #define __ASM_ARCH_BOARD_H
 
 #include <linux/types.h>
+#include <linux/serial.h>
 
 #define GPIO_PIN_NONE	(-1)
 
@@ -35,6 +36,7 @@ struct atmel_uart_data {
 	short		use_dma_tx;	/* use transmit DMA? */
 	short		use_dma_rx;	/* use receive DMA? */
 	void __iomem	*regs;		/* virtual base address, if any */
+	struct serial_rs485	rs485;		/* rs485 settings */
 };
 void at32_map_usart(unsigned int hw_id, unsigned int line, int flags);
 struct platform_device *at32_add_device_usart(unsigned int id);
diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index eed3c2d..a182def 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -41,6 +41,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/io.h>
+#include <asm/ioctls.h>
 
 #include <asm/mach/serial_at91.h>
 #include <mach/board.h>
-- 
1.7.1
