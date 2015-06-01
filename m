From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Jun 2015 09:31:59 +0100
Subject: [PATCH 2/4] mfd: 88pm800: use irq_mode to configure interrupt
 status reg clear method
In-Reply-To: <1432937962-4537-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150601083159.GD3329@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 May 2015, Vaibhav Hiremath wrote:

> From the spec, bit 1 of reg 0xe (page 0): IN_CLEAR_MODE controls the
> method of clearing interrupt status register of 88pm800;
> 
>   0: clear on read
>   1: clear on write
> 
> Signed-off-by: zhaoy <zhaoy@marvell.com>

This signed-off is not acceptable.

No nicknames.  Full names only.

> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c       | 4 +++-
>  include/linux/mfd/88pm80x.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> index 06ee058..8ea4467 100644
> --- a/drivers/mfd/88pm800.c
> +++ b/drivers/mfd/88pm800.c
> @@ -391,7 +391,8 @@ static int device_irq_init_800(struct pm80x_chip *chip)
>  	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
>  	    PM800_WAKEUP2_INT_MASK;
>  
> -	data = PM800_WAKEUP2_INT_CLEAR;
> +	data = (chip->irq_mode) ?
> +		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;

These variable names are terrible.  'irq_mode' as a bool tells me
nothing.

What does; irq_mode = 'yes' and irq_mode = 'no' mean?  If I didn't
read the remainder of the code, I would assume if it was 'yes' then
the device was in IRQ Mode and if not, it would be in PIO or Polling
mode, but that's not what it means at all is it?

As for 'data', well, isn't everything data?

>  	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, data);
>  
>  	if (ret < 0)
> @@ -514,6 +515,7 @@ static int device_800_init(struct pm80x_chip *chip,
>  	}
>  
>  	chip->regmap_irq_chip = &pm800_irq_chip;
> +	chip->irq_mode = pdata->irq_mode;
>  
>  	ret = device_irq_init_800(chip);
>  	if (ret < 0) {
> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
> index 97cb283..6ed6c16 100644
> --- a/include/linux/mfd/88pm80x.h
> +++ b/include/linux/mfd/88pm80x.h
> @@ -77,6 +77,8 @@ enum {
>  #define PM800_WAKEUP2		(0x0E)
>  #define PM800_WAKEUP2_INV_INT		(1 << 0)
>  #define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
> +#define PM800_WAKEUP2_INT_READ_CLEAR		(0 << 1)
> +#define PM800_WAKEUP2_INT_WRITE_CLEAR		(1 << 1)
>  #define PM800_WAKEUP2_INT_MASK		(1 << 2)
>  
>  #define PM800_POWER_UP_LOG	(0x10)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
