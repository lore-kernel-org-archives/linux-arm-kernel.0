From: keescook@chromium.org (Kees Cook)
Date: Thu, 23 Aug 2018 19:57:35 -0700
Subject: [PATCH] mtd: rawnand: atmel: use struct_size() in devm_kzalloc()
In-Reply-To: <20180824010938.GA25581@embeddedor.com>
References: <20180824010938.GA25581@embeddedor.com>
Message-ID: <CAGXu5jL_p6Z863qq5=K2B+=AW6LuxmBu23bjhQe-1saz4kdeFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 6:09 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index a068b21..b17cfd0 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1586,9 +1586,7 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       nand = devm_kzalloc(nc->dev,
> -                           sizeof(*nand) + (numcs * sizeof(*nand->cs)),
> -                           GFP_KERNEL);
> +       nand = devm_kzalloc(nc->dev, struct_size(nand, cs, numcs), GFP_KERNEL);
>         if (!nand) {
>                 dev_err(nc->dev, "Failed to allocate NAND object\n");
>                 return ERR_PTR(-ENOMEM);
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
