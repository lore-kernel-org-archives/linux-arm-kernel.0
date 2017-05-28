From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 28 May 2017 15:50:41 +0100
Subject: [PATCH] iio: adc: xilinx: Handle return value of
 clk_prepare_enable
In-Reply-To: <29dda0d20f714ce828e294f99b7f400e89f5b35a.1495780467.git.arvind.yadav.cs@gmail.com>
References: <29dda0d20f714ce828e294f99b7f400e89f5b35a.1495780467.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170528155041.478fc87b@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 May 2017 12:07:41 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Straight forward looking so I've applied this to the togreg
branch of iio.git and pushed it out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 56cf590..4a60497 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1204,7 +1204,10 @@ static int xadc_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(xadc->clk);
>  		goto err_free_samplerate_trigger;
>  	}
> -	clk_prepare_enable(xadc->clk);
> +
> +	ret = clk_prepare_enable(xadc->clk);
> +	if (ret)
> +		goto err_free_samplerate_trigger;
>  
>  	ret = xadc->ops->setup(pdev, indio_dev, irq);
>  	if (ret)
