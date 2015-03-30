From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 30 Mar 2015 13:55:12 +0300
Subject: [patch] spi: pxa2xx: missing break in pxa2xx_ssp_get_clk_div()
In-Reply-To: <20150330103040.GB27144@mwanda>
References: <20150330103040.GB27144@mwanda>
Message-ID: <1427712912.14897.441.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-30 at 13:30 +0300, Dan Carpenter wrote:
> We refactored this code but accidentally left out a break statement so
> QUARK_X1000_SSP isn't handled correctly.
> 

Thanks for catching this!
One comment below.


> Fixes: 025ffe88ee60 ('spi: pxa2xx: shift clk_div in one place')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 60526a5..a081cfc 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -791,6 +791,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
>  	switch (drv_data->ssp_type) {
>  	case QUARK_X1000_SSP:
>  		clk_div = quark_x1000_get_clk_div(rate, &chip->dds_rate);
> +		break;
>  	default:
>  		clk_div = ssp_get_clk_div(drv_data, rate);

It would be nice to have a break here as well, but I think we also may
change this to if-else-if construction.

>  	}

Whatever solution you choose
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

And actually 
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Now run with time to see the difference.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
