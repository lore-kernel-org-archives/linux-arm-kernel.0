From: johan@kernel.org (Johan Hovold)
Date: Wed, 29 Aug 2018 10:30:50 +0200
Subject: [PATCH v2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
In-Reply-To: <8263a8d0f87d595dd35efa5432d294d9f7b38719.1535507412.git.chunfeng.yun@mediatek.com>
References: <8263a8d0f87d595dd35efa5432d294d9f7b38719.1535507412.git.chunfeng.yun@mediatek.com>
Message-ID: <20180829083050.GG28861@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 10:10:48AM +0800, Chunfeng Yun wrote:
> Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> never return NULL value;
> But still need ignore the error of -ENODEV, for more information, please
> refer to:
> [0] https://lkml.org/lkml/2018/4/19/88
> [1] https://patchwork.kernel.org/patch/10160181/
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> V2: keep the -ENODEV check
> ---
>  drivers/usb/core/phy.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 9879767..e3cc743 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>  				   struct list_head *list)
>  {
>  	struct usb_phy_roothub *roothub_entry;
> -	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	struct phy *phy;
>  
> -	if (IS_ERR_OR_NULL(phy)) {
> -		if (!phy || PTR_ERR(phy) == -ENODEV)
> -			return 0;
> -		else
> -			return PTR_ERR(phy);
> -	}
> +	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	if (IS_ERR(phy))
> +		return (PTR_ERR(phy) == -ENODEV) ? 0 : PTR_ERR(phy);

I prefer not to use the terse ternary operator in general, and
especially so in this case where we are doing something unexpected (i.e.
we want to highlight that the -ENODEV case is special).

So please keep the current construct, and just replace IS_ERR_OR_NULL
and drop the !phy test.

I think separating the declaration and (non-trivial) initialisation of
phy here is a good thing that can remain in the patch, even if it's
arguable separate change.

>  
>  	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
>  	if (!roothub_entry)

Thanks,
Johan
