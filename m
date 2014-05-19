From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 19 May 2014 07:53:28 +0200
Subject: [PATCH v3] pwm: i.MX: Avoid sample FIFO overflow for i.MX PWM
 version2
In-Reply-To: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
References: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20140519075328.7f2ef0c5@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Liu Ying wrote:
[...]
> @@ -30,6 +32,7 @@
>  /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
>  
>  #define MX3_PWMCR                 0x00    /* PWM Control Register */
> +#define MX3_PWMIR                 0x08    /* PWM Interrupt Register */
>  #define MX3_PWMSAR                0x0C    /* PWM Sample Register */
>  #define MX3_PWMPR                 0x10    /* PWM Period Register */
>  #define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
> @@ -38,7 +41,12 @@
>  #define MX3_PWMCR_DBGEN			(1 << 22)
>  #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
>  #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
> +#define MX3_PWMCR_SWR		  (1 << 3)
>  #define MX3_PWMCR_EN              (1 << 0)
> +#define MX3_PWMSR_ROV             (1 << 4)
> +#define MX3_PWMIR_RIE             (1 << 1)
> +
You should decide whether to use tabs or spaces for indentation.
And probably cleanup the indentation of the existing definitions to use
all the same indentation style.

> @@ -128,6 +160,13 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  	else
>  		period_cycles = 0;
>  
> +	if (!enable || duty_cycles == 0)
> +		imx_pwm_software_reset_v2(chip);
> +	else if (readl(imx->mmio_base + MX3_PWMSAR))
> +		/* No rollover irq generated if duty peroid is zero. */
typo: 'period'.

> @@ -135,27 +174,55 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
>  		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
>  
> -	if (test_bit(PWMF_ENABLED, &pwm->flags))
> +	if (enable)
>  		cr |= MX3_PWMCR_EN;
>  
>  	writel(cr, imx->mmio_base + MX3_PWMCR);
>  
> +	if (enable && duty_cycles)
> +		/* No rollover irq generated if duty peroid is zero. */
dto.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
