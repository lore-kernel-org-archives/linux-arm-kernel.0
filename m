From: rogerq@ti.com (Roger Quadros)
Date: Thu, 22 Mar 2018 14:29:39 +0200
Subject: [usb-next, v3 PATCH] usb: xhci: skip phys initialization of
 shared hcd
In-Reply-To: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
Message-ID: <e3560874-cf8b-a554-5226-bc640b0edcb1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/18 14:12, Chunfeng Yun wrote:
> The phys has already been initialized when add primary hcd,
> including usb2 phys and usb3 phys also if exist, so needn't
> re-parse "phys" property again.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

> ---
> V3:
>     add the following info about v1 & v2 suggested by Greg
> V2:
>     fix it in hcd.c suggested by Roger
> V1:
>     skip phys initialization when add shared HCD by setting
>     xhci->shared_hcd->skip_phy_initialization=1;
>     for both xhci-plat.c & xhci-mtk.c files.
> ---
>  drivers/usb/core/hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 5a92d8f..777036a 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2757,7 +2757,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  		}
>  	}
>  
> -	if (!hcd->skip_phy_initialization) {
> +	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
>  		hcd->phy_roothub = usb_phy_roothub_init(hcd->self.sysdev);
>  		if (IS_ERR(hcd->phy_roothub)) {
>  			retval = PTR_ERR(hcd->phy_roothub);
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
