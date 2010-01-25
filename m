From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 01:57:21 +0000
Subject: [PATCH] ARM: SAMSUNG: Add error printing to s3c24xx_register_clocks
In-Reply-To: <1264384641-8211-1-git-send-email-ben-linux@fluff.org>
References: <1264384641-8211-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264384641-8211-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an error print to s3c24xx_register_clocks to provide more useful
information when failing to register the clock.

I belive this was originally left out due to the possibility of a
problem with low-level debugging code. However, if the low-level
debug code is not functional by now there will be a whole other set of
problems being presented to the system.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/clock.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 4b95b39..1b25c9d 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -343,8 +343,12 @@ int s3c24xx_register_clocks(struct clk **clks, int nr_clks)
 	int fails = 0;
 
 	for (; nr_clks > 0; nr_clks--, clks++) {
-		if (s3c24xx_register_clock(*clks) < 0)
+		if (s3c24xx_register_clock(*clks) < 0) {
+			struct clk *clk = *clks;
+			printk(KERN_ERR "%s: failed to register %p: %s\n",
+			       __func__, clk, clk->name);
 			fails++;
+		}
 	}
 
 	return fails;
-- 
1.6.0.4
