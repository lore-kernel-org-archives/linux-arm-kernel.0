From: xiechao.mail@gmail.com (Chao Xie)
Date: Sun, 25 Nov 2012 23:43:19 -0500
Subject: [PATCH 06/27] usb: host: ehci-mv: fix clk APIs
In-Reply-To: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
References: <1353905020-29372-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1353905020-29372-7-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

the clock common driver changes, and arch-mmp will make use of
the common clock driver instead of its own.
So for enable clock.
first prepare the clock
then enable the clock.

for disable clock
first disable the clock
then unprepare the clock

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 drivers/usb/host/ehci-mv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index f7bfc0b..6c56297 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -43,7 +43,7 @@ static void ehci_clock_enable(struct ehci_hcd_mv *ehci_mv)
 	unsigned int i;
 
 	for (i = 0; i < ehci_mv->clknum; i++)
-		clk_enable(ehci_mv->clk[i]);
+		clk_prepare_enable(ehci_mv->clk[i]);
 }
 
 static void ehci_clock_disable(struct ehci_hcd_mv *ehci_mv)
@@ -51,7 +51,7 @@ static void ehci_clock_disable(struct ehci_hcd_mv *ehci_mv)
 	unsigned int i;
 
 	for (i = 0; i < ehci_mv->clknum; i++)
-		clk_disable(ehci_mv->clk[i]);
+		clk_disable_unprepare(ehci_mv->clk[i]);
 }
 
 static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
-- 
1.7.4.1
