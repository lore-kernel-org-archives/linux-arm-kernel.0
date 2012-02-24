From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Feb 2012 22:09:37 +0800
Subject: [PATCH 2/6] ASoC: fsl: align mpc8610_hpcd with p1022_ds on getting
 codec node
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330092582-21180-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Align mpc8610_hpcd with p1022_ds on getting codec node by just calling
of_parse_phandle.  The bonus point of doing that is we can save
exporting get_node_by_phandle_name() when we consolidate the common
bits between mpc8610_hpcd and p1022_ds into a module, which can be
shared by more machine drivers added later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/mpc8610_hpcd.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 15e06e9d..93256b3 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -336,12 +336,8 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	const char *sprop;
 	const u32 *iprop;
 
-	/* We are only interested in SSIs with a codec phandle in them,
-	 * so let's make sure this SSI has one. The MPC8610 HPCD only
-	 * knows about the CS4270 codec, so reject anything else.
-	 */
-	codec_np = get_node_by_phandle_name(np, "codec-handle",
-					    "cirrus,cs4270");
+	/* Find the codec node for this SSI. */
+	codec_np = of_parse_phandle(np, "codec-handle", 0);
 	if (!codec_np) {
 		dev_err(dev, "invalid codec node\n");
 		return -EINVAL;
-- 
1.7.5.4
