From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 14:23:25 +0100
Subject: [PATCHv5][ 5/8] staging: imx-drm: parallel display: add
 regulator support.
In-Reply-To: <1386268092-21719-5-git-send-email-denis@eukrea.com>
References: <1386268092-21719-1-git-send-email-denis@eukrea.com>
 <1386268092-21719-5-git-send-email-denis@eukrea.com>
Message-ID: <20131206132324.GB30960@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 07:28:09PM +0100, Denis Carikli wrote:
[...]
> diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
[...]
> @@ -260,6 +275,13 @@ static int imx_pd_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	imxpd->disp_reg = devm_regulator_get(&pdev->dev, "display");
> +	if (PTR_ERR(imxpd->disp_reg) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (IS_ERR(imxpd->disp_reg))
> +		dev_dbg(&pdev->dev, "Operating without display regulator.\n");

I don't think this is necessary. There is code in the regulator core
nowadays that supplies a dummy regulator if one hasn't been hooked up in
devicetree explicitly. So any error that you get at this point is likely
a valid one rather than just a missing regulator.

The advantage is that you no longer have to check at every step of the
way that the regulator is valid before calling the regulator API.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/b167f37c/attachment.sig>
