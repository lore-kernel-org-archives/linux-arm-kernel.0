From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Oct 2017 08:42:22 +0200
Subject: [RFC 2/2] phy: exynos5-usbdrd: remove disable and enable of phy
 clk
In-Reply-To: <1507264595-3565-2-git-send-email-linux.amoon@gmail.com>
References: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
 <1507264595-3565-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <CAJKOXPe9FCKqrvsgdohTAN9tXXwbMOuyaDiHPxZ1Ym1LLPD41w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 6:36 AM, Anand Moon <linux.amoon@gmail.com> wrote:
> remove the disable and enable of phy clk.
> phy clk is needed to tune the phy controller.

Drivers should in general enable and disable the clocks they use. Just
like in patch #1 please describe why you are doing this, what kind of
problem are you trying to solve and what exactly are you trying to do
here.

BR,
Krzysztof

>
> Before:
>     mout_usbd300                          1            1 24000000          0 0
>        dout_usbd300                       0            0    24000000          0 0
>           sclk_usbd300                    0            0    24000000          0 0
>        dout_usbphy300                     1            1    24000000          0 0
>           sclk_usbphy300                  3            3    24000000          0 0
>     mout_usbd301                          1            1    24000000          0 0
>        dout_usbd301                       0            0    24000000          0 0
>           sclk_usbd301                    0            0    24000000          0 0
>        dout_usbphy301                     1            1    24000000          0 0
>           sclk_usbphy301                  2            2    24000000          0 0
> After:
>     mout_usbd300                          2            2    24000000          0 0
>        dout_usbd300                       1            1    24000000          0 0
>           sclk_usbd300                    2            2    24000000          0 0
>        dout_usbphy300                     1            1    24000000          0 0
>           sclk_usbphy300                  3            3    24000000          0 0
>     mout_usbd301                          2            2    24000000          0 0
>        dout_usbd301                       1            1    24000000          0 0
>           sclk_usbd301                    2            2    24000000          0 0
>        dout_usbphy301                     1            1    24000000          0 0
>           sclk_usbphy301                  2            2    24000000          0 0
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 22c68f5..5e8054c 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -409,22 +409,15 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
>         reg &= ~PHYCLKRST_PORTRESET;
>         writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYCLKRST);
>
> -       clk_disable_unprepare(phy_drd->clk);
> -
>         return 0;
>  }
>
>  static int exynos5_usbdrd_phy_exit(struct phy *phy)
>  {
> -       int ret;
>         u32 reg;
>         struct phy_usb_instance *inst = phy_get_drvdata(phy);
>         struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
>
> -       ret = clk_prepare_enable(phy_drd->clk);
> -       if (ret)
> -               return ret;
> -
>         reg =   PHYUTMI_OTGDISABLE |
>                 PHYUTMI_FORCESUSPEND |
>                 PHYUTMI_FORCESLEEP;
> --
> 2.7.4
>
