From: dianders@google.com (Doug Anderson)
Date: Wed, 9 Nov 2016 12:54:18 -0800
Subject: [PATCH] phy: rockchip-inno-usb2: correct 480MHz output clock
 stable time
In-Reply-To: <1478523658-9400-1-git-send-email-wulf@rock-chips.com>
References: <1478523658-9400-1-git-send-email-wulf@rock-chips.com>
Message-ID: <CAD=FV=VC15_QAs7+DOoqCeWrU6-qqnUku2SSPFLOvLanu8xL3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 7, 2016 at 5:00 AM, William Wu <wulf@rock-chips.com> wrote:
> We found that the system crashed due to 480MHz output clock of
> USB2 PHY was unstable after clock had been enabled by gpu module.
>
> Theoretically, 1 millisecond is a critical value for 480MHz
> output clock stable time, so we try to change the delay time
> to 1.2 millisecond to avoid this issue.
>
> Signed-off-by: William Wu <wulf@rock-chips.com>
> ---
>  drivers/phy/phy-rockchip-inno-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
> index ecfd7d1..8f2d2b6 100644
> --- a/drivers/phy/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/phy-rockchip-inno-usb2.c
> @@ -267,7 +267,7 @@ static int rockchip_usb2phy_clk480m_enable(struct clk_hw *hw)
>                         return ret;
>
>                 /* waitting for the clk become stable */
> -               mdelay(1);
> +               udelay(1200);

Several people who have seen this patch have expressed concern that a
1.2 ms delay is pretty long for something that's supposed to be
"atomic" like a clk_enable().  Consider that someone might call
clk_enable() while interrupts are disabled and that a 1.2 ms interrupt
latency is not so great.

It seems like this clock should be moved to be enabled in "prepare"
and the "enable" should be a no-op.  This is a functionality change,
but I don't think there are any real users for this clock at the
moment so it should be fine.

(of course, the 1 ms latency that existed before this patch was still
pretty bad, but ...)

-Doug
