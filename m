From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Sep 2011 17:02:22 -0500
Subject: [PATCH 1/5] ARM: pxa: remove redundant macro on GPIO
In-Reply-To: <1317309546-19682-1-git-send-email-haojian.zhuang@marvell.com>
References: <2011092901>
	<1317309546-19682-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110929220222.GF10886@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 11:19:02PM +0800, Haojian Zhuang wrote:
> Both GPLRx and GPLR(x) are provided. GPLRx means register GPLR0/1/...
> GPLR(x) means register GPLR0/1/... and x ranges from 0 to the maximum
> bit number.
> 
> Remove GPLRx since it's redundant.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/mach-pxa/corgi_pm.c          |    5 ++-
>  arch/arm/mach-pxa/include/mach/gpio.h |   60 ++++----------------------------
>  arch/arm/mach-pxa/irq.c               |   17 +++++----
>  arch/arm/mach-pxa/spitz_pm.c          |    3 +-
>  4 files changed, 22 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
> index 2903477..1a7a4c0 100644
> --- a/arch/arm/mach-pxa/corgi_pm.c
> +++ b/arch/arm/mach-pxa/corgi_pm.c
> @@ -90,7 +90,7 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
>  {
>  	int is_resume = 0;
>  
> -	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", GPLR0, PEDR);
> +	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", GPLR(0), PEDR);
>  
>  	if ((PEDR & GPIO_bit(CORGI_GPIO_AC_IN))) {
>  		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
> @@ -124,7 +124,8 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
>  
>  static unsigned long corgi_charger_wakeup(void)
>  {
> -	return ~GPLR0 & ( GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );
> +	return ~GPLR(CORGI_GPIO_AC_IN) & ( GPIO_bit(CORGI_GPIO_AC_IN)
> +		| GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );
>  }
>  
>  unsigned long corgipm_read_devdata(int type)
> diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
> index c463950..1b77c11 100644
> --- a/arch/arm/mach-pxa/include/mach/gpio.h
> +++ b/arch/arm/mach-pxa/include/mach/gpio.h
> @@ -33,69 +33,25 @@
>  #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
>  #define GPIO_REG(x)	(*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
>  
> -/* GPIO Pin Level Registers */
> -#define GPLR0		GPIO_REG(BANK_OFF(0) + 0x00)
> -#define GPLR1		GPIO_REG(BANK_OFF(1) + 0x00)
> -#define GPLR2		GPIO_REG(BANK_OFF(2) + 0x00)
> -#define GPLR3		GPIO_REG(BANK_OFF(3) + 0x00)
> -
> -/* GPIO Pin Direction Registers */
> -#define GPDR0		GPIO_REG(BANK_OFF(0) + 0x0c)
> -#define GPDR1		GPIO_REG(BANK_OFF(1) + 0x0c)
> -#define GPDR2		GPIO_REG(BANK_OFF(2) + 0x0c)
> -#define GPDR3		GPIO_REG(BANK_OFF(3) + 0x0c)
> -
> -/* GPIO Pin Output Set Registers */
> -#define GPSR0		GPIO_REG(BANK_OFF(0) + 0x18)
> -#define GPSR1		GPIO_REG(BANK_OFF(1) + 0x18)
> -#define GPSR2		GPIO_REG(BANK_OFF(2) + 0x18)
> -#define GPSR3		GPIO_REG(BANK_OFF(3) + 0x18)
> -
> -/* GPIO Pin Output Clear Registers */
> -#define GPCR0		GPIO_REG(BANK_OFF(0) + 0x24)
> -#define GPCR1		GPIO_REG(BANK_OFF(1) + 0x24)
> -#define GPCR2		GPIO_REG(BANK_OFF(2) + 0x24)
> -#define GPCR3		GPIO_REG(BANK_OFF(3) + 0x24)
> -
> -/* GPIO Rising Edge Detect Registers */
> -#define GRER0		GPIO_REG(BANK_OFF(0) + 0x30)
> -#define GRER1		GPIO_REG(BANK_OFF(1) + 0x30)
> -#define GRER2		GPIO_REG(BANK_OFF(2) + 0x30)
> -#define GRER3		GPIO_REG(BANK_OFF(3) + 0x30)
> -
> -/* GPIO Falling Edge Detect Registers */
> -#define GFER0		GPIO_REG(BANK_OFF(0) + 0x3c)
> -#define GFER1		GPIO_REG(BANK_OFF(1) + 0x3c)
> -#define GFER2		GPIO_REG(BANK_OFF(2) + 0x3c)
> -#define GFER3		GPIO_REG(BANK_OFF(3) + 0x3c)
> -
> -/* GPIO Edge Detect Status Registers */
> -#define GEDR0		GPIO_REG(BANK_OFF(0) + 0x48)
> -#define GEDR1		GPIO_REG(BANK_OFF(1) + 0x48)
> -#define GEDR2		GPIO_REG(BANK_OFF(2) + 0x48)
> -#define GEDR3		GPIO_REG(BANK_OFF(3) + 0x48)
> -
> -/* GPIO Alternate Function Select Registers */
> -#define GAFR0_L		GPIO_REG(0x0054)
> -#define GAFR0_U		GPIO_REG(0x0058)
> -#define GAFR1_L		GPIO_REG(0x005C)
> -#define GAFR1_U		GPIO_REG(0x0060)
> -#define GAFR2_L		GPIO_REG(0x0064)
> -#define GAFR2_U		GPIO_REG(0x0068)
> -#define GAFR3_L		GPIO_REG(0x006C)
> -#define GAFR3_U		GPIO_REG(0x0070)
> -
>  /* More handy macros.  The argument is a literal GPIO number. */
>  
>  #define GPIO_bit(x)	(1 << ((x) & 0x1f))
>  
> +/* GPIO Pin Level Registers */
>  #define GPLR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x00)
> +/* GPIO Pin Direction Registers */
>  #define GPDR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x0c)
> +/* GPIO Pin Output Set Registers */
>  #define GPSR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x18)
> +/* GPIO Pin Output Clear Registers */
>  #define GPCR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x24)
> +/* GPIO Rising Edge Detect Registers */
>  #define GRER(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x30)
> +/* GPIO Falling Edge Detect Registers */
>  #define GFER(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x3c)
> +/* GPIO Edge Detect Status Registers */
>  #define GEDR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x48)
> +/* GPIO Alternate Function Select Registers */
>  #define GAFR(x)		GPIO_REG(0x54 + (((x) & 0x70) >> 2))
>  
>  
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index dafb4bf..b569e70 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -103,21 +103,22 @@ static int pxa_set_low_gpio_type(struct irq_data *d, unsigned int type)
>  	}
>  
>  	if (type & IRQ_TYPE_EDGE_RISING)
> -		GRER0 |= GPIO_bit(gpio);
> +		GRER(gpio) |= GPIO_bit(gpio);
>  	else
> -		GRER0 &= ~GPIO_bit(gpio);
> +		GRER(gpio) &= ~GPIO_bit(gpio);
>  
>  	if (type & IRQ_TYPE_EDGE_FALLING)
> -		GFER0 |= GPIO_bit(gpio);
> +		GFER(gpio) |= GPIO_bit(gpio);
>  	else
> -		GFER0 &= ~GPIO_bit(gpio);
> +		GFER(gpio) &= ~GPIO_bit(gpio);
>  
>  	return 0;
>  }
>  
>  static void pxa_ack_low_gpio(struct irq_data *d)
>  {
> -	GEDR0 = (1 << (d->irq - IRQ_GPIO0));
> +	int gpio = d->irq - IRQ_GPIO0;
> +	GEDR(gpio) = 1 << gpio;
>  }
>  
>  static struct irq_chip pxa_low_gpio_chip = {
> @@ -163,9 +164,9 @@ static void __init pxa_init_low_gpio_irq(set_wake_t fn)
>  	int irq;
>  
>  	/* clear edge detection on GPIO 0 and 1 */
> -	GFER0 &= ~0x3;
> -	GRER0 &= ~0x3;
> -	GEDR0 = 0x3;
> +	GFER(0) &= ~0x3;
> +	GRER(0) &= ~0x3;
> +	GEDR(0) = 0x3;
>  
>  	for (irq = IRQ_GPIO0; irq <= IRQ_GPIO1; irq++) {
>  		irq_set_chip_and_handler(irq, &pxa_low_gpio_chip,
> diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
> index 094279a..d5295b7 100644
> --- a/arch/arm/mach-pxa/spitz_pm.c
> +++ b/arch/arm/mach-pxa/spitz_pm.c
> @@ -169,7 +169,8 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
>  
>  static unsigned long spitz_charger_wakeup(void)
>  {
> -	return (~GPLR0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (GPLR0 & GPIO_bit(SPITZ_GPIO_SYNC));
> +	return (~GPLR(SPITZ_GPIO_KEY_INT) & GPIO_bit(SPITZ_GPIO_KEY_INT))
> +		| (GPLR(SPITZ_GPIO_SYNC) & GPIO_bit(SPITZ_GPIO_SYNC));
>  }
>  
>  unsigned long spitzpm_read_devdata(int type)
> -- 
> 1.7.2.5
> 
