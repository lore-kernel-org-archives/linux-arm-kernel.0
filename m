From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 9 May 2010 23:28:11 +0200
Subject: [PATCH 1/1] mfd: delay to mask tsc irq in max8925
In-Reply-To: <k2m771cded01004280555wd2df54d3j969ff5f1e3e5267b@mail.gmail.com>
References: <k2m771cded01004280555wd2df54d3j969ff5f1e3e5267b@mail.gmail.com>
Message-ID: <20100509212810.GC3269@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, Apr 28, 2010 at 08:55:53AM -0400, Haojian Zhuang wrote:
> From 07243e51659a11946a149a5f4a74322cfd840c35 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 27 Apr 2010 14:55:28 -0400
> Subject: [PATCH] mfd: delay to mask tsc irq in max8925
> 
> There're two IRQ pins output from MAX8925. One is PMIC interrupt, the other
> is TSC interrupt. But they're sharing one irq chip.
> 
> After initializing MAX8925 interrupts, unexpected TSC interrupt may occur and
> it can't be cleared if touch driver isn't loaded.
> 
> Now move the operation of masking TSC interrupt behind requesting PMIC
> interrupt. If touch driver isn't loaded, this interrupt is always masked.
Patch applied to my for-next branch, thanks.

Cheers,
Samuel.


> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mfd/max8925-core.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
> index 85d63c0..f621bce 100644
> --- a/drivers/mfd/max8925-core.c
> +++ b/drivers/mfd/max8925-core.c
> @@ -508,7 +508,7 @@ static int max8925_irq_init(struct max8925_chip
> *chip, int irq,
>  	max8925_reg_read(chip->i2c, MAX8925_ON_OFF_IRQ2);
>  	max8925_reg_read(chip->rtc, MAX8925_RTC_IRQ);
>  	max8925_reg_read(chip->adc, MAX8925_TSC_IRQ);
> -	/* mask all interrupts */
> +	/* mask all interrupts except for TSC */
>  	max8925_reg_write(chip->rtc, MAX8925_ALARM0_CNTL, 0);
>  	max8925_reg_write(chip->rtc, MAX8925_ALARM1_CNTL, 0);
>  	max8925_reg_write(chip->i2c, MAX8925_CHG_IRQ1_MASK, 0xff);
> @@ -516,7 +516,6 @@ static int max8925_irq_init(struct max8925_chip
> *chip, int irq,
>  	max8925_reg_write(chip->i2c, MAX8925_ON_OFF_IRQ1_MASK, 0xff);
>  	max8925_reg_write(chip->i2c, MAX8925_ON_OFF_IRQ2_MASK, 0xff);
>  	max8925_reg_write(chip->rtc, MAX8925_RTC_IRQ_MASK, 0xff);
> -	max8925_reg_write(chip->adc, MAX8925_TSC_IRQ_MASK, 0xff);
> 
>  	mutex_init(&chip->irq_lock);
>  	chip->core_irq = irq;
> @@ -547,7 +546,11 @@ static int max8925_irq_init(struct max8925_chip
> *chip, int irq,
>  		dev_err(chip->dev, "Failed to request core IRQ: %d\n", ret);
>  		chip->core_irq = 0;
>  	}
> +
>  tsc_irq:
> +	/* mask TSC interrupt */
> +	max8925_reg_write(chip->adc, MAX8925_TSC_IRQ_MASK, 0x0f);
> +
>  	if (!pdata->tsc_irq) {
>  		dev_warn(chip->dev, "No interrupt support on TSC IRQ\n");
>  		return 0;
> -- 
> 1.5.6.5

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
