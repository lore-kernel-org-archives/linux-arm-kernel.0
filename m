From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 7 Mar 2011 11:48:33 +0100
Subject: [PATCH V5 4/6] mmc: sdhci-esdhc: make the writel/readl as the
	general APIs
In-Reply-To: <1299060283-6404-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1299060283-6404-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110307104833.GC3425@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data =
> +				(struct pltfm_imx_data *)pltfm_host->scratchpad;
> +

Uh, no. Sorry that was a misunderstanding of this:

===
Do you means keep the u32 scratchpad, and use one u32---> pointer exchange, right?
-       u32 scratchpad; /* to handle quirks across io-accessor calls */
+       void *priv; /* to handle quirks across io-accessor calls */
===

When you said "exchanging" 'scratchpad' with a 'void *', I thought you really
meant replacing it in the struct like the diff sketches. Casting a variable to
a struct * is not a good idea. The private structure itself looks okay.

> +	struct pltfm_imx_data *imx_data;
> +
> +	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
> +	pltfm_host->scratchpad = (u32)imx_data;
>  
>  	clk = clk_get(mmc_dev(host->mmc), NULL);
>  	if (IS_ERR(clk)) {

Do that after clk_get, otherwise you leak memory if it clk_get fails.

Regards

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110307/05e1935e/attachment-0001.sig>
