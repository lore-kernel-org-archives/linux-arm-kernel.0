From: andy@warmcat.com (Andy Green)
Date: Mon, 01 Feb 2010 13:28:54 +0100
Subject: [PATCH] imx-serial-excessive-status-clearing-on-break.patch
Message-ID: <20100201122853.21848.90945.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy.green@txtr.com>

cc: Sasha Hauer <kernel@pengutronix.de>

We noticed that we were only able to communicate once with a GSM module
per session, if we powered down the module then the serial driver was
broken until reset, no traffic or /proc/interrupts activity could be
seen any more.

Volker noticed it was provoked by a long "break" seen on the wire when
the RX was not driven during powerdown, we discovered we could kill the
serial driver just by forcing RX low extenally for a little while.

I saw that the processing for BREAK in the driver gets too excited and
clears down all set bits in USR2, including that a character is pending.
This stops all further characters getting processed.

The attached one-liner makes the serial driver immortal against BREAK.

Signed-off-by: Andy Green <andy.green@txtr.com>
Signed-off-by: Volker Ernst <volker.ernst@txtr.com>
---

 drivers/serial/imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index 18130f1..c5b546a 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -440,7 +440,7 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 
 		temp = readl(sport->port.membase + USR2);
 		if (temp & USR2_BRCD) {
-			writel(temp | USR2_BRCD, sport->port.membase + USR2);
+			writel(USR2_BRCD, sport->port.membase + USR2);
 			if (uart_handle_break(&sport->port))
 				continue;
 		}
