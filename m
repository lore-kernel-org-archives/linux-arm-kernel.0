From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 18:06:36 +0300
Subject: [PATCH 2/2] clk: honor CLK_GET_RATE_NOCACHE in clk_set_rate
In-Reply-To: <1370444796-18648-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370444796-18648-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1370444796-18648-3-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_set_rate() uses clk->rate directly. This causes problems if the clock
is marked as CLK_GET_RATE_NOCACHE. Hence call clk_get_rate() to get the
current rate.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9b2f941..2e669a8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1216,7 +1216,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	clk_prepare_lock();
 
 	/* bail early if nothing to do */
-	if (rate == clk->rate)
+	if (rate == clk_get_rate(clk))
 		goto out;
 
 	if ((clk->flags & CLK_SET_RATE_GATE) && clk->prepare_count) {
-- 
1.7.7.rc0.72.g4b5ea.dirty
