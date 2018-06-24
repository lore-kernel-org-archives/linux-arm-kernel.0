From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 24 Jun 2018 20:00:01 +0200
Subject: [PATCH 2/2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
In-Reply-To: <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
 <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
Message-ID: <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chunfeng,

thank you for the patch!

On Fri, Jun 22, 2018 at 8:33 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> 1. use IS_ERR() but not IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
>     never return NULL value;
ACK - good catch!

> 2. devm_of_phy_get_by_index() should not fail for a valid index
I have learned that the PHY framework can return -ENODEV if the PHY is:
1. supposed to be handled by the legacy USB PHY framework
2. the PHY node is disabled in devicetree

see [0] for the code in the PHY framework and [1] for the discussion
with Johan (who informed me of case #1, I added him on this mail)

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/core/phy.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 9879767..0f972e1 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>                                    struct list_head *list)
>  {
>         struct usb_phy_roothub *roothub_entry;
> -       struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +       struct phy *phy;
>
> -       if (IS_ERR_OR_NULL(phy)) {
> -               if (!phy || PTR_ERR(phy) == -ENODEV)
> -                       return 0;
> -               else
> -                       return PTR_ERR(phy);
> -       }
> +       phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +       if (IS_ERR(phy))
> +               return PTR_ERR(phy);
@Johan can you please review this as well? maybe we need to keep the
-ENODEV check


Regards
Martin


[0] https://elixir.bootlin.com/linux/v4.18-rc2/source/drivers/phy/phy-core.c#L421
[1] https://lkml.org/lkml/2018/4/19/88
