From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 6 Dec 2011 20:12:03 +0100
Subject: [MXS MMC 4/5] Check the return codes of clk_enable() and
 mxs_reset_block()
In-Reply-To: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
Message-ID: <20111206191203.GE7835@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 02:41:29PM +0100, Lothar Wa?mann wrote:
> Add an int return value to mxs_mmc_reset(), so that the return code of
> mxs_reset_block() can be promoted to the caller.
> Also check the return code of clk_enable() in the probe function.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> -	clk_enable(host->clk);
> +	ret = clk_enable(host->clk);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc),
> +			"%s: failed to enable clock: %d\n", __func__, ret);
> +		goto out_clk_put;
> +	}
>  
> -	mxs_mmc_reset(host);
> +	ret = mxs_mmc_reset(host);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc),
> +			"%s: failed to reset controller: %d\n", __func__, ret);
> +		goto out_clk_put;
> +	}

Why __func__ here? dev_err and the msg itself should be indication enough?

Otherwise

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111206/f88dc302/attachment.sig>
