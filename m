From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 31 Jul 2014 15:57:51 +0300
Subject: [patch] ASoC: pxa: pxa-ssp: small leak in probe()
Message-ID: <20140731125751.GA31539@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a small memory leak if probe() fails.

Fixes: 2023c90c3a2c ('ASoC: pxa: pxa-ssp: add DT bindings')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 199a8b3..0109f6c2 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -723,7 +723,8 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		ssp_handle = of_parse_phandle(dev->of_node, "port", 0);
 		if (!ssp_handle) {
 			dev_err(dev, "unable to get 'port' phandle\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_priv;
 		}
 
 		priv->ssp = pxa_ssp_request_of(ssp_handle, "SoC audio");
