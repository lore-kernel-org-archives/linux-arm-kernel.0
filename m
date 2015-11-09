From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 9 Nov 2015 16:25:09 +0200
Subject: [PATCH v2 1/2] i2c: mediatek: add i2c first write then read
 optimization
In-Reply-To: <1447047839-5223-2-git-send-email-liguo.zhang@mediatek.com>
References: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
 <1447047839-5223-2-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <CAHp75VfutRR0N0bGDYMjFr+nQGFnmuoiA2afvYfuZ2aOy=2qbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 9, 2015 at 7:43 AM, Liguo Zhang <liguo.zhang@mediatek.com> wrote:
> For platform with auto restart support, between every transfer,
> i2c controller will trigger an interrupt and SW need to handle
> it to start new transfer. When doing write-then-read transfer,
> instead of restart mechanism, using WRRD mode to have controller
> send both transfer in one request to reduce latency.


> @@ -518,6 +529,16 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
>         if (ret)
>                 return ret;
>
> +       i2c->auto_restart = i2c->dev_comp->auto_restart;
> +
> +       /* checking if we can skip restart and optimize using WRRD mode */
> +       if (i2c->auto_restart && num == 2) {
> +               if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
> +                   msgs[0].addr == msgs[1].addr) {

Nitpick (optional):

((msgs[0].flags & msgs[1].flags) & I2C_M_RD)
?

> +                       i2c->auto_restart = 0;
> +               }
> +       }

-- 
With Best Regards,
Andy Shevchenko
