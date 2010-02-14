From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 14 Feb 2010 23:53:25 +0200
Subject: [PATCH] iop: n2100: enable serial interrupt
Message-ID: <1266184405-21444-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thecus N2100 has a jumper (J3/J4) to select whether the XINT1 interrupt
line is connected to the second UHCI controller (position J3) or to
the serial port UART (position J4). Currently, the kernel is hardcoded
to assume the J3 position, and the serial port is always being used in
polling mode.

The patch adds the IRQ autodetection flag for the serial port interrupt,
and also marks it as shared (as the driver for the second UHCI controller
will request the interrupt in any case). Now, when the jumper is set to
the J4 position, the serial port will have an interrupt line, resulting
in less CPU overhead and faster throughput.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-iop32x/n2100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index d2e4278..001db59 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -178,7 +178,7 @@ static struct plat_serial8250_port n2100_serial_port[] = {
 		.mapbase	= N2100_UART,
 		.membase	= (char *)N2100_UART,
 		.irq		= 0,
-		.flags		= UPF_SKIP_TEST,
+		.flags		= UPF_SKIP_TEST | UPF_AUTO_IRQ | UPF_SHARE_IRQ,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
 		.uartclk	= 1843200,
-- 
1.5.6.5
