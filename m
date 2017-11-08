From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 8 Nov 2017 22:24:19 +0900
Subject: [PATCH] clk: uniphier: fix parent of miodmac clock data
In-Reply-To: <1508374366-27171-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508374366-27171-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARdcAvoNoe56fGvsmsWP=nZhQWtkDaxv=6r8h8T=FzNxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Could you pick this up, please?

You sent a pull request last week.
So, queuing this for -next is fine for me.



2017-10-19 9:52 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The "miodmac" is not a child of "stdmac".  They are independent
> from each other.  Fix it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/clk/uniphier/clk-uniphier-mio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
> index 16e4d30..badc478 100644
> --- a/drivers/clk/uniphier/clk-uniphier-mio.c
> +++ b/drivers/clk/uniphier/clk-uniphier-mio.c
> @@ -13,6 +13,8 @@
>   * GNU General Public License for more details.
>   */
>
> +#include <linux/stddef.h>
> +
>  #include "clk-uniphier.h"
>
>  #define UNIPHIER_MIO_CLK_SD_FIXED                                      \
> @@ -73,15 +75,12 @@
>  #define UNIPHIER_MIO_CLK_USB2_PHY(idx, ch)                             \
>         UNIPHIER_CLK_GATE("usb2" #ch "-phy", (idx), "usb2", 0x20 + 0x200 * (ch), 29)
>
> -#define UNIPHIER_MIO_CLK_DMAC(idx)                                     \
> -       UNIPHIER_CLK_GATE("miodmac", (idx), "stdmac", 0x20, 25)
> -
>  const struct uniphier_clk_data uniphier_ld4_mio_clk_data[] = {
>         UNIPHIER_MIO_CLK_SD_FIXED,
>         UNIPHIER_MIO_CLK_SD(0, 0),
>         UNIPHIER_MIO_CLK_SD(1, 1),
>         UNIPHIER_MIO_CLK_SD(2, 2),
> -       UNIPHIER_MIO_CLK_DMAC(7),
> +       UNIPHIER_CLK_GATE("miodmac", 7, NULL, 0x20, 25),
>         UNIPHIER_MIO_CLK_USB2(8, 0),
>         UNIPHIER_MIO_CLK_USB2(9, 1),
>         UNIPHIER_MIO_CLK_USB2(10, 2),
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
