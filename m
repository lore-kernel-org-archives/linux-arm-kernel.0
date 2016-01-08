From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 8 Jan 2016 16:21:18 +0800
Subject: [PATCH] clk: mediatek: Fix memory leak on clock init fail
In-Reply-To: <1452240933-60695-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1452240933-60695-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <CAGS+omCXK4mFBz1HoDUMCPHKa5cqa4DOkbjBuratcps6nBLfig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 8, 2016 at 4:15 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> mtk_clk_register_composite() may leak memory due to some error
> handling path don't free all allocated memory. This patch
> free all pointers that may allocate memory before error return.
> And it's safe because kfree() can handle NULL pointers.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  drivers/clk/mediatek/clk-mtk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index cf08db6..3528303 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -209,12 +209,14 @@ struct clk * __init mtk_clk_register_composite(const struct mtk_composite *mc,
>                 mc->flags);
>
>         if (IS_ERR(clk)) {
> -               kfree(gate);
> -               kfree(mux);
> +               ret = PTR_ERR(clk);
> +               goto err_out;
>         }
>
>         return clk;
>  err_out:
> +       kfree(div);
> +       kfree(gate);
>         kfree(mux);
>
>         return ERR_PTR(ret);
> --
> 1.9.1
>
