From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Oct 2013 17:59:33 -0500
Subject: [PATCH v3 12/13] usb: phy: msm: Properly check core interrupt
 number
In-Reply-To: <1381764280-28420-13-git-send-email-iivanov@mm-sol.com>
References: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
 <1381764280-28420-13-git-send-email-iivanov@mm-sol.com>
Message-ID: <20131014225933.GF7446@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 06:24:39PM +0300, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> IRQ with number 0 is valid case, so check for negative

not entirelly correct... IRQ 0 isn't supposed to be used as a linux IRQ
number IIRC.

> numbers instead.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>  drivers/usb/phy/phy-msm-usb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
> index ca2abe6..f34c8a9 100644
> --- a/drivers/usb/phy/phy-msm-usb.c
> +++ b/drivers/usb/phy/phy-msm-usb.c
> @@ -1415,7 +1415,7 @@ static int __init msm_otg_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "OTG regs = %p\n", motg->regs);
>  
>  	motg->irq = platform_get_irq(pdev, 0);
> -	if (!motg->irq) {
> +	if (motg->irq < 0) {

this check is correct though, since platform_get_irq() will return
-ENXIO if it doesn't find IRQ resource.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131014/cdf9488b/attachment-0001.sig>
