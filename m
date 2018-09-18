From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Sep 2018 16:16:56 -0700
Subject: [PATCH] mmc: core: Fix debounce time to use microseconds
Message-ID: <20180918231656.21778-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debounce value in device tree is in milliseconds but needs to be in
microseconds for mmc_gpiod_request_cd().

Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card
after card is inserted")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -235,7 +235,7 @@ int mmc_of_parse(struct mmc_host *host)
 			host->caps |= MMC_CAP_NEEDS_POLL;
 
 		ret = mmc_gpiod_request_cd(host, "cd", 0, true,
-					   cd_debounce_delay_ms,
+					   cd_debounce_delay_ms * 1000,
 					   &cd_gpio_invert);
 		if (!ret)
 			dev_info(host->parent, "Got CD GPIO\n");
-- 
2.19.0
