From: johan@kernel.org (Johan Hovold)
Date: Fri, 31 Aug 2018 11:41:54 +0200
Subject: [PATCH v3] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
In-Reply-To: <626cea85395e3a1f002ef0a241bb508d770a33c0.1535536218.git.chunfeng.yun@mediatek.com>
References: <626cea85395e3a1f002ef0a241bb508d770a33c0.1535536218.git.chunfeng.yun@mediatek.com>
Message-ID: <20180831094154.GL28861@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 09:16:40AM +0800, Chunfeng Yun wrote:
> Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> never return NULL value;
> But still need ignore the error of -ENODEV, for more information, please
> refer to:
> [0] https://lkml.org/lkml/2018/4/19/88
> [1] https://patchwork.kernel.org/patch/10160181/
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> V3: abandon the ternary operator suggested by Johan
> 
> V2: keep the -ENODEV check

Perhaps the patch Subject is a little misleading as this is more of a
clean up than a fix (as there's no bug here).

But apart from that this looks good to me.

Reviewed-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/usb/core/phy.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 9879767..38b2c77 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -23,10 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>  				   struct list_head *list)
>  {
>  	struct usb_phy_roothub *roothub_entry;
> -	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	struct phy *phy;
>  
> -	if (IS_ERR_OR_NULL(phy)) {
> -		if (!phy || PTR_ERR(phy) == -ENODEV)
> +	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	if (IS_ERR(phy)) {
> +		if (PTR_ERR(phy) == -ENODEV)
>  			return 0;
>  		else
>  			return PTR_ERR(phy);

Thanks,
Johan
