From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Jan 2017 13:22:56 +0100
Subject: [PATCH 2/6] usb: mtu3: add reference clock
In-Reply-To: <1484719707-12107-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
 <1484719707-12107-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <7fc9de99-4bef-ddf2-c5fe-985f8d2348d2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/01/17 07:08, Chunfeng Yun wrote:
> usually, the reference clock comes from 26M oscillator directly,
> but some SoCs are not, add it for compatibility.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3.h      |    1 +
>  drivers/usb/mtu3/mtu3_plat.c |   21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
> index ba9df71..aa6fd6a 100644
> --- a/drivers/usb/mtu3/mtu3.h
> +++ b/drivers/usb/mtu3/mtu3.h
> @@ -225,6 +225,7 @@ struct ssusb_mtk {
>  	/* common power & clock */
>  	struct regulator *vusb33;
>  	struct clk *sys_clk;
> +	struct clk *ref_clk;
>  	/* otg */
>  	struct otg_switch_mtk otg_switch;
>  	enum usb_dr_mode dr_mode;
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 6344859..19a345d 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -123,7 +123,13 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
>  	ret = clk_prepare_enable(ssusb->sys_clk);
>  	if (ret) {
>  		dev_err(ssusb->dev, "failed to enable sys_clk\n");
> -		goto clk_err;
> +		goto sys_clk_err;
> +	}
> +
> +	ret = clk_prepare_enable(ssusb->ref_clk);
> +	if (ret) {
> +		dev_err(ssusb->dev, "failed to enable ref_clk\n");
> +		goto ref_clk_err;
>  	}
>
>  	ret = ssusb_phy_init(ssusb);
> @@ -143,8 +149,10 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
>  phy_err:
>  	ssusb_phy_exit(ssusb);
>  phy_init_err:
> +	clk_disable_unprepare(ssusb->ref_clk);
> +ref_clk_err:
>  	clk_disable_unprepare(ssusb->sys_clk);
> -clk_err:
> +sys_clk_err:
>  	regulator_disable(ssusb->vusb33);
>  vusb33_err:
>
> @@ -154,6 +162,7 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
>  static void ssusb_rscs_exit(struct ssusb_mtk *ssusb)
>  {
>  	clk_disable_unprepare(ssusb->sys_clk);
> +	clk_disable_unprepare(ssusb->ref_clk);
>  	regulator_disable(ssusb->vusb33);
>  	ssusb_phy_power_off(ssusb);
>  	ssusb_phy_exit(ssusb);
> @@ -216,6 +225,12 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
>  		return PTR_ERR(ssusb->sys_clk);
>  	}
>
> +	ssusb->ref_clk = devm_clk_get(dev, "ref_ck");
> +	if (IS_ERR(ssusb->ref_clk)) {
> +		dev_err(dev, "failed to get ref clock\n");
> +		return PTR_ERR(ssusb->ref_clk);
> +	}
> +

That would break older dts bindings, right?
ref_ck must be optional for the code.

Regards,
Matthias
