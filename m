From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 12 Aug 2015 18:33:55 +0800
Subject: [PATCH 07/20] regmap: Without bus read() or write(),
 force use_single_rw
In-Reply-To: <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
Message-ID: <CAGS+omC6dFVnzWmQN2XGy31s1nm-hQJ6DigJREynCAf7A-PcFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Wed, Aug 12, 2015 at 6:12 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
>
> The implementation of regmap bus read() and write() methods are
> optional. Therefore we have to handle busses which do not have these
> functions. If raw read() and write() is not supported we have to use
> reg_read and reg_write always.
>
> This patch sets use_single_rw if read() or write() is not set.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/base/regmap/regmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index f98bd5bf5c62..35ad3783da70 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -573,7 +573,7 @@ struct regmap *regmap_init(struct device *dev,
>                 map->reg_stride = config->reg_stride;
>         else
>                 map->reg_stride = 1;
> -       map->use_single_rw = config->use_single_rw;
> +       map->use_single_rw = config->use_single_rw || !bus->read || !bus->write;

What if bus is NULL?

-Dan

>         map->can_multi_write = config->can_multi_write;
>         map->dev = dev;
>         map->bus = bus;
> --
> 2.4.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
