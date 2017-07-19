From: johan@kernel.org (Johan Hovold)
Date: Wed, 19 Jul 2017 13:10:00 +0200
Subject: [PATCH 2/4] gpio: davinci: Handle the return value of
 davinci_gpio_irq_setup function
In-Reply-To: <1500375436-9435-3-git-send-email-j-keerthy@ti.com>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-3-git-send-email-j-keerthy@ti.com>
Message-ID: <20170719111000.GX29638@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:27:14PM +0530, Keerthy wrote:
> Currently davinci_gpio_irq_setup return value is ignored. Handle the
> return value appropriately.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/gpio/gpio-davinci.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 2c88054..932f270 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -233,15 +233,23 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  		chips->regs[bank] = gpio_base + offset_array[bank];
>  
>  	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
> +	if (ret)
> +		goto err;
> +
> +	platform_set_drvdata(pdev, chips);
> +	ret = davinci_gpio_irq_setup(pdev);
>  	if (ret) {
> -		ctrl_num = 0;
> -		bank_base = 0;
> -		return ret;
> +		platform_set_drvdata(pdev, NULL);
> +		goto err;
>  	}
>  
> -	platform_set_drvdata(pdev, chips);
> -	davinci_gpio_irq_setup(pdev);
>  	return 0;

There's a separate but related bug here too as the clk_prepare_enable()
in davinci_gpio_irq_setup() is never balanced on driver unbind.

Johan
