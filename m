From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 19 Jan 2014 09:37:12 -0800
Subject: [PATCH] clk: export __clk_get_hw for re-use in others
In-Reply-To: <1390110907-29918-1-git-send-email-sj38.park@gmail.com>
References: <1390110907-29918-1-git-send-email-sj38.park@gmail.com>
Message-ID: <20140119173712.GA26481@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 02:55:07PM +0900, SeongJae Park wrote:
> Following build comes while modprobe process:
> > ERROR: "__clk_get_hw" [drivers/clk/clk-max77686.ko] undefined!
> > make[2]: *** [__modpost] Error 1
> > make[1]: *** [modules] Error 2
> 
> Export the symbol to fix it and for other part's usecase.
> 
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> ---
>  drivers/clk/clk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2b38dc9..3883fba 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -575,6 +575,7 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
>  {
>  	return !clk ? NULL : clk->hw;
>  }
> +EXPORT_SYMBOL_GPL(__clk_get_hw);

__ functions should usually only be for "internal" use, why does this
get exported to modules?  Why not just put it in a .h file?

greg k-h
