From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 21 Apr 2010 10:37:30 +0300
Subject: [PATCH] PL061 GPIO: Changing *_irq_chip_data with *_irq_data
	for real irqs.
In-Reply-To: <1271833201-4482-1-git-send-email-viresh.kumar@st.com>
References: <1271833201-4482-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100421073728.GA6345@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Wed, Apr 21, 2010 at 12:30:01PM +0530, Viresh KUMAR wrote:
> PL061 driver is using set_irq_chip_data and get_irq_chip_data for real irq
> lines. It must be using *_irq_data functions instead. As chip_data is used by
> interrupt controllers also, which makes vic write at incorrect addresses.
>
> Also, pl061_direction_output doesn't set value of gpio to value passed to 
> it.  Adding code to set value of GPIO pin to requrested value.

Please split this patch into two separate patches. The two fixes are unrelated 
to each other.

> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/gpio/pl061.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
> index 3ad1eeb..0a30124 100644
> --- a/drivers/gpio/pl061.c
> +++ b/drivers/gpio/pl061.c
> @@ -86,10 +86,10 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
>  		return -EINVAL;
>  
>  	spin_lock_irqsave(&chip->lock, flags);
> -	writeb(!!value << offset, chip->base + (1 << (offset + 2)));

I'm still for keeping this line.

>  	gpiodir = readb(chip->base + GPIODIR);
>  	gpiodir |= 1 << offset;
>  	writeb(gpiodir, chip->base + GPIODIR);
> +	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
>  	spin_unlock_irqrestore(&chip->lock, flags);
>  
>  	return 0;
> @@ -203,7 +203,7 @@ static struct irq_chip pl061_irqchip = {
>  
>  static void pl061_irq_handler(unsigned irq, struct irq_desc *desc)
>  {
> -	struct list_head *chip_list = get_irq_chip_data(irq);
> +	struct list_head *chip_list = get_irq_data(irq);
>  	struct list_head *ptr;
>  	struct pl061_gpio *chip;
>  
> @@ -296,9 +296,9 @@ static int __init pl061_probe(struct amba_device *dev, struct amba_id *id)
>  			goto iounmap;
>  		}
>  		INIT_LIST_HEAD(chip_list);
> -		set_irq_chip_data(irq, chip_list);
> +		set_irq_data(irq, chip_list);
>  	} else
> -		chip_list = get_irq_chip_data(irq);
> +		chip_list = get_irq_data(irq);
>  	list_add(&chip->list, chip_list);
>  
>  	for (i = 0; i < PL061_GPIO_NR; i++) {

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
