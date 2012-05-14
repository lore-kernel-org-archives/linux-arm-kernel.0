From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 May 2012 18:54:50 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc tree
Message-ID: <20120514185450.4682573d6cb7c4745c9ea8b5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
sound/soc/mxs/mxs-saif.c between commit 08641c7c74dd ("ASoC: mxs: add
device tree support for mxs-saif") from the sound-asoc tree and commit
f755865f9082 ("ASoC: mxs-saif: adopt pinctrl support") from the arm-soc
tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc sound/soc/mxs/mxs-saif.c
index 0642748,7fd224b..0000000
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@@ -628,50 -626,38 +629,57 @@@ static int __devinit mxs_saif_probe(str
  	struct resource *iores, *dmares;
  	struct mxs_saif *saif;
  	struct mxs_saif_platform_data *pdata;
+ 	struct pinctrl *pinctrl;
  	int ret = 0;
  
 -	if (pdev->id >= ARRAY_SIZE(mxs_saif))
 +
 +	if (!np && pdev->id >= ARRAY_SIZE(mxs_saif))
  		return -EINVAL;
  
  	saif = devm_kzalloc(&pdev->dev, sizeof(*saif), GFP_KERNEL);
  	if (!saif)
  		return -ENOMEM;
  
 -	mxs_saif[pdev->id] = saif;
 -	saif->id = pdev->id;
 -
 -	pdata = pdev->dev.platform_data;
 -	if (pdata && !pdata->master_mode) {
 -		saif->master_id = pdata->master_id;
 -		if (saif->master_id < 0 ||
 -			saif->master_id >= ARRAY_SIZE(mxs_saif) ||
 -			saif->master_id == saif->id) {
 -			dev_err(&pdev->dev, "get wrong master id\n");
 -			return -EINVAL;
 +	if (np) {
 +		struct device_node *master;
 +		saif->id = of_alias_get_id(np, "saif");
 +		if (saif->id < 0)
 +			return saif->id;
 +		/*
 +		 * If there is no "fsl,saif-master" phandle, it's a saif
 +		 * master.  Otherwise, it's a slave and its phandle points
 +		 * to the master.
 +		 */
 +		master = of_parse_phandle(np, "fsl,saif-master", 0);
 +		if (!master) {
 +			saif->master_id = saif->id;
 +		} else {
 +			saif->master_id = of_alias_get_id(master, "saif");
 +			if (saif->master_id < 0)
 +				return saif->master_id;
  		}
  	} else {
 -		saif->master_id = saif->id;
 +		saif->id = pdev->id;
 +		pdata = pdev->dev.platform_data;
 +		if (pdata && !pdata->master_mode)
 +			saif->master_id = pdata->master_id;
 +		else
 +			saif->master_id = saif->id;
 +	}
 +
 +	if (saif->master_id < 0 || saif->master_id >= ARRAY_SIZE(mxs_saif)) {
 +		dev_err(&pdev->dev, "get wrong master id\n");
 +		return -EINVAL;
  	}
  
 +	mxs_saif[saif->id] = saif;
 +
+ 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+ 	if (IS_ERR(pinctrl)) {
+ 		ret = PTR_ERR(pinctrl);
+ 		return ret;
+ 	}
+ 
  	saif->clk = clk_get(&pdev->dev, NULL);
  	if (IS_ERR(saif->clk)) {
  		ret = PTR_ERR(saif->clk);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/863fc2c8/attachment.sig>
