From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Nov 2012 15:35:42 +0530
Subject: [PATCH 3/3] CLK: add more managed APIs
In-Reply-To: <1353403339-11679-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-4-git-send-email-dmitry.torokhov@gmail.com>
Message-ID: <CAKohpo=PMQanmVyo22HoqoXT2e3DUU8coPS85wDPDZjyFsRunQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2012 14:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> When converting a driver to managed resources it is desirable to be able to
> manage all resources in the same fashion. This change allows managing clocks
> in the same way we manage all otehr resources.

s/otehr/other

> This adds the following managed APIs:
>
> - devm_clk_prepare()/devm_clk_unprepare();
> - devm_clk_enable()/devm_clk_disable();
> - devm_clk_preapre_enable()/devm_clk_diable_unprepare().
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/clk/clk-devres.c |  91 +++++++++++++++++++++++++++++++---------
>  include/linux/clk.h      | 105 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 177 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 8f57154..2703fa9 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -9,6 +9,33 @@
>  #include <linux/export.h>
>  #include <linux/gfp.h>
>
> +static int devm_clk_match(struct device *dev, void *res, void *data)
> +{
> +       struct clk **c = res;
> +       if (!c || !*c) {
> +               WARN_ON(!c || !*c);

I know, you just moved this routine higher in the file. But above two
lines look duplicated. Can we just use WARN(); here?

> +               return 0;
> +       }
> +       return *c == data;
> +}
> +
> +
> +static int devm_clk_create_devres(struct device *dev,
> +                                 struct clk *clk,
> +                                 void (*release)(struct device *, void *))

This didn't came in two lines?

> +{

Apart from that, looks fine.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
