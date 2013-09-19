From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Sep 2013 12:06:42 +0100
Subject: [PATCH] ASoC: kirkwood: fix loss of external clock at probe time
In-Reply-To: <20130919114957.1fede091@armhf>
References: <20130919114957.1fede091@armhf>
Message-ID: <20130919110642.GK21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 11:49:57AM +0200, Jean-Francois Moine wrote:

>  	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> -	if (!IS_ERR(priv->extclk)) {
> +	if (IS_ERR(priv->extclk)) {
> +		if (np && of_property_match_string(np, "clock-names", "extclk") >= 0)
> +			return -EPROBE_DEFER;
> +	} else {

This one really does seem like something the clock API ought to be
doing, either as standard or with a separate helper - essentially every
driver ought to be doing this for robustness.  Doing it on general
failures is more tricky but in the specific case where we know the clock
should be present but we don't have the driver loaded yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130919/91152073/attachment.sig>
