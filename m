From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 7 Nov 2018 09:39:28 +0100
Subject: [PATCH] i2c: at91: switched to resume/suspend callbacks.
In-Reply-To: <1540203006-805-1-git-send-email-andrei.stefanescu@microchip.com>
References: <1540203006-805-1-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <20181107083928.vqgnpw3mmczjn4el@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2018 at 12:17:47PM +0200, Andrei Stefanescu - M50506 wrote:
> In the previous version of the driver resume/suspend_noirq callbacks
> were used. Because of this, when resuming from suspend-to-ram,
> an I2C (belonging to a FLEXCOM) would resume before FLEXCOM.
> The first read on the I2C bus would then result in a timeout.
> 
> This patch switches to resume/suspend callbacks which are 
> called after FLEXCOM resumes. FLEXCOM, SPI and USART drivers use
> resume/suspend callbacks.
> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
I can't figure out why we use the _noirq variant. When patches for PM
stuff were sent, suspend/resume callbacks were used but in the latest
version it moved to the _noirq variant without explanation.

Excepting if someone has an argument to keep the _noirq variant,
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks

Regards

Ludovic

> ---
>  drivers/i2c/busses/i2c-at91.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index bfd1fdf..81f7b94 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1174,7 +1174,7 @@ static int at91_twi_runtime_resume(struct device *dev)
>  	return clk_prepare_enable(twi_dev->clk);
>  }
>  
> -static int at91_twi_suspend_noirq(struct device *dev)
> +static int at91_twi_suspend(struct device *dev)
>  {
>  	if (!pm_runtime_status_suspended(dev))
>  		at91_twi_runtime_suspend(dev);
> @@ -1182,7 +1182,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
>  	return 0;
>  }
>  
> -static int at91_twi_resume_noirq(struct device *dev)
> +static int at91_twi_resume(struct device *dev)
>  {
>  	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
>  	int ret;
> @@ -1202,8 +1202,8 @@ static int at91_twi_resume_noirq(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops at91_twi_pm = {
> -	.suspend_noirq	= at91_twi_suspend_noirq,
> -	.resume_noirq	= at91_twi_resume_noirq,
> +	.suspend	= at91_twi_suspend,
> +	.resume		= at91_twi_resume,
>  	.runtime_suspend	= at91_twi_runtime_suspend,
>  	.runtime_resume		= at91_twi_runtime_resume,
>  };
> -- 
> 2.7.4
> 
