From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Mar 2017 11:07:16 +0800
Subject: [linux-sunxi] [PATCH v4 2/8] phy: sun4i-usb: change PHYCTL
 register clearing code
In-Reply-To: <20170319161951.55834-3-icenowy@aosc.xyz>
References: <20170319161951.55834-1-icenowy@aosc.xyz>
 <20170319161951.55834-3-icenowy@aosc.xyz>
Message-ID: <CAGb2v67Y_EeNN9wzgeSS=ReaaJ9kN2tn449OrEQNG9tE1WOYDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:19 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> It seems that all SoCs after A33 (including A33) need the PHYCTL
> register to be cleared before writing to it. These SoCs all have another
> feature: PHYCTL register is at 0x10, not 0x04.

As mentioned in the other patch, the basis for this description is
wrong. Just state that, among all the currently supported SoCs, when
PHYCTL is at 0x10, the register must be cleared before writing to it.

This would match what the logic in your patch means. Please also
update the comment.

ChenYu

>
> Change PHYCTL register clearing code to judge whether clearing is needed
> based on the PHYCTL offset.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> New patch in v4.
>
>  drivers/phy/phy-sun4i-usb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index a21b5f24a340..62b4d25448c6 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -188,10 +188,8 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
>
>         spin_lock_irqsave(&phy_data->reg_lock, flags);
>
> -       if (phy_data->cfg->type == sun8i_a33_phy ||
> -           phy_data->cfg->type == sun50i_a64_phy ||
> -           phy_data->cfg->type == sun8i_v3s_phy) {
> -               /* A33 or A64 needs us to set phyctl to 0 explicitly */
> +       if (phy_data->cfg->phyctl_offset == REG_PHYCTL_A33) {
> +               /* SoCs newer than A33 need us to set phyctl to 0 explicitly */
>                 writel(0, phyctl);
>         }
>
> --
> 2.12.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
