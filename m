From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 8 Nov 2014 19:03:14 +0100
Subject: [PATCH v3 3/3] i2c/at91: adopt pinctrl support
In-Reply-To: <1414133417-11530-4-git-send-email-wenyou.yang@atmel.com>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
 <1414133417-11530-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20141108180314.GD4900@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 02:50:17PM +0800, Wenyou Yang wrote:
> Amend the i2c at91 pin controller to optionally take a pin control
> handle and set the state of the pins to:
> 
> - "default" on boot, resume and before performing an transfer
> - "sleep" on suspend()
> 
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  drivers/i2c/busses/i2c-at91.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 6a84a2a..290caf1 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -32,6 +32,7 @@
>  #include <linux/slab.h>
>  #include <linux/platform_data/dma-atmel.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #define DEFAULT_TWI_CLK_HZ		100000		/* max 400 Kbits/s */
>  #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
> @@ -747,6 +748,8 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	u32 phy_addr;
>  	u32 bus_clk_rate;
>  
> +	pinctrl_pm_select_default_state(&pdev->dev);
> +

Do we really need this in probe? Isn't that default? I'm not sure,
though...

>  	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
> @@ -851,6 +854,8 @@ static int at91_twi_runtime_suspend(struct device *dev)
>  
>  	clk_disable_unprepare(twi_dev->clk);
>  
> +	pinctrl_pm_select_sleep_state(dev);
> +
>  	return 0;
>  }
>  
> @@ -858,6 +863,8 @@ static int at91_twi_runtime_resume(struct device *dev)
>  {
>  	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
>  
> +	pinctrl_pm_select_default_state(dev);
> +
>  	return clk_prepare_enable(twi_dev->clk);
>  }
>  
> -- 
> 1.7.9.5
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141108/0f6a9b4f/attachment.sig>
