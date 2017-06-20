From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 17:18:53 -0700
Subject: [GIT PULL] Improve cp110 clk support on Marvell Armada 7K/8K
In-Reply-To: <pull.28a1be390fb082d60e88c3234dd7d76fb61438b6.1497886602.git-series.gregory.clement@free-electrons.com>
References: <pull.28a1be390fb082d60e88c3234dd7d76fb61438b6.1497886602.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170620001853.GT20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19, Gregory CLEMENT wrote:
> 
> Hi Mike, Stephen,
> 
> This time I turned the series in a pull request so I removed the
> device tree binding part which will be in an other series for Rob
> Herring and I also removed the dt part that I will take care of once
> you will have pulled this one.
> 
> I hope this will be easier for you to apply this way.
> 

Ok. It wasn't clear what was going on and I forgot to ask in the
lastest patch series. Pulled into clk-next, but I had to apply
this patch on top:

---8<----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clk: mvebu: cp110: Minor cleanups

Mark an array of strings static const and remove the dereference
of a function pointer when assigning to the platform driver probe
struct member.

drivers/clk/mvebu/cp110-system-controller.c:89:12:
warning: symbol 'gate_base_names' was not declared. Should it be static?
drivers/clk/mvebu/cp110-system-controller.c:447:18:
error: cannot dereference this type

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/mvebu/cp110-system-controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index b034b79345ec..ca9a0a536174 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -86,7 +86,7 @@ enum {
 #define CP110_GATE_EIP150		25
 #define CP110_GATE_EIP197		26
 
-const char *gate_base_names[] = {
+static const char * const gate_base_names[] = {
 	[CP110_GATE_AUDIO]	= "audio",
 	[CP110_GATE_COMM_UNIT]	= "communit",
 	[CP110_GATE_NAND]	= "nand",
@@ -437,14 +437,13 @@ static int cp110_clk_probe(struct platform_device *pdev)
 	return cp110_syscon_common_probe(pdev, pdev->dev.of_node->parent);
 }
 
-
 static const struct of_device_id cp110_syscon_legacy_of_match[] = {
 	{ .compatible = "marvell,cp110-system-controller0", },
 	{ }
 };
 
 static struct platform_driver cp110_syscon_legacy_driver = {
-	.probe = *cp110_syscon_legacy_clk_probe,
+	.probe = cp110_syscon_legacy_clk_probe,
 	.driver		= {
 		.name	= "marvell-cp110-system-controller0",
 		.of_match_table = cp110_syscon_legacy_of_match,
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
