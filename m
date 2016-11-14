From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:10 +0530
Subject: [PATCH 15/16] ARM: mvebu: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-16-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Jason Cooper <jason@lakedaemon.net>
CC: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@free-electrons.com>
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-mvebu/board-v7.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index ccca951..d7014a3 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -41,13 +41,9 @@ static void __iomem *scu_base;
  */
 static void __init mvebu_scu_enable(void)
 {
-	struct device_node *np =
-		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
-	if (np) {
-		scu_base = of_iomap(np, 0);
+	scu_base = of_scu_get_base();
+	if (!IS_ERR(scu_base))
 		scu_enable(scu_base);
-		of_node_put(np);
-	}
 }
 
 void __iomem *mvebu_get_scu_base(void)
-- 
2.7.4
