From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Dec 2013 09:30:42 +0000
Subject: [PATCH v3 15/15] mfd: menelaus: Use devm_request_threaded_irq()
In-Reply-To: <1386606085-26838-15-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-15-git-send-email-balbi@ti.com>
Message-ID: <20131210093042.GU12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> By using devm_request_threaded_irq() we can drop a few extra lines of
> code and rely on device managed resources layer to free our IRQ for us.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index bffe978..b87c2bd 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1271,8 +1271,8 @@ static int menelaus_probe(struct i2c_client *client,
>  	/* Set output buffer strengths */
>  	menelaus_write_reg(m, MENELAUS_MCT_CTRL1, 0x73);
>  
> -	err = request_threaded_irq(client->irq, NULL, menelaus_irq,
> -			IRQF_ONESHOT, DRIVER_NAME, m);
> +	err = devm_request_threaded_irq(&client->dev, client->irq,
> +			NULL, menelaus_irq, IRQF_ONESHOT, DRIVER_NAME, m);

No need for a separate patch here. Convert straight from request_irq()
to devm_request_threaded_irq() in patch 3.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
