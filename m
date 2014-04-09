From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 17:33:34 +0200
Subject: [PATCH 12/15] pinctrl: sunxi: retrieve and enable PL clk gate
 for A31 SoC
In-Reply-To: <1397051478-4113-13-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140409153334.GI28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 03:51:15PM +0200, Boris BREZILLON wrote:
> Retrieve and enable the clock gate related to PL pins.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/pinctrl/pinctrl-sunxi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
> index 64dffc8..da76ceb 100644
> --- a/drivers/pinctrl/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/pinctrl-sunxi.c
> @@ -898,6 +898,13 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  
>  		pctl->get_membase = sun6i_a31_pinctrl_get_membase;
> +		clk = devm_clk_get(&pdev->dev, "pioL_clk");
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			return ret;

Since the pioL_clk isn't declared in the DT yet, the pinctrl driver
won't ever probe here.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/71bdef5e/attachment-0001.sig>
