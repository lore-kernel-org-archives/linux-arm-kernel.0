From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 07 Mar 2011 13:55:15 +0800
Subject: [PATCH 1/2] [ARM] am200epd: fix resource leak in
	am200_init_gpio_regs error path
Message-ID: <1299477315.10486.1.camel@mola>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If gpio_request fails when i > 0, gpios[0] is not freed in current
implementation.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-pxa/am200epd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 3499fad..811d797 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -128,8 +128,8 @@ static int am200_init_gpio_regs(struct metronomefb_par *par)
 	return 0;
 
 err_req_gpio:
-	while (i > 0)
-		gpio_free(gpios[i--]);
+	while (--i >= 0)
+		gpio_free(gpios[i]);
 
 	return err;
 }
-- 
1.7.2
