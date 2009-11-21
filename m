From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 21 Nov 2009 16:16:19 +0000
Subject: [PATCH] ARM: PNX4008: i2c-pnx: use the same dev_id for
	request_irq and free_irq
In-Reply-To: <E1NBsaT-0007az-Aa@rmk-PC.arm.linux.org.uk>
References: <E1NBsaT-0007az-Aa@rmk-PC.arm.linux.org.uk>
Message-ID: <20091121161619.GO13398@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 04:13:25PM +0000, Russell King - ARM Linux wrote:
> This allows i2c-pnx to free its interrupt handler when the module
> is removed or if an error occurs; using the same dev_id for both
> request_irq and free_irq is desirable.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

If you want to merge this via your current pnx work, then have my ack
to this, otherwise let me know and i'll add it to i2c-fixes.

Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/i2c/busses/i2c-pnx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 1fca590..fbab684 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -650,7 +650,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out_irq:
> -	free_irq(alg_data->irq, alg_data);
> +	free_irq(alg_data->irq, i2c_pnx->adapter);
>  out_clock:
>  	i2c_pnx->set_clock_stop(pdev);
>  out_unmap:
> @@ -669,7 +669,7 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
>  	struct i2c_adapter *adap = i2c_pnx->adapter;
>  	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
>  
> -	free_irq(alg_data->irq, alg_data);
> +	free_irq(alg_data->irq, i2c_pnx->adapter);
>  	i2c_del_adapter(adap);
>  	i2c_pnx->set_clock_stop(pdev);
>  	iounmap((void *)alg_data->ioaddr);
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
