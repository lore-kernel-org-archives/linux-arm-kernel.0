From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 30 Jan 2015 07:43:24 +0100
Subject: [PATCH v6 4/8] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <1422540556-14828-5-git-send-email-mpa@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20150130074324.3e4d868f@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Markus Pargmann wrote:
> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpose
> ADC but one is meant to be used for touchscreens.
> 
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> the correct components.
> 
[...]
> diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
> new file mode 100644
> index 000000000000..8e4013d57500
> --- /dev/null
> +++ b/drivers/mfd/fsl-imx25-tsadc.c
> @@ -0,0 +1,167 @@
[...]
> +#define MX25_TGCR_POWERMODE_MASK	(3 << 8)
> +#define MX25_TGCR_POWERMODE_SAVE	BIT(8)
> +#define MX25_TGCR_POWERMODE_ON		(2 << 8)
>
This looks a bit weird and conceals the fact, that
MX25_TGCR_POWERMODE_SAVE is in fact one of the possible settings
of a two bit bitfield. For consistency I would write:
#define MX25_TGCR_POWERMODE_MASK	(3 << 8)
#define MX25_TGCR_POWERMODE_SAVE	(1 << 8)
#define MX25_TGCR_POWERMODE_ON		(2 << 8)

[...]
> +#define MX25_ADCQ_CFG_YPLL_HIGH	0
> +#define MX25_ADCQ_CFG_YPLL_OFF		BIT(12)
> +#define MX25_ADCQ_CFG_YPLL_LOW		(3 << 12)
>
dto.

> +#define MX25_ADCQ_CFG_XNUR_HIGH	0
> +#define MX25_ADCQ_CFG_XNUR_OFF		BIT(10)
> +#define MX25_ADCQ_CFG_XNUR_LOW		(3 << 10)
>
dto.

> +#define MX25_ADCQ_CFG_XPUL_OFF		BIT(9)
> +#define MX25_ADCQ_CFG_XPUL_HIGH	0
>
|#define MX25_ADCQ_CFG_XPUL_OFF		(1 << 9)
|#define MX25_ADCQ_CFG_XPUL_HIGH	(0 << 9)
would make it more clear, that these refer to the two states of the same
bit.

> +#define MX25_ADCQ_CFG_REFP(sel)		(sel << 7)
>
missing () around macro argument

> +#define MX25_ADCQ_CFG_REFP_YP		0
> +#define MX25_ADCQ_CFG_REFP_XP		(1 << 7)
> +#define MX25_ADCQ_CFG_REFP_EXT		(2 << 7)
> +#define MX25_ADCQ_CFG_REFP_INT		(3 << 7)
> +#define MX25_ADCQ_CFG_REFP_MASK		(3 << 7)
>
see my previous comment.

> +#define MX25_ADCQ_CFG_IN(sel)		(sel << 4)
>
missing () around macro argument

> +#define MX25_ADCQ_CFG_IN_XP		0
> +#define MX25_ADCQ_CFG_IN_YP		(1 << 4)
> +#define MX25_ADCQ_CFG_IN_XN		(2 << 4)
> +#define MX25_ADCQ_CFG_IN_YN		(3 << 4)
>
see my previous comment.

> +#define MX25_ADCQ_CFG_IN_WIPER		(4 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX0		(5 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX1		(6 << 4)
> +#define MX25_ADCQ_CFG_IN_AUX2		(7 << 4)
> +#define MX25_ADCQ_CFG_REFN(sel)		(sel << 2)
>
missing () around macro argument

> +#define MX25_ADCQ_CFG_REFN_XN		0
> +#define MX25_ADCQ_CFG_REFN_YN		(1 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND		(2 << 2)
> +#define MX25_ADCQ_CFG_REFN_NGND2	(3 << 2)
> +#define MX25_ADCQ_CFG_REFN_MASK		(3 << 2)
>
see my previous comment.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
