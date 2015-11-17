From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 17 Nov 2015 10:50:26 +0800
Subject: [PATCH] pinctrl: mediatek: fix a memleak when do dt maps.
In-Reply-To: <1447727690-15251-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1447727690-15251-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CAGS+omAZ+rgT2NG4-U7HK4kZJGHqA8n_0EjZpHfePojYYLd1Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 10:34 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:
> configs will kmemdup to dup_configs in pictrl util function.
> So configs need to be freed.
>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  Fix a memleak issue.
>
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index bbf0230..0000b5a 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -568,9 +568,10 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>                 }
>         }
>
> -       return 0;
> +       err = 0;
>
>  fail:

This isn't just 'fail' case anymore, so change label name to something
like "exit".

> +       kfree(configs);

Do we also need to kfree in the "if (!num_pins || !maps_per_pin)" error case?

>         return err;
>  }
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
