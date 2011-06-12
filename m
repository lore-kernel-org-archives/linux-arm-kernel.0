From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Sun, 12 Jun 2011 17:04:59 +0200
Subject: [PATCH v2 4/5] ARM: ep93xx: fix inverted RTS/DTR signals on uart1
In-Reply-To: <1307891100-31123-1-git-send-email-ynezz@true.cz>
References: <1307891100-31123-1-git-send-email-ynezz@true.cz>
Message-ID: <1307891100-31123-5-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was discovered by Roberto Bergo, that RTS/DTR signals are inverted after
the boot, because it was causing him problems with hardware controlled modem
connected on ttyAM0. Todd Valentic came with this patch for the issue.

Discussion: http://tech.groups.yahoo.com/group/ts-7000/message/20259

Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Todd Valentic <todd.valentic@sri.com>
Tested-by: Roberto Bergo <roberto.bergo@robson.it>
Signed-off-by: Petr ?tetiar <ynezz@true.cz>
---
 arch/arm/mach-ep93xx/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8207954..cf1ce32 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -251,9 +251,9 @@ static void ep93xx_uart_set_mctrl(struct amba_device *dev,
 	unsigned int mcr;
 
 	mcr = 0;
-	if (!(mctrl & TIOCM_RTS))
+	if (mctrl & TIOCM_RTS)
 		mcr |= 2;
-	if (!(mctrl & TIOCM_DTR))
+	if (mctrl & TIOCM_DTR)
 		mcr |= 1;
 
 	__raw_writel(mcr, base + EP93XX_UART_MCR_OFFSET);
-- 
1.7.1
