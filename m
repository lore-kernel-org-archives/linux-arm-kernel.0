From: keescook@chromium.org (Kees Cook)
Date: Thu, 23 Aug 2018 19:56:12 -0700
Subject: [PATCH] drm/sun4i: tcon-top: Use struct_size() in devm_kzalloc()
In-Reply-To: <20180824010521.GA25451@embeddedor.com>
References: <20180824010521.GA25451@embeddedor.com>
Message-ID: <CAGXu5j+TjY71LnCJhd=26Prigq8rhM0h59bY9KUh9=n6i3oQ-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 6:05 PM, Gustavo A. R. Silva
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
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> index 55fe398..3040a79 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -129,8 +129,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>         if (!tcon_top)
>                 return -ENOMEM;
>
> -       clk_data = devm_kzalloc(dev, sizeof(*clk_data) +
> -                               sizeof(*clk_data->hws) * CLK_NUM,
> +       clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, CLK_NUM),
>                                 GFP_KERNEL);
>         if (!clk_data)
>                 return -ENOMEM;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
