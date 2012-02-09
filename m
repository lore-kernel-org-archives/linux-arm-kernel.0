From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Feb 2012 12:04:39 -0800
Subject: [PATCH v4 4/4] gpio: pl061: enable interrupts with DT style
 binding
In-Reply-To: <1328308512-22594-5-git-send-email-robherring2@gmail.com>
References: <1328308512-22594-1-git-send-email-robherring2@gmail.com>
 <1328308512-22594-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120209200435.GB2493@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 04:35:12PM -0600, Rob Herring wrote:
...
> @@ -126,18 +127,16 @@ static void pl061_set_value(struct gpio_chip *gc, unsigned offset, int value)
>  static int pl061_to_irq(struct gpio_chip *gc, unsigned offset)
>  {
>  	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
> -
> -	if (chip->irq_base <= 0)
> -		return -EINVAL;
> -
> -	return chip->irq_base + offset;
> +	if (!chip->irq_gc)
> +		return -ENXIO;
> +	return irq_find_mapping(chip->irq_gc->domain, offset);

If I understand the driver correctly, it will add a linear domain for
dt case.  Do you have code somewhere creating the mapping before this
irq_find_mapping gets called here?  The reason I'm asking this is I
have to call irq_create_mapping rather than irq_find_mapping here to
get imx gpio driver working with linear domain, otherwise the
irq_find_mapping call will fail.

Regards,
Shawn

>  }
