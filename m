From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 15 Aug 2014 13:40:11 +0100
Subject: [PATCH 4/9] phy: phy-ti-pipe3: Remove unncessary site specific OOM
 messages
In-Reply-To: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1408106416-19044-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The site specific OOM messages are unncessary, because they duplicate
messages from the memory subsystem which include dump_stack().

Removing these superflous messages makes the kernel smaller. A discussion
here http://patchwork.ozlabs.org/patch/324158/ found that all error paths
from kzalloc will print a error message, and that any error path which maybe
found which doesn't would be considered a bug in kzalloc.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/phy-ti-pipe3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index b964aa9..9280ef8 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -299,10 +299,9 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	struct clk *clk;
 
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
-	if (!phy) {
-		dev_err(&pdev->dev, "unable to alloc mem for TI PIPE3 PHY\n");
+	if (!phy)
 		return -ENOMEM;
-	}
+
 	phy->dev		= &pdev->dev;
 
 	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie")) {
-- 
1.9.1
