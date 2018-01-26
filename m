From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 26 Jan 2018 18:40:08 +0100
Subject: [PATCH v4 1/3] i2c: mv64xxx: Remove useless test before
 clk_disable_unprepare
In-Reply-To: <20180116163540.1092-2-gregory.clement@free-electrons.com>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
 <20180116163540.1092-2-gregory.clement@free-electrons.com>
Message-ID: <20180126174008.a6eqrkottmvq3zfu@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 05:35:38PM +0100, Gregory CLEMENT wrote:
> The 2 functions called from clk_disable_unprepare() already check that
> the clock pointer is valid: no need to test it before calling it.

I can't find that in the code for !OF?

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index a832c45276a4..f69066266faa 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -950,9 +950,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  exit_reset:
>  	reset_control_assert(drv_data->rstc);
>  exit_clk:
> -	/* Not all platforms have a clk */
> -	if (!IS_ERR(drv_data->clk))
> -		clk_disable_unprepare(drv_data->clk);
> +	clk_disable_unprepare(drv_data->clk);
>  
>  	return rc;
>  }
> @@ -965,9 +963,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
>  	i2c_del_adapter(&drv_data->adapter);
>  	free_irq(drv_data->irq, drv_data);
>  	reset_control_assert(drv_data->rstc);
> -	/* Not all platforms have a clk */
> -	if (!IS_ERR(drv_data->clk))
> -		clk_disable_unprepare(drv_data->clk);
> +	clk_disable_unprepare(drv_data->clk);
>  
>  	return 0;
>  }
> -- 
> 2.15.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/cc0de7bc/attachment.sig>
