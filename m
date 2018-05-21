From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 21 May 2018 19:57:49 +0800
Subject: [PATCH 12/33] clk: bcm2835: use match_string() helper
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-clk at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index fa0d5c8..a27c0d2 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1395,8 +1395,7 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	struct bcm2835_clock *clock;
 	struct clk_init_data init;
 	const char *parents[1 << CM_SRC_BITS];
-	size_t i, j;
-	int ret;
+	int i, ret;
 
 	/*
 	 * Replace our strings referencing parent clocks with the
@@ -1405,12 +1404,11 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	for (i = 0; i < data->num_mux_parents; i++) {
 		parents[i] = data->parents[i];
 
-		for (j = 0; j < ARRAY_SIZE(cprman_parent_names); j++) {
-			if (strcmp(parents[i], cprman_parent_names[j]) == 0) {
-				parents[i] = cprman->real_parent_names[j];
-				break;
-			}
-		}
+		ret = match_string(cprman_parent_names,
+				   ARRAY_SIZE(cprman_parent_names),
+				   parents[i]);
+		if (ret >= 0)
+			parents[i] = cprman->real_parent_names[ret];
 	}
 
 	memset(&init, 0, sizeof(init));
-- 
1.7.12.4
