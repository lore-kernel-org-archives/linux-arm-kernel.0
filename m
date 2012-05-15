From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 15 May 2012 09:17:50 +0200
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20402.798.622618.263780@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> Same as what the driver does for data register shadow bgc->data,
> the bgpio_init should also initialize direction register shadow
> bgc->dir to preserve the existing setting.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/gpio/gpio-generic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
> index e38dd0c..53222c7 100644
> --- a/drivers/gpio/gpio-generic.c
> +++ b/drivers/gpio/gpio-generic.c
> @@ -394,6 +394,7 @@ int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
>  		return ret;
>  
>  	bgc->data = bgc->read_reg(bgc->reg_dat);
> +	bgc->dir = bgc->read_reg(bgc->reg_dir);
>  
This will blow up in your face when calling bgpio_init() without any
direction register (which is well supported by the generic driver).

You need to do this in the platform specific driver that uses the
generic driver. See gpio-mxc.c for reference:
|        err = bgpio_init(&port->bgc, &pdev->dev, 4,
|                         port->base + GPIO_PSR,
|                         port->base + GPIO_DR, NULL,
|                         port->base + GPIO_GDIR, NULL, false);
|        if (err)
|                goto out_iounmap;
|
|        port->bgc.gc.to_irq = mxc_gpio_to_irq;
|        port->bgc.gc.base = pdev->id * 32;
|        port->bgc.dir = port->bgc.read_reg(port->bgc.reg_dir);
|        port->bgc.data = port->bgc.read_reg(port->bgc.reg_set);


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
