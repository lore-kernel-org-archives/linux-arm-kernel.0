From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Nov 2013 10:26:03 -0800
Subject: [PATCH RESEND AGAIN] clk: clean up everything on debugfs error
In-Reply-To: <52961245.4010504@linaro.org>
References: <52961245.4010504@linaro.org>
Message-ID: <20131127182603.16819.10664@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alex Elder (2013-11-27 07:39:49)
> [Maybe the third time will be the charm. -Alex]
> 
> If CONFIG_COMMON_CLK_DEBUG is defined, clk_debug_create_one() is
> called to populate a debugfs directory with a few entries that are
> common for all clock types.
> 
> If an error happens after creating the first one debugfs_remove() is
> called on the clock's directory.  The problem with this is that no
> cleanup is done on the debugfs files already created in that
> directory, so the directory never actually gets removed.   This
> problem is silently ignored.
> 
> Fix this by calling debugfs_remove_recursive() instead.  Reset the
> clk->dentry field to null afterward, to ensure it can't be mistaken
> as a valid pointer.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Thanks! Taken into clk-next.

Regards,
Mike

> ---
>  drivers/clk/clk.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2cf2ea6..77fcd06 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -272,7 +272,8 @@ static int clk_debug_create_one(struct clk *clk,
> struct dentry *pdentry)
>         goto out;
> 
>  err_out:
> -       debugfs_remove(clk->dentry);
> +       debugfs_remove_recursive(clk->dentry);
> +       clk->dentry = NULL;
>  out:
>         return ret;
>  }
> -- 
> 1.7.9.5
