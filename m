From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 03 Dec 2010 20:56:03 +0900
Subject: [PATCH 40/54] ARM: Samsung SoCs: irq_data conversion.
In-Reply-To: <20101130134112.GO15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134112.GO15575@mail.wantstofly.org>
Message-ID: <015801cb92e1$117861b0$34692510$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lennert Buytenhek wrote:
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
>  arch/arm/mach-s3c2410/bast-irq.c         |   22 ++--
>  arch/arm/mach-s3c2412/irq.c              |   50 +++++-----
>  arch/arm/mach-s3c2416/irq.c              |   72 +++++++-------
>  arch/arm/mach-s3c2440/irq.c              |   18 ++--
>  arch/arm/mach-s3c2440/s3c244x-irq.c      |   18 ++--
>  arch/arm/mach-s3c2443/irq.c              |   90 ++++++++--------
>  arch/arm/mach-s3c64xx/irq-eint.c         |   34 +++---
>  arch/arm/mach-s5pv310/irq-combiner.c     |   26 +++--
>  arch/arm/mach-s5pv310/irq-eint.c         |   55 +++++-----
>  arch/arm/plat-s3c24xx/include/plat/irq.h |    4 +-
>  arch/arm/plat-s3c24xx/irq-pm.c           |    9 +-
>  arch/arm/plat-s3c24xx/irq.c              |  170
+++++++++++++++-------------
> --
>  arch/arm/plat-s5p/irq-eint.c             |   84 ++++++++--------
>  arch/arm/plat-s5p/irq-gpioint.c          |   50 +++++-----
>  arch/arm/plat-s5p/irq-pm.c               |    6 +-
>  arch/arm/plat-samsung/include/plat/pm.h  |    4 +-
>  arch/arm/plat-samsung/irq-uart.c         |   44 ++++----
>  arch/arm/plat-samsung/irq-vic-timer.c    |   22 ++--
>  arch/arm/plat-samsung/pm.c               |    7 +-
>  19 files changed, 396 insertions(+), 389 deletions(-)

Hi Lennert,

(Added Mark Brown in Cc)

Looks ok to me but there are some comments.

Firstly, how about to separate this to regarding S3C24XX(mach-s3c24xx and
plat-s3c24xx), S5P(mach-s5pxxxx and plat-s5p) and plat-samsung?
(Actually, already applied S3C64XX changes so that we can drop that in your
patch.)

As you know, I already applied some changes which is from Mark Brown in my
tree.
You can find that in
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
#for-next

So could you please re-work this based on that?

> 
> diff --git a/arch/arm/mach-s3c2410/bast-irq.c
b/arch/arm/mach-s3c2410/bast-
> irq.c
> index 217b102..a22a8a0 100644
> --- a/arch/arm/mach-s3c2410/bast-irq.c
> +++ b/arch/arm/mach-s3c2410/bast-irq.c
> @@ -75,38 +75,38 @@ static unsigned char bast_pc104_irqmasks[] = {
>  static unsigned char bast_pc104_irqs[] = { 3, 5, 7, 10 };
> 
>  static void
> -bast_pc104_mask(unsigned int irqno)
> +bast_pc104_mask(struct irq_data *d)
>  {
>  	unsigned long temp;
> 
>  	temp = __raw_readb(BAST_VA_PC104_IRQMASK);
> -	temp &= ~bast_pc104_irqmasks[irqno];
> +	temp &= ~bast_pc104_irqmasks[d->irq];
>  	__raw_writeb(temp, BAST_VA_PC104_IRQMASK);
>  }
> 
>  static void
> -bast_pc104_maskack(unsigned int irqno)
> +bast_pc104_maskack(struct irq_data *d)
>  {
>  	struct irq_desc *desc = irq_desc + IRQ_ISA;
> 
> -	bast_pc104_mask(irqno);
> -	desc->chip->ack(IRQ_ISA);
> +	bast_pc104_mask(d);
> +	desc->irq_data.chip->irq_ack(&desc->irq_data);
>  }
> 
>  static void
> -bast_pc104_unmask(unsigned int irqno)
> +bast_pc104_unmask(struct irq_data *d)
>  {
>  	unsigned long temp;
> 
>  	temp = __raw_readb(BAST_VA_PC104_IRQMASK);
> -	temp |= bast_pc104_irqmasks[irqno];
> +	temp |= bast_pc104_irqmasks[d->irq];
>  	__raw_writeb(temp, BAST_VA_PC104_IRQMASK);
>  }
> 
>  static struct irq_chip  bast_pc104_chip = {
> -	.mask	     = bast_pc104_mask,
> -	.unmask	     = bast_pc104_unmask,
> -	.ack	     = bast_pc104_maskack
> +	.irq_mask	= bast_pc104_mask,
> +	.irq_unmask     = bast_pc104_unmask,
                   ^^^^
Tab is better instead of white space.

> +	.irq_ack	= bast_pc104_maskack
>  };
> 
>  static void
> @@ -123,7 +123,7 @@ bast_irq_pc104_demux(unsigned int irq,
>  		/* ack if we get an irq with nothing (ie, startup) */
> 
>  		desc = irq_desc + IRQ_ISA;
> -		desc->chip->ack(IRQ_ISA);
> +		desc->irq_data.chip->irq_ack(&desc->irq_data);
>  	} else {
>  		/* handle the IRQ */
> 
> diff --git a/arch/arm/mach-s3c2412/irq.c b/arch/arm/mach-s3c2412/irq.c
> index 6000ca9..b8b86c3 100644
> --- a/arch/arm/mach-s3c2412/irq.c
> +++ b/arch/arm/mach-s3c2412/irq.c
> @@ -49,9 +49,9 @@
>  */
> 
>  static void
> -s3c2412_irq_mask(unsigned int irqno)
> +s3c2412_irq_mask(struct irq_data *d)
>  {
> -	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
> +	unsigned long bitval = 1UL << (d->irq - IRQ_EINT0);
>  	unsigned long mask;
> 
>  	mask = __raw_readl(S3C2410_INTMSK);
> @@ -62,9 +62,9 @@ s3c2412_irq_mask(unsigned int irqno)
>  }
> 
>  static inline void
> -s3c2412_irq_ack(unsigned int irqno)
> +s3c2412_irq_ack(struct irq_data *d)
>  {
> -	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
> +	unsigned long bitval = 1UL << (d->irq - IRQ_EINT0);
> 
>  	__raw_writel(bitval, S3C2412_EINTPEND);
>  	__raw_writel(bitval, S3C2410_SRCPND);
> @@ -72,9 +72,9 @@ s3c2412_irq_ack(unsigned int irqno)
>  }
> 
>  static inline void
> -s3c2412_irq_maskack(unsigned int irqno)
> +s3c2412_irq_maskack(struct irq_data *d)
>  {
> -	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
> +	unsigned long bitval = 1UL << (d->irq - IRQ_EINT0);
>  	unsigned long mask;
> 
>  	mask = __raw_readl(S3C2410_INTMSK);
> @@ -89,9 +89,9 @@ s3c2412_irq_maskack(unsigned int irqno)
>  }
> 
>  static void
> -s3c2412_irq_unmask(unsigned int irqno)
> +s3c2412_irq_unmask(struct irq_data *d)
>  {
> -	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
> +	unsigned long bitval = 1UL << (d->irq - IRQ_EINT0);
>  	unsigned long mask;
> 
>  	mask = __raw_readl(S3C2412_EINTMASK);
> @@ -102,11 +102,11 @@ s3c2412_irq_unmask(unsigned int irqno)
>  }
> 
>  static struct irq_chip s3c2412_irq_eint0t4 = {
> -	.ack	   = s3c2412_irq_ack,
> -	.mask	   = s3c2412_irq_mask,
> -	.unmask	   = s3c2412_irq_unmask,
> -	.set_wake  = s3c_irq_wake,
> -	.set_type  = s3c_irqext_type,
> +	.irq_ack	= s3c2412_irq_ack,
> +	.irq_mask	= s3c2412_irq_mask,
> +	.irq_unmask	= s3c2412_irq_unmask,
> +	.irq_set_wake   = s3c_irq_wake,
                    ^^^
Same.

> +	.irq_set_type   = s3c_irqext_type,
                     ^^^
Same.

>  };
> 
>  #define INTBIT(x)	(1 << ((x) - S3C2410_IRQSUB(0)))
> @@ -132,29 +132,29 @@ static void s3c2412_irq_demux_cfsdi(unsigned int
irq,
> struct irq_desc *desc)
>  #define INTMSK_CFSDI	(1UL << (IRQ_S3C2412_CFSDI - IRQ_EINT0))
>  #define SUBMSK_CFSDI	INTMSK_SUB(IRQ_S3C2412_SDI, IRQ_S3C2412_CF)
> 
> -static void s3c2412_irq_cfsdi_mask(unsigned int irqno)
> +static void s3c2412_irq_cfsdi_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_CFSDI, SUBMSK_CFSDI);
> +	s3c_irqsub_mask(d->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
>  }
> 
> -static void s3c2412_irq_cfsdi_unmask(unsigned int irqno)
> +static void s3c2412_irq_cfsdi_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_CFSDI);
> +	s3c_irqsub_unmask(d->irq, INTMSK_CFSDI);
>  }
> 
> -static void s3c2412_irq_cfsdi_ack(unsigned int irqno)
> +static void s3c2412_irq_cfsdi_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_CFSDI, SUBMSK_CFSDI);
> +	s3c_irqsub_maskack(d->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
>  }
> 
>  static struct irq_chip s3c2412_irq_cfsdi = {
>  	.name		= "s3c2412-cfsdi",
> -	.ack		= s3c2412_irq_cfsdi_ack,
> -	.mask		= s3c2412_irq_cfsdi_mask,
> -	.unmask		= s3c2412_irq_cfsdi_unmask,
> +	.irq_ack	= s3c2412_irq_cfsdi_ack,
> +	.irq_mask	= s3c2412_irq_cfsdi_mask,
> +	.irq_unmask	= s3c2412_irq_cfsdi_unmask,
>  };
> 
> -static int s3c2412_irq_rtc_wake(unsigned int irqno, unsigned int state)
> +static int s3c2412_irq_rtc_wake(struct irq_data *d, unsigned int state)
>  {
>  	unsigned long pwrcfg;
> 
> @@ -165,7 +165,7 @@ static int s3c2412_irq_rtc_wake(unsigned int irqno,
> unsigned int state)
>  		pwrcfg |= S3C2412_PWRCFG_RTC_MASKIRQ;
>  	__raw_writel(pwrcfg, S3C2412_PWRCFG);
> 
> -	return s3c_irq_chip.set_wake(irqno, state);
> +	return s3c_irq_chip.irq_set_wake(d, state);
>  }
> 
>  static struct irq_chip s3c2412_irq_rtc_chip;
> @@ -193,7 +193,7 @@ static int s3c2412_irq_add(struct sys_device *sysdev)
>  	/* change RTC IRQ's set wake method */
> 
>  	s3c2412_irq_rtc_chip = s3c_irq_chip;
> -	s3c2412_irq_rtc_chip.set_wake = s3c2412_irq_rtc_wake;
> +	s3c2412_irq_rtc_chip.irq_set_wake = s3c2412_irq_rtc_wake;
> 
>  	set_irq_chip(IRQ_RTC, &s3c2412_irq_rtc_chip);
> 
> diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
> index 00174da..6268d2c 100644
> --- a/arch/arm/mach-s3c2416/irq.c
> +++ b/arch/arm/mach-s3c2416/irq.c
> @@ -77,25 +77,25 @@ static void s3c2416_irq_demux_wdtac97(unsigned int
irq,
> struct irq_desc *desc)
>  #define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
>  #define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
> 
> -static void s3c2416_irq_wdtac97_mask(unsigned int irqno)
> +static void s3c2416_irq_wdtac97_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
> +	s3c_irqsub_mask(d->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
>  }
> 
> -static void s3c2416_irq_wdtac97_unmask(unsigned int irqno)
> +static void s3c2416_irq_wdtac97_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_WDTAC97);
> +	s3c_irqsub_unmask(d->irq, INTMSK_WDTAC97);
>  }
> 
> -static void s3c2416_irq_wdtac97_ack(unsigned int irqno)
> +static void s3c2416_irq_wdtac97_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
> +	s3c_irqsub_maskack(d->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
>  }
> 
>  static struct irq_chip s3c2416_irq_wdtac97 = {
> -	.mask	    = s3c2416_irq_wdtac97_mask,
> -	.unmask	    = s3c2416_irq_wdtac97_unmask,
> -	.ack	    = s3c2416_irq_wdtac97_ack,
> +	.irq_mask	= s3c2416_irq_wdtac97_mask,
> +	.irq_unmask	= s3c2416_irq_wdtac97_unmask,
> +	.irq_ack	= s3c2416_irq_wdtac97_ack,
>  };
> 
> 
> @@ -109,25 +109,25 @@ static void s3c2416_irq_demux_lcd(unsigned int irq,
> struct irq_desc *desc)
>  #define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
>  #define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
> 
> -static void s3c2416_irq_lcd_mask(unsigned int irqno)
> +static void s3c2416_irq_lcd_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_LCD, SUBMSK_LCD);
> +	s3c_irqsub_mask(d->irq, INTMSK_LCD, SUBMSK_LCD);
>  }
> 
> -static void s3c2416_irq_lcd_unmask(unsigned int irqno)
> +static void s3c2416_irq_lcd_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_LCD);
> +	s3c_irqsub_unmask(d->irq, INTMSK_LCD);
>  }
> 
> -static void s3c2416_irq_lcd_ack(unsigned int irqno)
> +static void s3c2416_irq_lcd_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_LCD, SUBMSK_LCD);
> +	s3c_irqsub_maskack(d->irq, INTMSK_LCD, SUBMSK_LCD);
>  }
> 
>  static struct irq_chip s3c2416_irq_lcd = {
> -	.mask	    = s3c2416_irq_lcd_mask,
> -	.unmask	    = s3c2416_irq_lcd_unmask,
> -	.ack	    = s3c2416_irq_lcd_ack,
> +	.irq_mask	= s3c2416_irq_lcd_mask,
> +	.irq_unmask	= s3c2416_irq_lcd_unmask,
> +	.irq_ack	= s3c2416_irq_lcd_ack,
>  };
> 
> 
> @@ -142,25 +142,25 @@ static void s3c2416_irq_demux_dma(unsigned int irq,
> struct irq_desc *desc)
>  #define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
> 
> 

If possible, please remove useless empty line.
As you know, just one empty line is enough :-)

> -static void s3c2416_irq_dma_mask(unsigned int irqno)
> +static void s3c2416_irq_dma_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_DMA, SUBMSK_DMA);
> +	s3c_irqsub_mask(d->irq, INTMSK_DMA, SUBMSK_DMA);
>  }
> 
> -static void s3c2416_irq_dma_unmask(unsigned int irqno)
> +static void s3c2416_irq_dma_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_DMA);
> +	s3c_irqsub_unmask(d->irq, INTMSK_DMA);
>  }
> 
> -static void s3c2416_irq_dma_ack(unsigned int irqno)
> +static void s3c2416_irq_dma_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_DMA, SUBMSK_DMA);
> +	s3c_irqsub_maskack(d->irq, INTMSK_DMA, SUBMSK_DMA);
>  }
> 
>  static struct irq_chip s3c2416_irq_dma = {
> -	.mask	    = s3c2416_irq_dma_mask,
> -	.unmask	    = s3c2416_irq_dma_unmask,
> -	.ack	    = s3c2416_irq_dma_ack,
> +	.irq_mask	= s3c2416_irq_dma_mask,
> +	.irq_unmask	= s3c2416_irq_dma_unmask,
> +	.irq_ack	= s3c2416_irq_dma_ack,
>  };
> 
> 

Same.

> @@ -174,25 +174,25 @@ static void s3c2416_irq_demux_uart3(unsigned int
irq,
> struct irq_desc *desc)
>  #define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
>  #define SUBMSK_UART3	(0x7 << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
> 
> -static void s3c2416_irq_uart3_mask(unsigned int irqno)
> +static void s3c2416_irq_uart3_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_UART3, SUBMSK_UART3);
> +	s3c_irqsub_mask(d->irq, INTMSK_UART3, SUBMSK_UART3);
>  }
> 
> -static void s3c2416_irq_uart3_unmask(unsigned int irqno)
> +static void s3c2416_irq_uart3_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_UART3);
> +	s3c_irqsub_unmask(d->irq, INTMSK_UART3);
>  }
> 
> -static void s3c2416_irq_uart3_ack(unsigned int irqno)
> +static void s3c2416_irq_uart3_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_UART3, SUBMSK_UART3);
> +	s3c_irqsub_maskack(d->irq, INTMSK_UART3, SUBMSK_UART3);
>  }
> 
>  static struct irq_chip s3c2416_irq_uart3 = {
> -	.mask	    = s3c2416_irq_uart3_mask,
> -	.unmask	    = s3c2416_irq_uart3_unmask,
> -	.ack	    = s3c2416_irq_uart3_ack,
> +	.irq_mask	= s3c2416_irq_uart3_mask,
> +	.irq_unmask	= s3c2416_irq_uart3_unmask,
> +	.irq_ack	= s3c2416_irq_uart3_ack,
>  };
> 
> 

Same.

> diff --git a/arch/arm/mach-s3c2440/irq.c b/arch/arm/mach-s3c2440/irq.c
> index 0c049b9..9af46d5 100644
> --- a/arch/arm/mach-s3c2440/irq.c
> +++ b/arch/arm/mach-s3c2440/irq.c
> @@ -69,27 +69,27 @@ static void s3c_irq_demux_wdtac97(unsigned int irq,
>  #define INTMSK_WDT	 (1UL << (IRQ_WDT - IRQ_EINT0))
> 
>  static void
> -s3c_irq_wdtac97_mask(unsigned int irqno)
> +s3c_irq_wdtac97_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_WDT, 3<<13);
> +	s3c_irqsub_mask(d->irq, INTMSK_WDT, 3<<13);
>  }
> 
>  static void
> -s3c_irq_wdtac97_unmask(unsigned int irqno)
> +s3c_irq_wdtac97_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_WDT);
> +	s3c_irqsub_unmask(d->irq, INTMSK_WDT);
>  }
> 
>  static void
> -s3c_irq_wdtac97_ack(unsigned int irqno)
> +s3c_irq_wdtac97_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_WDT, 3<<13);
> +	s3c_irqsub_maskack(d->irq, INTMSK_WDT, 3<<13);
>  }
> 
>  static struct irq_chip s3c_irq_wdtac97 = {
> -	.mask	    = s3c_irq_wdtac97_mask,
> -	.unmask	    = s3c_irq_wdtac97_unmask,
> -	.ack	    = s3c_irq_wdtac97_ack,
> +	.irq_mask	= s3c_irq_wdtac97_mask,
> +	.irq_unmask	= s3c_irq_wdtac97_unmask,
> +	.irq_ack	= s3c_irq_wdtac97_ack,
>  };
> 
>  static int s3c2440_irq_add(struct sys_device *sysdev)
> diff --git a/arch/arm/mach-s3c2440/s3c244x-irq.c b/arch/arm/mach-
> s3c2440/s3c244x-irq.c
> index a75c0c2..3878c0a 100644
> --- a/arch/arm/mach-s3c2440/s3c244x-irq.c
> +++ b/arch/arm/mach-s3c2440/s3c244x-irq.c
> @@ -68,27 +68,27 @@ static void s3c_irq_demux_cam(unsigned int irq,
>  #define INTMSK_CAM (1UL << (IRQ_CAM - IRQ_EINT0))
> 
>  static void
> -s3c_irq_cam_mask(unsigned int irqno)
> +s3c_irq_cam_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_CAM, 3<<11);
> +	s3c_irqsub_mask(d->irq, INTMSK_CAM, 3<<11);

3 << 11
Need to add blank around "<<"

>  }
> 
>  static void
> -s3c_irq_cam_unmask(unsigned int irqno)
> +s3c_irq_cam_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_CAM);
> +	s3c_irqsub_unmask(d->irq, INTMSK_CAM);
>  }
> 
>  static void
> -s3c_irq_cam_ack(unsigned int irqno)
> +s3c_irq_cam_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_CAM, 3<<11);
> +	s3c_irqsub_maskack(d->irq, INTMSK_CAM, 3<<11);
>  }
> 
>  static struct irq_chip s3c_irq_cam = {
> -	.mask	    = s3c_irq_cam_mask,
> -	.unmask	    = s3c_irq_cam_unmask,
> -	.ack	    = s3c_irq_cam_ack,
> +	.irq_mask	= s3c_irq_cam_mask,
> +	.irq_unmask	= s3c_irq_cam_unmask,
> +	.irq_ack	= s3c_irq_cam_ack,
>  };
> 
>  static int s3c244x_irq_add(struct sys_device *sysdev)
> diff --git a/arch/arm/mach-s3c2443/irq.c b/arch/arm/mach-s3c2443/irq.c
> index 8934247..74b49f4 100644
> --- a/arch/arm/mach-s3c2443/irq.c
> +++ b/arch/arm/mach-s3c2443/irq.c
> @@ -75,25 +75,25 @@ static void s3c2443_irq_demux_wdtac97(unsigned int
irq,
> struct irq_desc *desc)
>  #define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
>  #define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
> 
> -static void s3c2443_irq_wdtac97_mask(unsigned int irqno)
> +static void s3c2443_irq_wdtac97_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
> +	s3c_irqsub_mask(d->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
>  }
> 
> -static void s3c2443_irq_wdtac97_unmask(unsigned int irqno)
> +static void s3c2443_irq_wdtac97_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_WDTAC97);
> +	s3c_irqsub_unmask(d->irq, INTMSK_WDTAC97);
>  }
> 
> -static void s3c2443_irq_wdtac97_ack(unsigned int irqno)
> +static void s3c2443_irq_wdtac97_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
> +	s3c_irqsub_maskack(d->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
>  }
> 
>  static struct irq_chip s3c2443_irq_wdtac97 = {
> -	.mask	    = s3c2443_irq_wdtac97_mask,
> -	.unmask	    = s3c2443_irq_wdtac97_unmask,
> -	.ack	    = s3c2443_irq_wdtac97_ack,
> +	.irq_mask	= s3c2443_irq_wdtac97_mask,
> +	.irq_unmask	= s3c2443_irq_wdtac97_unmask,
> +	.irq_ack	= s3c2443_irq_wdtac97_ack,
>  };
> 
> 

Same.

> @@ -107,25 +107,25 @@ static void s3c2443_irq_demux_lcd(unsigned int irq,
> struct irq_desc *desc)
>  #define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
>  #define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
> 
> -static void s3c2443_irq_lcd_mask(unsigned int irqno)
> +static void s3c2443_irq_lcd_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_LCD, SUBMSK_LCD);
> +	s3c_irqsub_mask(d->irq, INTMSK_LCD, SUBMSK_LCD);
>  }
> 
> -static void s3c2443_irq_lcd_unmask(unsigned int irqno)
> +static void s3c2443_irq_lcd_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_LCD);
> +	s3c_irqsub_unmask(d->irq, INTMSK_LCD);
>  }
> 
> -static void s3c2443_irq_lcd_ack(unsigned int irqno)
> +static void s3c2443_irq_lcd_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_LCD, SUBMSK_LCD);
> +	s3c_irqsub_maskack(d->irq, INTMSK_LCD, SUBMSK_LCD);
>  }
> 
>  static struct irq_chip s3c2443_irq_lcd = {
> -	.mask	    = s3c2443_irq_lcd_mask,
> -	.unmask	    = s3c2443_irq_lcd_unmask,
> -	.ack	    = s3c2443_irq_lcd_ack,
> +	.irq_mask	= s3c2443_irq_lcd_mask,
> +	.irq_unmask	= s3c2443_irq_lcd_unmask,
> +	.irq_ack	= s3c2443_irq_lcd_ack,
>  };
> 
> 

Same...please remove useless empty line.

> @@ -140,25 +140,25 @@ static void s3c2443_irq_demux_dma(unsigned int irq,
> struct irq_desc *desc)
>  #define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
> 
> 
> -static void s3c2443_irq_dma_mask(unsigned int irqno)
> +static void s3c2443_irq_dma_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_DMA, SUBMSK_DMA);
> +	s3c_irqsub_mask(d->irq, INTMSK_DMA, SUBMSK_DMA);
>  }
> 
> -static void s3c2443_irq_dma_unmask(unsigned int irqno)
> +static void s3c2443_irq_dma_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_DMA);
> +	s3c_irqsub_unmask(d->irq, INTMSK_DMA);
>  }
> 
> -static void s3c2443_irq_dma_ack(unsigned int irqno)
> +static void s3c2443_irq_dma_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_DMA, SUBMSK_DMA);
> +	s3c_irqsub_maskack(d->irq, INTMSK_DMA, SUBMSK_DMA);
>  }
> 
>  static struct irq_chip s3c2443_irq_dma = {
> -	.mask	    = s3c2443_irq_dma_mask,
> -	.unmask	    = s3c2443_irq_dma_unmask,
> -	.ack	    = s3c2443_irq_dma_ack,
> +	.irq_mask	= s3c2443_irq_dma_mask,
> +	.irq_unmask	= s3c2443_irq_dma_unmask,
> +	.irq_ack	= s3c2443_irq_dma_ack,
>  };
> 
> 

Same.

> @@ -172,25 +172,25 @@ static void s3c2443_irq_demux_uart3(unsigned int
irq,
> struct irq_desc *desc)
>  #define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
>  #define SUBMSK_UART3	(0x7 << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
> 
> -static void s3c2443_irq_uart3_mask(unsigned int irqno)
> +static void s3c2443_irq_uart3_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_UART3, SUBMSK_UART3);
> +	s3c_irqsub_mask(d->irq, INTMSK_UART3, SUBMSK_UART3);
>  }
> 
> -static void s3c2443_irq_uart3_unmask(unsigned int irqno)
> +static void s3c2443_irq_uart3_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_UART3);
> +	s3c_irqsub_unmask(d->irq, INTMSK_UART3);
>  }
> 
> -static void s3c2443_irq_uart3_ack(unsigned int irqno)
> +static void s3c2443_irq_uart3_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_UART3, SUBMSK_UART3);
> +	s3c_irqsub_maskack(d->irq, INTMSK_UART3, SUBMSK_UART3);
>  }
> 
>  static struct irq_chip s3c2443_irq_uart3 = {
> -	.mask	    = s3c2443_irq_uart3_mask,
> -	.unmask	    = s3c2443_irq_uart3_unmask,
> -	.ack	    = s3c2443_irq_uart3_ack,
> +	.irq_mask	= s3c2443_irq_uart3_mask,
> +	.irq_unmask	= s3c2443_irq_uart3_unmask,
> +	.irq_ack	= s3c2443_irq_uart3_ack,
>  };
> 
> 
Same.

> @@ -204,25 +204,25 @@ static void s3c2443_irq_demux_cam(unsigned int irq,
> struct irq_desc *desc)
>  #define INTMSK_CAM	(1UL << (IRQ_CAM - IRQ_EINT0))
>  #define SUBMSK_CAM	INTMSK(IRQ_S3C2440_CAM_C, IRQ_S3C2440_CAM_P)
> 
> -static void s3c2443_irq_cam_mask(unsigned int irqno)
> +static void s3c2443_irq_cam_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_CAM, SUBMSK_CAM);
> +	s3c_irqsub_mask(d->irq, INTMSK_CAM, SUBMSK_CAM);
>  }
> 
> -static void s3c2443_irq_cam_unmask(unsigned int irqno)
> +static void s3c2443_irq_cam_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_CAM);
> +	s3c_irqsub_unmask(d->irq, INTMSK_CAM);
>  }
> 
> -static void s3c2443_irq_cam_ack(unsigned int irqno)
> +static void s3c2443_irq_cam_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_CAM, SUBMSK_CAM);
> +	s3c_irqsub_maskack(d->irq, INTMSK_CAM, SUBMSK_CAM);
>  }
> 
>  static struct irq_chip s3c2443_irq_cam = {
> -	.mask	    = s3c2443_irq_cam_mask,
> -	.unmask	    = s3c2443_irq_cam_unmask,
> -	.ack	    = s3c2443_irq_cam_ack,
> +	.irq_mask	= s3c2443_irq_cam_mask,
> +	.irq_unmask	= s3c2443_irq_cam_unmask,
> +	.irq_ack	= s3c2443_irq_cam_ack,
>  };
> 
>  /* IRQ initialisation code */
> diff --git a/arch/arm/mach-s3c64xx/irq-eint.c b/arch/arm/mach-s3c64xx/irq-
> eint.c
> index 5682d6a..27961d3 100644
> --- a/arch/arm/mach-s3c64xx/irq-eint.c
> +++ b/arch/arm/mach-s3c64xx/irq-eint.c

As you know, already applied this so we can drop this file in your patch.

> @@ -32,39 +32,39 @@
>  #define eint_offset(irq)	((irq) - IRQ_EINT(0))
>  #define eint_irq_to_bit(irq)	(1 << eint_offset(irq))
> 
> -static inline void s3c_irq_eint_mask(unsigned int irq)
> +static inline void s3c_irq_eint_mask(struct irq_data *d)
>  {
>  	u32 mask;
> 
>  	mask = __raw_readl(S3C64XX_EINT0MASK);
> -	mask |= eint_irq_to_bit(irq);
> +	mask |= eint_irq_to_bit(d->irq);
>  	__raw_writel(mask, S3C64XX_EINT0MASK);
>  }
> 
> -static void s3c_irq_eint_unmask(unsigned int irq)
> +static void s3c_irq_eint_unmask(struct irq_data *d)
>  {
>  	u32 mask;
> 
>  	mask = __raw_readl(S3C64XX_EINT0MASK);
> -	mask &= ~eint_irq_to_bit(irq);
> +	mask &= ~eint_irq_to_bit(d->irq);
>  	__raw_writel(mask, S3C64XX_EINT0MASK);
>  }
> 
> -static inline void s3c_irq_eint_ack(unsigned int irq)
> +static inline void s3c_irq_eint_ack(struct irq_data *d)
>  {
> -	__raw_writel(eint_irq_to_bit(irq), S3C64XX_EINT0PEND);
> +	__raw_writel(eint_irq_to_bit(d->irq), S3C64XX_EINT0PEND);
>  }
> 
> -static void s3c_irq_eint_maskack(unsigned int irq)
> +static void s3c_irq_eint_maskack(struct irq_data *d)
>  {
>  	/* compiler should in-line these */
> -	s3c_irq_eint_mask(irq);
> -	s3c_irq_eint_ack(irq);
> +	s3c_irq_eint_mask(d);
> +	s3c_irq_eint_ack(d);
>  }
> 
> -static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
> +static int s3c_irq_eint_set_type(struct irq_data *d, unsigned int type)
>  {
> -	int offs = eint_offset(irq);
> +	int offs = eint_offset(d->irq);
>  	int pin, pin_val;
>  	int shift;
>  	u32 ctrl, mask;
> @@ -140,12 +140,12 @@ static int s3c_irq_eint_set_type(unsigned int irq,
> unsigned int type)
> 
>  static struct irq_chip s3c_irq_eint = {
>  	.name		= "s3c-eint",
> -	.mask		= s3c_irq_eint_mask,
> -	.unmask		= s3c_irq_eint_unmask,
> -	.mask_ack	= s3c_irq_eint_maskack,
> -	.ack		= s3c_irq_eint_ack,
> -	.set_type	= s3c_irq_eint_set_type,
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_mask	= s3c_irq_eint_mask,
> +	.irq_unmask	= s3c_irq_eint_unmask,
> +	.irq_mask_ack	= s3c_irq_eint_maskack,
> +	.irq_ack	= s3c_irq_eint_ack,
> +	.irq_set_type	= s3c_irq_eint_set_type,
> +	.irq_set_wake	= s3c_irqext_wake,
>  };
> 
>  /* s3c_irq_demux_eint
> diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-
> s5pv310/irq-combiner.c
> index c3f88c3..8ef0c38 100644
> --- a/arch/arm/mach-s5pv310/irq-combiner.c
> +++ b/arch/arm/mach-s5pv310/irq-combiner.c
> @@ -29,24 +29,26 @@ struct combiner_chip_data {
> 
>  static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
> 
> -static inline void __iomem *combiner_base(unsigned int irq)
> +static inline void __iomem *combiner_base(struct irq_data *d)
>  {
> -	struct combiner_chip_data *combiner_data = get_irq_chip_data(irq);
> +	struct combiner_chip_data *combiner_data =
> +		irq_data_get_irq_chip_data(d);
> +
>  	return combiner_data->base;
>  }
> 
> -static void combiner_mask_irq(unsigned int irq)
> +static void combiner_mask_irq(struct irq_data *d)
>  {
> -	u32 mask = 1 << (irq % 32);
> +	u32 mask = 1 << (d->irq % 32);
> 
> -	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_CLEAR);
> +	__raw_writel(mask, combiner_base(d) + COMBINER_ENABLE_CLEAR);
>  }
> 
> -static void combiner_unmask_irq(unsigned int irq)
> +static void combiner_unmask_irq(struct irq_data *d)
>  {
> -	u32 mask = 1 << (irq % 32);
> +	u32 mask = 1 << (d->irq % 32);
> 
> -	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_SET);
> +	__raw_writel(mask, combiner_base(d) + COMBINER_ENABLE_SET);
>  }
> 
>  static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc
> *desc)
> @@ -57,7 +59,7 @@ static void combiner_handle_cascade_irq(unsigned int
irq,
> struct irq_desc *desc)
>  	unsigned long status;
> 
>  	/* primary controller ack'ing */
> -	chip->ack(irq);
> +	chip->irq_ack(&desc->irq_data);
> 
>  	spin_lock(&irq_controller_lock);
>  	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
> @@ -76,13 +78,13 @@ static void combiner_handle_cascade_irq(unsigned int
irq,
> struct irq_desc *desc)
> 
>   out:
>  	/* primary controller unmasking */
> -	chip->unmask(irq);
> +	chip->irq_unmask(&desc->irq_data);
>  }
> 
>  static struct irq_chip combiner_chip = {
>  	.name		= "COMBINER",
> -	.mask		= combiner_mask_irq,
> -	.unmask		= combiner_unmask_irq,
> +	.irq_mask	= combiner_mask_irq,
> +	.irq_unmask	= combiner_unmask_irq,
>  };
> 
>  void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int
irq)
> diff --git a/arch/arm/mach-s5pv310/irq-eint.c b/arch/arm/mach-s5pv310/irq-
> eint.c
> index 5877503..ed26db8 100644
> --- a/arch/arm/mach-s5pv310/irq-eint.c
> +++ b/arch/arm/mach-s5pv310/irq-eint.c
> @@ -48,42 +48,43 @@ static unsigned int s5pv310_get_irq_nr(unsigned int
> number)
>  	return ret;
>  }
> 
> -static inline void s5pv310_irq_eint_mask(unsigned int irq)
> +static inline void s5pv310_irq_eint_mask(struct irq_data *d)
>  {
>  	u32 mask;
> 
>  	spin_lock(&eint_lock);
> -	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
> -	mask |= eint_irq_to_bit(irq);
> -	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
> +	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(d->irq)));
> +	mask |= eint_irq_to_bit(d->irq);
> +	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(d->irq)));
>  	spin_unlock(&eint_lock);
>  }
> 
> -static void s5pv310_irq_eint_unmask(unsigned int irq)
> +static void s5pv310_irq_eint_unmask(struct irq_data *d)
>  {
>  	u32 mask;
> 
>  	spin_lock(&eint_lock);
> -	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
> -	mask &= ~(eint_irq_to_bit(irq));
> -	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
> +	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(d->irq)));
> +	mask &= ~(eint_irq_to_bit(d->irq));
> +	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(d->irq)));
>  	spin_unlock(&eint_lock);
>  }
> 
> -static inline void s5pv310_irq_eint_ack(unsigned int irq)
> +static inline void s5pv310_irq_eint_ack(struct irq_data *d)
>  {
> -	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
> +	__raw_writel(eint_irq_to_bit(d->irq),
> +		     S5P_EINT_PEND(EINT_REG_NR(d->irq)));
>  }
> 
> -static void s5pv310_irq_eint_maskack(unsigned int irq)
> +static void s5pv310_irq_eint_maskack(struct irq_data *d)
>  {
> -	s5pv310_irq_eint_mask(irq);
> -	s5pv310_irq_eint_ack(irq);
> +	s5pv310_irq_eint_mask(d);
> +	s5pv310_irq_eint_ack(d);
>  }
> 
> -static int s5pv310_irq_eint_set_type(unsigned int irq, unsigned int type)
> +static int s5pv310_irq_eint_set_type(struct irq_data *d, unsigned int
type)
>  {
> -	int offs = EINT_OFFSET(irq);
> +	int offs = EINT_OFFSET(d->irq);
>  	int shift;
>  	u32 ctrl, mask;
>  	u32 newvalue = 0;
> @@ -118,10 +119,10 @@ static int s5pv310_irq_eint_set_type(unsigned int
irq,
> unsigned int type)
>  	mask = 0x7 << shift;
> 
>  	spin_lock(&eint_lock);
> -	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(irq)));
> +	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(d->irq)));
>  	ctrl &= ~mask;
>  	ctrl |= newvalue << shift;
> -	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(irq)));
> +	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(d->irq)));
>  	spin_unlock(&eint_lock);
> 
>  	switch (offs) {
> @@ -146,13 +147,13 @@ static int s5pv310_irq_eint_set_type(unsigned int
irq,
> unsigned int type)
> 
>  static struct irq_chip s5pv310_irq_eint = {
>  	.name		= "s5pv310-eint",
> -	.mask		= s5pv310_irq_eint_mask,
> -	.unmask		= s5pv310_irq_eint_unmask,
> -	.mask_ack	= s5pv310_irq_eint_maskack,
> -	.ack		= s5pv310_irq_eint_ack,
> -	.set_type	= s5pv310_irq_eint_set_type,
> +	.irq_mask	= s5pv310_irq_eint_mask,
> +	.irq_unmask	= s5pv310_irq_eint_unmask,
> +	.irq_mask_ack	= s5pv310_irq_eint_maskack,
> +	.irq_ack	= s5pv310_irq_eint_ack,
> +	.irq_set_type	= s5pv310_irq_eint_set_type,
>  #ifdef CONFIG_PM
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_set_wake	= s3c_irqext_wake,

Already applied this change.

>  #endif
>  };
> 
> @@ -192,14 +193,14 @@ static void s5pv310_irq_eint0_15(unsigned int irq,
> struct irq_desc *desc)
>  	u32 *irq_data = get_irq_data(irq);
>  	struct irq_chip *chip = get_irq_chip(irq);
> 
> -	chip->mask(irq);
> +	chip->irq_mask(&desc->irq_data);
> 
> -	if (chip->ack)
> -		chip->ack(irq);
> +	if (chip->irq_ack)
> +		chip->irq_ack(&desc->irq_data);
> 
>  	generic_handle_irq(*irq_data);
> 
> -	chip->unmask(irq);
> +	chip->irq_unmask(&desc->irq_data);
>  }
> 
>  int __init s5pv310_init_irq_eint(void)
> diff --git a/arch/arm/plat-s3c24xx/include/plat/irq.h b/arch/arm/plat-
> s3c24xx/include/plat/irq.h
> index 69e1be8..15fdd71 100644
> --- a/arch/arm/plat-s3c24xx/include/plat/irq.h
> +++ b/arch/arm/plat-s3c24xx/include/plat/irq.h
> @@ -107,9 +107,9 @@ s3c_irqsub_ack(unsigned int irqno, unsigned int
> parentmask, unsigned int group)
>  /* exported for use in arch/arm/mach-s3c2410 */
> 
>  #ifdef CONFIG_PM
> -extern int s3c_irq_wake(unsigned int irqno, unsigned int state);
> +extern int s3c_irq_wake(struct irq_data *d, unsigned int state);
>  #else
>  #define s3c_irq_wake NULL
>  #endif
> 
> -extern int s3c_irqext_type(unsigned int irq, unsigned int type);
> +extern int s3c_irqext_type(struct irq_data *d, unsigned int type);
> diff --git a/arch/arm/plat-s3c24xx/irq-pm.c
b/arch/arm/plat-s3c24xx/irq-pm.c
> index ea8dea3..5dbf56d 100644
> --- a/arch/arm/plat-s3c24xx/irq-pm.c
> +++ b/arch/arm/plat-s3c24xx/irq-pm.c
> @@ -15,11 +15,14 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/sysdev.h>
> +#include <linux/irq.h>
> 
>  #include <plat/cpu.h>
>  #include <plat/pm.h>
>  #include <plat/irq.h>
> 
> +#include <asm/irq.h>
> +
>  /* state for IRQs over sleep */
> 
>  /* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
> @@ -30,15 +33,15 @@
>  unsigned long s3c_irqwake_intallow	= 1L << (IRQ_RTC - IRQ_EINT0) |
0xfL;
>  unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
> 
> -int s3c_irq_wake(unsigned int irqno, unsigned int state)
> +int s3c_irq_wake(struct irq_data *d, unsigned int state)
>  {
> -	unsigned long irqbit = 1 << (irqno - IRQ_EINT0);
> +	unsigned long irqbit = 1 << (d->irq - IRQ_EINT0);
> 
>  	if (!(s3c_irqwake_intallow & irqbit))
>  		return -ENOENT;
> 
>  	printk(KERN_INFO "wake %s for irq %d\n",
> -	       state ? "enabled" : "disabled", irqno);
> +	       state ? "enabled" : "disabled", d->irq);
> 
>  	if (!state)
>  		s3c_irqwake_intmask |= irqbit;
> diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
> index ad0d44e..bacd817 100644
> --- a/arch/arm/plat-s3c24xx/irq.c
> +++ b/arch/arm/plat-s3c24xx/irq.c
> @@ -34,30 +34,29 @@
>  #include <plat/irq.h>
> 
>  static void
> -s3c_irq_mask(unsigned int irqno)
> +s3c_irq_mask(struct irq_data *d)
>  {
> +	unsigned int irqno = d->irq - IRQ_EINT0;
>  	unsigned long mask;
> 
> -	irqno -= IRQ_EINT0;
> -
>  	mask = __raw_readl(S3C2410_INTMSK);
>  	mask |= 1UL << irqno;
>  	__raw_writel(mask, S3C2410_INTMSK);
>  }
> 
>  static inline void
> -s3c_irq_ack(unsigned int irqno)
> +s3c_irq_ack(struct irq_data *d)
>  {
> -	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
> +	unsigned long bitval = 1UL << (d->irq - IRQ_EINT0);
> 
>  	__raw_writel(bitval, S3C2410_SRCPND);
>  	__raw_writel(bitval, S3C2410_INTPND);
>  }
> 
>  static inline void
> -s3c_irq_maskack(unsigned int irqno)
> +s3c_irq_maskack(struct irq_data *d)
>  {
> -	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
> +	unsigned long bitval = 1UL << (d->irq - IRQ_EINT0);
>  	unsigned long mask;
> 
>  	mask = __raw_readl(S3C2410_INTMSK);
> @@ -69,8 +68,9 @@ s3c_irq_maskack(unsigned int irqno)
> 
> 
>  static void
> -s3c_irq_unmask(unsigned int irqno)
> +s3c_irq_unmask(struct irq_data *d)
>  {
> +	unsigned int irqno = d->irq;
>  	unsigned long mask;
> 
>  	if (irqno != IRQ_TIMER4 && irqno != IRQ_EINT8t23)
> @@ -85,40 +85,39 @@ s3c_irq_unmask(unsigned int irqno)
> 
>  struct irq_chip s3c_irq_level_chip = {
>  	.name		= "s3c-level",
> -	.ack		= s3c_irq_maskack,
> -	.mask		= s3c_irq_mask,
> -	.unmask		= s3c_irq_unmask,
> -	.set_wake	= s3c_irq_wake
> +	.irq_ack	= s3c_irq_maskack,
> +	.irq_mask	= s3c_irq_mask,
> +	.irq_unmask	= s3c_irq_unmask,
> +	.irq_set_wake	= s3c_irq_wake
>  };
> 
>  struct irq_chip s3c_irq_chip = {
>  	.name		= "s3c",
> -	.ack		= s3c_irq_ack,
> -	.mask		= s3c_irq_mask,
> -	.unmask		= s3c_irq_unmask,
> -	.set_wake	= s3c_irq_wake
> +	.irq_ack	= s3c_irq_ack,
> +	.irq_mask	= s3c_irq_mask,
> +	.irq_unmask	= s3c_irq_unmask,
> +	.irq_set_wake	= s3c_irq_wake
>  };
> 
>  static void
> -s3c_irqext_mask(unsigned int irqno)
> +s3c_irqext_mask(struct irq_data *d)
>  {
> +	unsigned int irqno = d->irq - EXTINT_OFF;
>  	unsigned long mask;
> 
> -	irqno -= EXTINT_OFF;
> -
>  	mask = __raw_readl(S3C24XX_EINTMASK);
>  	mask |= ( 1UL << irqno);
>  	__raw_writel(mask, S3C24XX_EINTMASK);
>  }
> 
>  static void
> -s3c_irqext_ack(unsigned int irqno)
> +s3c_irqext_ack(struct irq_data *d)
>  {
>  	unsigned long req;
>  	unsigned long bit;
>  	unsigned long mask;
> 
> -	bit = 1UL << (irqno - EXTINT_OFF);
> +	bit = 1UL << (d->irq - EXTINT_OFF);
> 
>  	mask = __raw_readl(S3C24XX_EINTMASK);
> 
> @@ -129,62 +128,61 @@ s3c_irqext_ack(unsigned int irqno)
> 
>  	/* not sure if we should be acking the parent irq... */
> 
> -	if (irqno <= IRQ_EINT7 ) {
> +	if (d->irq <= IRQ_EINT7 ) {
>  		if ((req & 0xf0) == 0)
> -			s3c_irq_ack(IRQ_EINT4t7);
> +			s3c_irq_ack(irq_get_irq_data(IRQ_EINT4t7));
>  	} else {
>  		if ((req >> 8) == 0)
> -			s3c_irq_ack(IRQ_EINT8t23);
> +			s3c_irq_ack(irq_get_irq_data(IRQ_EINT8t23));
>  	}
>  }
> 
>  static void
> -s3c_irqext_unmask(unsigned int irqno)
> +s3c_irqext_unmask(struct irq_data *d)
>  {
> +	unsigned int irqno = d->irq - EXTINT_OFF;
>  	unsigned long mask;
> 
> -	irqno -= EXTINT_OFF;
> -
>  	mask = __raw_readl(S3C24XX_EINTMASK);
>  	mask &= ~( 1UL << irqno);
>  	__raw_writel(mask, S3C24XX_EINTMASK);
>  }
> 
>  int
> -s3c_irqext_type(unsigned int irq, unsigned int type)
> +s3c_irqext_type(struct irq_data *d, unsigned int type)
>  {
>  	void __iomem *extint_reg;
>  	void __iomem *gpcon_reg;
>  	unsigned long gpcon_offset, extint_offset;
>  	unsigned long newvalue = 0, value;
> 
> -	if ((irq >= IRQ_EINT0) && (irq <= IRQ_EINT3))
> +	if ((d->irq >= IRQ_EINT0) && (d->irq <= IRQ_EINT3))
>  	{
>  		gpcon_reg = S3C2410_GPFCON;
>  		extint_reg = S3C24XX_EXTINT0;
> -		gpcon_offset = (irq - IRQ_EINT0) * 2;
> -		extint_offset = (irq - IRQ_EINT0) * 4;
> +		gpcon_offset = (d->irq - IRQ_EINT0) * 2;
> +		extint_offset = (d->irq - IRQ_EINT0) * 4;
>  	}
> -	else if ((irq >= IRQ_EINT4) && (irq <= IRQ_EINT7))
> +	else if ((d->irq >= IRQ_EINT4) && (d->irq <= IRQ_EINT7))
>  	{
>  		gpcon_reg = S3C2410_GPFCON;
>  		extint_reg = S3C24XX_EXTINT0;
> -		gpcon_offset = (irq - (EXTINT_OFF)) * 2;
> -		extint_offset = (irq - (EXTINT_OFF)) * 4;
> +		gpcon_offset = (d->irq - (EXTINT_OFF)) * 2;
> +		extint_offset = (d->irq - (EXTINT_OFF)) * 4;
>  	}
> -	else if ((irq >= IRQ_EINT8) && (irq <= IRQ_EINT15))
> +	else if ((d->irq >= IRQ_EINT8) && (d->irq <= IRQ_EINT15))
>  	{
>  		gpcon_reg = S3C2410_GPGCON;
>  		extint_reg = S3C24XX_EXTINT1;
> -		gpcon_offset = (irq - IRQ_EINT8) * 2;
> -		extint_offset = (irq - IRQ_EINT8) * 4;
> +		gpcon_offset = (d->irq - IRQ_EINT8) * 2;
> +		extint_offset = (d->irq - IRQ_EINT8) * 4;
>  	}
> -	else if ((irq >= IRQ_EINT16) && (irq <= IRQ_EINT23))
> +	else if ((d->irq >= IRQ_EINT16) && (d->irq <= IRQ_EINT23))
>  	{
>  		gpcon_reg = S3C2410_GPGCON;
>  		extint_reg = S3C24XX_EXTINT2;
> -		gpcon_offset = (irq - IRQ_EINT8) * 2;
> -		extint_offset = (irq - IRQ_EINT16) * 4;
> +		gpcon_offset = (d->irq - IRQ_EINT8) * 2;
> +		extint_offset = (d->irq - IRQ_EINT16) * 4;
>  	} else
>  		return -1;
> 
> @@ -234,20 +232,20 @@ s3c_irqext_type(unsigned int irq, unsigned int type)
> 
>  static struct irq_chip s3c_irqext_chip = {
>  	.name		= "s3c-ext",
> -	.mask		= s3c_irqext_mask,
> -	.unmask		= s3c_irqext_unmask,
> -	.ack		= s3c_irqext_ack,
> -	.set_type	= s3c_irqext_type,
> -	.set_wake	= s3c_irqext_wake
> +	.irq_mask	= s3c_irqext_mask,
> +	.irq_unmask	= s3c_irqext_unmask,
> +	.irq_ack	= s3c_irqext_ack,
> +	.irq_set_type	= s3c_irqext_type,
> +	.irq_set_wake	= s3c_irqext_wake

Already applied last change.

>  };
> 
>  static struct irq_chip s3c_irq_eint0t4 = {
>  	.name		= "s3c-ext0",
> -	.ack		= s3c_irq_ack,
> -	.mask		= s3c_irq_mask,
> -	.unmask		= s3c_irq_unmask,
> -	.set_wake	= s3c_irq_wake,
> -	.set_type	= s3c_irqext_type,
> +	.irq_ack	= s3c_irq_ack,
> +	.irq_mask	= s3c_irq_mask,
> +	.irq_unmask	= s3c_irq_unmask,
> +	.irq_set_wake	= s3c_irq_wake,
> +	.irq_set_type	= s3c_irqext_type,
>  };
> 
>  /* mask values for the parent registers for each of the interrupt types
*/
> @@ -261,109 +259,109 @@ static struct irq_chip s3c_irq_eint0t4 = {
>  /* UART0 */
> 
>  static void
> -s3c_irq_uart0_mask(unsigned int irqno)
> +s3c_irq_uart0_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_UART0, 7);
> +	s3c_irqsub_mask(d->irq, INTMSK_UART0, 7);
>  }
> 
>  static void
> -s3c_irq_uart0_unmask(unsigned int irqno)
> +s3c_irq_uart0_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_UART0);
> +	s3c_irqsub_unmask(d->irq, INTMSK_UART0);
>  }
> 
>  static void
> -s3c_irq_uart0_ack(unsigned int irqno)
> +s3c_irq_uart0_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_UART0, 7);
> +	s3c_irqsub_maskack(d->irq, INTMSK_UART0, 7);
>  }
> 
>  static struct irq_chip s3c_irq_uart0 = {
>  	.name		= "s3c-uart0",
> -	.mask		= s3c_irq_uart0_mask,
> -	.unmask		= s3c_irq_uart0_unmask,
> -	.ack		= s3c_irq_uart0_ack,
> +	.irq_mask	= s3c_irq_uart0_mask,
> +	.irq_unmask	= s3c_irq_uart0_unmask,
> +	.irq_ack	= s3c_irq_uart0_ack,
>  };
> 
>  /* UART1 */
> 
>  static void
> -s3c_irq_uart1_mask(unsigned int irqno)
> +s3c_irq_uart1_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_UART1, 7 << 3);
> +	s3c_irqsub_mask(d->irq, INTMSK_UART1, 7 << 3);
>  }
> 
>  static void
> -s3c_irq_uart1_unmask(unsigned int irqno)
> +s3c_irq_uart1_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_UART1);
> +	s3c_irqsub_unmask(d->irq, INTMSK_UART1);
>  }
> 
>  static void
> -s3c_irq_uart1_ack(unsigned int irqno)
> +s3c_irq_uart1_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_UART1, 7 << 3);
> +	s3c_irqsub_maskack(d->irq, INTMSK_UART1, 7 << 3);
>  }
> 
>  static struct irq_chip s3c_irq_uart1 = {
>  	.name		= "s3c-uart1",
> -	.mask		= s3c_irq_uart1_mask,
> -	.unmask		= s3c_irq_uart1_unmask,
> -	.ack		= s3c_irq_uart1_ack,
> +	.irq_mask	= s3c_irq_uart1_mask,
> +	.irq_unmask	= s3c_irq_uart1_unmask,
> +	.irq_ack	= s3c_irq_uart1_ack,
>  };
> 
>  /* UART2 */
> 
>  static void
> -s3c_irq_uart2_mask(unsigned int irqno)
> +s3c_irq_uart2_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_UART2, 7 << 6);
> +	s3c_irqsub_mask(d->irq, INTMSK_UART2, 7 << 6);
>  }
> 
>  static void
> -s3c_irq_uart2_unmask(unsigned int irqno)
> +s3c_irq_uart2_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_UART2);
> +	s3c_irqsub_unmask(d->irq, INTMSK_UART2);
>  }
> 
>  static void
> -s3c_irq_uart2_ack(unsigned int irqno)
> +s3c_irq_uart2_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_maskack(irqno, INTMSK_UART2, 7 << 6);
> +	s3c_irqsub_maskack(d->irq, INTMSK_UART2, 7 << 6);
>  }
> 
>  static struct irq_chip s3c_irq_uart2 = {
>  	.name		= "s3c-uart2",
> -	.mask		= s3c_irq_uart2_mask,
> -	.unmask		= s3c_irq_uart2_unmask,
> -	.ack		= s3c_irq_uart2_ack,
> +	.irq_mask	= s3c_irq_uart2_mask,
> +	.irq_unmask	= s3c_irq_uart2_unmask,
> +	.irq_ack	= s3c_irq_uart2_ack,
>  };
> 
>  /* ADC and Touchscreen */
> 
>  static void
> -s3c_irq_adc_mask(unsigned int irqno)
> +s3c_irq_adc_mask(struct irq_data *d)
>  {
> -	s3c_irqsub_mask(irqno, INTMSK_ADCPARENT, 3 << 9);
> +	s3c_irqsub_mask(d->irq, INTMSK_ADCPARENT, 3 << 9);
>  }
> 
>  static void
> -s3c_irq_adc_unmask(unsigned int irqno)
> +s3c_irq_adc_unmask(struct irq_data *d)
>  {
> -	s3c_irqsub_unmask(irqno, INTMSK_ADCPARENT);
> +	s3c_irqsub_unmask(d->irq, INTMSK_ADCPARENT);
>  }
> 
>  static void
> -s3c_irq_adc_ack(unsigned int irqno)
> +s3c_irq_adc_ack(struct irq_data *d)
>  {
> -	s3c_irqsub_ack(irqno, INTMSK_ADCPARENT, 3 << 9);
> +	s3c_irqsub_ack(d->irq, INTMSK_ADCPARENT, 3 << 9);
>  }
> 
>  static struct irq_chip s3c_irq_adc = {
>  	.name		= "s3c-adc",
> -	.mask		= s3c_irq_adc_mask,
> -	.unmask		= s3c_irq_adc_unmask,
> -	.ack		= s3c_irq_adc_ack,
> +	.irq_mask	= s3c_irq_adc_mask,
> +	.irq_unmask	= s3c_irq_adc_unmask,
> +	.irq_ack	= s3c_irq_adc_ack,
>  };
> 
>  /* irq demux for adc */
> diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> index 752f1a6..088655a 100644
> --- a/arch/arm/plat-s5p/irq-eint.c
> +++ b/arch/arm/plat-s5p/irq-eint.c
> @@ -28,39 +28,39 @@
>  #include <plat/gpio-cfg.h>
>  #include <mach/regs-gpio.h>
> 
> -static inline void s5p_irq_eint_mask(unsigned int irq)
> +static inline void s5p_irq_eint_mask(struct irq_data *d)
>  {
>  	u32 mask;
> 
> -	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
> -	mask |= eint_irq_to_bit(irq);
> -	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
> +	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(d->irq)));
> +	mask |= eint_irq_to_bit(d->irq);
> +	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(d->irq)));
>  }
> 
> -static void s5p_irq_eint_unmask(unsigned int irq)
> +static void s5p_irq_eint_unmask(struct irq_data *d)
>  {
>  	u32 mask;
> 
> -	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
> -	mask &= ~(eint_irq_to_bit(irq));
> -	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
> +	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(d->irq)));
> +	mask &= ~(eint_irq_to_bit(d->irq));
> +	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(d->irq)));
>  }
> 
> -static inline void s5p_irq_eint_ack(unsigned int irq)
> +static inline void s5p_irq_eint_ack(struct irq_data *d)
>  {
> -	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
> +	__raw_writel(eint_irq_to_bit(d->irq), S5P_EINT_PEND(EINT_REG_NR(d-
> >irq)));
>  }
> 
> -static void s5p_irq_eint_maskack(unsigned int irq)
> +static void s5p_irq_eint_maskack(struct irq_data *d)
>  {
>  	/* compiler should in-line these */
> -	s5p_irq_eint_mask(irq);
> -	s5p_irq_eint_ack(irq);
> +	s5p_irq_eint_mask(d);
> +	s5p_irq_eint_ack(d);
>  }
> 
> -static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
> +static int s5p_irq_eint_set_type(struct irq_data *d, unsigned int type)
>  {
> -	int offs = EINT_OFFSET(irq);
> +	int offs = EINT_OFFSET(d->irq);
>  	int shift;
>  	u32 ctrl, mask;
>  	u32 newvalue = 0;
> @@ -94,10 +94,10 @@ static int s5p_irq_eint_set_type(unsigned int irq,
> unsigned int type)
>  	shift = (offs & 0x7) * 4;
>  	mask = 0x7 << shift;
> 
> -	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(irq)));
> +	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(d->irq)));
>  	ctrl &= ~mask;
>  	ctrl |= newvalue << shift;
> -	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(irq)));
> +	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(d->irq)));
> 
>  	if ((0 <= offs) && (offs < 8))
>  		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
> @@ -119,13 +119,13 @@ static int s5p_irq_eint_set_type(unsigned int irq,
> unsigned int type)
> 
>  static struct irq_chip s5p_irq_eint = {
>  	.name		= "s5p-eint",
> -	.mask		= s5p_irq_eint_mask,
> -	.unmask		= s5p_irq_eint_unmask,
> -	.mask_ack	= s5p_irq_eint_maskack,
> -	.ack		= s5p_irq_eint_ack,
> -	.set_type	= s5p_irq_eint_set_type,
> +	.irq_mask	= s5p_irq_eint_mask,
> +	.irq_unmask	= s5p_irq_eint_unmask,
> +	.irq_mask_ack	= s5p_irq_eint_maskack,
> +	.irq_ack	= s5p_irq_eint_ack,
> +	.irq_set_type	= s5p_irq_eint_set_type,
>  #ifdef CONFIG_PM
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_set_wake	= s3c_irqext_wake,

Already applied last change.

>  #endif
>  };
> 
> @@ -159,42 +159,42 @@ static void s5p_irq_demux_eint16_31(unsigned int
irq,
> struct irq_desc *desc)
>  	s5p_irq_demux_eint(IRQ_EINT(24));
>  }
> 
> -static inline void s5p_irq_vic_eint_mask(unsigned int irq)
> +static inline void s5p_irq_vic_eint_mask(struct irq_data *d)
>  {
> -	void __iomem *base = get_irq_chip_data(irq);
> +	void __iomem *base = irq_data_get_irq_chip_data(d);
> 
> -	s5p_irq_eint_mask(irq);
> -	writel(1 << EINT_OFFSET(irq), base + VIC_INT_ENABLE_CLEAR);
> +	s5p_irq_eint_mask(d);
> +	writel(1 << EINT_OFFSET(d->irq), base + VIC_INT_ENABLE_CLEAR);
>  }
> 
> -static void s5p_irq_vic_eint_unmask(unsigned int irq)
> +static void s5p_irq_vic_eint_unmask(struct irq_data *d)
>  {
> -	void __iomem *base = get_irq_chip_data(irq);
> +	void __iomem *base = irq_data_get_irq_chip_data(d);
> 
> -	s5p_irq_eint_unmask(irq);
> -	writel(1 << EINT_OFFSET(irq), base + VIC_INT_ENABLE);
> +	s5p_irq_eint_unmask(d);
> +	writel(1 << EINT_OFFSET(d->irq), base + VIC_INT_ENABLE);
>  }
> 
> -static inline void s5p_irq_vic_eint_ack(unsigned int irq)
> +static inline void s5p_irq_vic_eint_ack(struct irq_data *d)
>  {
> -	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
> +	__raw_writel(eint_irq_to_bit(d->irq), S5P_EINT_PEND(EINT_REG_NR(d-
> >irq)));
>  }
> 
> -static void s5p_irq_vic_eint_maskack(unsigned int irq)
> +static void s5p_irq_vic_eint_maskack(struct irq_data *d)
>  {
> -	s5p_irq_vic_eint_mask(irq);
> -	s5p_irq_vic_eint_ack(irq);
> +	s5p_irq_vic_eint_mask(d);
> +	s5p_irq_vic_eint_ack(d);
>  }
> 
>  static struct irq_chip s5p_irq_vic_eint = {
>  	.name		= "s5p_vic_eint",
> -	.mask		= s5p_irq_vic_eint_mask,
> -	.unmask		= s5p_irq_vic_eint_unmask,
> -	.mask_ack	= s5p_irq_vic_eint_maskack,
> -	.ack		= s5p_irq_vic_eint_ack,
> -	.set_type	= s5p_irq_eint_set_type,
> +	.irq_mask	= s5p_irq_vic_eint_mask,
> +	.irq_unmask	= s5p_irq_vic_eint_unmask,
> +	.irq_mask_ack	= s5p_irq_vic_eint_maskack,
> +	.irq_ack	= s5p_irq_vic_eint_ack,
> +	.irq_set_type	= s5p_irq_eint_set_type,
>  #ifdef CONFIG_PM
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_set_wake	= s3c_irqext_wake,

Same.

>  #endif
>  };
> 
> diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-
> gpioint.c
> index 0e5dc8c..6b96d32 100644
> --- a/arch/arm/plat-s5p/irq-gpioint.c
> +++ b/arch/arm/plat-s5p/irq-gpioint.c
> @@ -30,9 +30,9 @@
> 
>  static struct s3c_gpio_chip *irq_chips[S5P_GPIOINT_GROUP_MAXNR];
> 
> -static int s5p_gpioint_get_group(unsigned int irq)
> +static int s5p_gpioint_get_group(struct irq_data *d)
>  {
> -	struct gpio_chip *chip = get_irq_data(irq);
> +	struct gpio_chip *chip = irq_data_get_irq_data(d);
>  	struct s3c_gpio_chip *s3c_chip = container_of(chip,
>  			struct s3c_gpio_chip, chip);
>  	int group;
> @@ -44,22 +44,22 @@ static int s5p_gpioint_get_group(unsigned int irq)
>  	return group;
>  }
> 
> -static int s5p_gpioint_get_offset(unsigned int irq)
> +static int s5p_gpioint_get_offset(struct irq_data *d)
>  {
> -	struct gpio_chip *chip = get_irq_data(irq);
> +	struct gpio_chip *chip = irq_data_get_irq_data(d);
>  	struct s3c_gpio_chip *s3c_chip = container_of(chip,
>  			struct s3c_gpio_chip, chip);
> 
> -	return irq - s3c_chip->irq_base;
> +	return d->irq - s3c_chip->irq_base;
>  }
> 
> -static void s5p_gpioint_ack(unsigned int irq)
> +static void s5p_gpioint_ack(struct irq_data *d)
>  {
>  	int group, offset, pend_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(irq);
> -	offset = s5p_gpioint_get_offset(irq);
> +	group = s5p_gpioint_get_group(d);
> +	offset = s5p_gpioint_get_offset(d);
>  	pend_offset = group << 2;
> 
>  	value = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
> @@ -67,13 +67,13 @@ static void s5p_gpioint_ack(unsigned int irq)
>  	__raw_writel(value, S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
>  }
> 
> -static void s5p_gpioint_mask(unsigned int irq)
> +static void s5p_gpioint_mask(struct irq_data *d)
>  {
>  	int group, offset, mask_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(irq);
> -	offset = s5p_gpioint_get_offset(irq);
> +	group = s5p_gpioint_get_group(d);
> +	offset = s5p_gpioint_get_offset(d);
>  	mask_offset = group << 2;
> 
>  	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
> @@ -81,13 +81,13 @@ static void s5p_gpioint_mask(unsigned int irq)
>  	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
>  }
> 
> -static void s5p_gpioint_unmask(unsigned int irq)
> +static void s5p_gpioint_unmask(struct irq_data *d)
>  {
>  	int group, offset, mask_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(irq);
> -	offset = s5p_gpioint_get_offset(irq);
> +	group = s5p_gpioint_get_group(d);
> +	offset = s5p_gpioint_get_offset(d);
>  	mask_offset = group << 2;
> 
>  	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
> @@ -95,19 +95,19 @@ static void s5p_gpioint_unmask(unsigned int irq)
>  	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
>  }
> 
> -static void s5p_gpioint_mask_ack(unsigned int irq)
> +static void s5p_gpioint_mask_ack(struct irq_data *d)
>  {
> -	s5p_gpioint_mask(irq);
> -	s5p_gpioint_ack(irq);
> +	s5p_gpioint_mask(d);
> +	s5p_gpioint_ack(d);
>  }
> 
> -static int s5p_gpioint_set_type(unsigned int irq, unsigned int type)
> +static int s5p_gpioint_set_type(struct irq_data *d, unsigned int type)
>  {
>  	int group, offset, con_offset;
>  	unsigned int value;
> 
> -	group = s5p_gpioint_get_group(irq);
> -	offset = s5p_gpioint_get_offset(irq);
> +	group = s5p_gpioint_get_group(d);
> +	offset = s5p_gpioint_get_offset(d);
>  	con_offset = group << 2;
> 
>  	switch (type) {
> @@ -142,11 +142,11 @@ static int s5p_gpioint_set_type(unsigned int irq,
> unsigned int type)
> 
>  struct irq_chip s5p_gpioint = {
>  	.name		= "s5p_gpioint",
> -	.ack		= s5p_gpioint_ack,
> -	.mask		= s5p_gpioint_mask,
> -	.mask_ack	= s5p_gpioint_mask_ack,
> -	.unmask		= s5p_gpioint_unmask,
> -	.set_type	= s5p_gpioint_set_type,
> +	.irq_ack	= s5p_gpioint_ack,
> +	.irq_mask	= s5p_gpioint_mask,
> +	.irq_mask_ack	= s5p_gpioint_mask_ack,
> +	.irq_unmask	= s5p_gpioint_unmask,
> +	.irq_set_type	= s5p_gpioint_set_type,
>  };
> 
>  static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
> diff --git a/arch/arm/plat-s5p/irq-pm.c b/arch/arm/plat-s5p/irq-pm.c
> index dc33b9e..7918261 100644
> --- a/arch/arm/plat-s5p/irq-pm.c
> +++ b/arch/arm/plat-s5p/irq-pm.c
> @@ -37,14 +37,14 @@
>  unsigned long s3c_irqwake_intallow	= 0x00000006L;
>  unsigned long s3c_irqwake_eintallow	= 0xffffffffL;
> 
> -int s3c_irq_wake(unsigned int irqno, unsigned int state)
> +int s3c_irq_wake(struct irq_data *d, unsigned int state)
>  {
>  	unsigned long irqbit;
> 
> -	switch (irqno) {
> +	switch (d->irq) {
>  	case IRQ_RTC_TIC:
>  	case IRQ_RTC_ALARM:
> -		irqbit = 1 << (irqno + 1 - IRQ_RTC_ALARM);
> +		irqbit = 1 << (d->irq + 1 - IRQ_RTC_ALARM);
>  		if (!state)
>  			s3c_irqwake_intmask |= irqbit;
>  		else
> diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-
> samsung/include/plat/pm.h
> index 245836d..0f212c2 100644
> --- a/arch/arm/plat-samsung/include/plat/pm.h
> +++ b/arch/arm/plat-samsung/include/plat/pm.h

Already applied the changes of this file.

> @@ -15,6 +15,8 @@
>   * management
>  */
> 
> +struct irq_data;
> +
>  #ifdef CONFIG_PM
> 
>  extern __init int s3c_pm_init(void);
> @@ -100,7 +102,7 @@ extern void s3c_pm_do_restore(struct sleep_save *ptr,
int
> count);
>  extern void s3c_pm_do_restore_core(struct sleep_save *ptr, int count);
> 
>  #ifdef CONFIG_PM
> -extern int s3c_irqext_wake(unsigned int irqno, unsigned int state);
> +extern int s3c_irqext_wake(struct irq_data *d, unsigned int state);
>  extern int s3c24xx_irq_suspend(struct sys_device *dev, pm_message_t
state);
>  extern int s3c24xx_irq_resume(struct sys_device *dev);
>  #else
> diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-
> uart.c
> index 4f8c102..92a25d6 100644
> --- a/arch/arm/plat-samsung/irq-uart.c
> +++ b/arch/arm/plat-samsung/irq-uart.c

Already applied some changes in this file...

> @@ -28,21 +28,21 @@
>   * are consecutive when looking up the interrupt in the demux routines.
>   */
> 
> -static inline void __iomem *s3c_irq_uart_base(unsigned int irq)
> +static inline void __iomem *s3c_irq_uart_base(struct irq_data *d)
>  {
> -	struct s3c_uart_irq *uirq = get_irq_chip_data(irq);
> +	struct s3c_uart_irq *uirq = irq_data_get_irq_chip_data(d);
>  	return uirq->regs;
>  }
> 
> -static inline unsigned int s3c_irq_uart_bit(unsigned int irq)
> +static inline unsigned int s3c_irq_uart_bit(struct irq_data *d)
>  {
> -	return irq & 3;
> +	return d->irq & 3;
>  }
> 
> -static void s3c_irq_uart_mask(unsigned int irq)
> +static void s3c_irq_uart_mask(struct irq_data *d)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(d);
> +	unsigned int bit = s3c_irq_uart_bit(d);
>  	u32 reg;
> 
>  	reg = __raw_readl(regs + S3C64XX_UINTM);
> @@ -50,10 +50,10 @@ static void s3c_irq_uart_mask(unsigned int irq)
>  	__raw_writel(reg, regs + S3C64XX_UINTM);
>  }
> 
> -static void s3c_irq_uart_maskack(unsigned int irq)
> +static void s3c_irq_uart_maskack(struct irq_data *d)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(d);
> +	unsigned int bit = s3c_irq_uart_bit(d);
>  	u32 reg;
> 
>  	reg = __raw_readl(regs + S3C64XX_UINTM);
> @@ -62,10 +62,10 @@ static void s3c_irq_uart_maskack(unsigned int irq)
>  	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
>  }
> 
> -static void s3c_irq_uart_unmask(unsigned int irq)
> +static void s3c_irq_uart_unmask(struct irq_data *d)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(d);
> +	unsigned int bit = s3c_irq_uart_bit(d);
>  	u32 reg;
> 
>  	reg = __raw_readl(regs + S3C64XX_UINTM);
> @@ -73,17 +73,17 @@ static void s3c_irq_uart_unmask(unsigned int irq)
>  	__raw_writel(reg, regs + S3C64XX_UINTM);
>  }
> 
> -static void s3c_irq_uart_ack(unsigned int irq)
> +static void s3c_irq_uart_ack(struct irq_data *d)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(d);
> +	unsigned int bit = s3c_irq_uart_bit(d);
> 
>  	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
>  }
> 
>  static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct s3c_uart_irq *uirq = desc->handler_data;
> +	struct s3c_uart_irq *uirq = desc->irq_data.handler_data;
>  	u32 pend = __raw_readl(uirq->regs + S3C64XX_UINTP);
>  	int base = uirq->base_irq;
> 
> @@ -99,10 +99,10 @@ static void s3c_irq_demux_uart(unsigned int irq,
struct
> irq_desc *desc)
> 
>  static struct irq_chip s3c_irq_uart = {
>  	.name		= "s3c-uart",
> -	.mask		= s3c_irq_uart_mask,
> -	.unmask		= s3c_irq_uart_unmask,
> -	.mask_ack	= s3c_irq_uart_maskack,
> -	.ack		= s3c_irq_uart_ack,
> +	.irq_mask	= s3c_irq_uart_mask,
> +	.irq_unmask	= s3c_irq_uart_unmask,
> +	.irq_mask_ack	= s3c_irq_uart_maskack,
> +	.irq_ack	= s3c_irq_uart_ack,
>  };
> 
>  static void __init s3c_init_uart_irq(struct s3c_uart_irq *uirq)
> @@ -124,7 +124,7 @@ static void __init s3c_init_uart_irq(struct
s3c_uart_irq
> *uirq)
>  		set_irq_flags(irq, IRQF_VALID);
>  	}
> 
> -	desc->handler_data = uirq;
> +	desc->irq_data.handler_data = uirq;
>  	set_irq_chained_handler(uirq->parent_irq, s3c_irq_demux_uart);
>  }
> 
> diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-
> samsung/irq-vic-timer.c
> index 0270519..6ee39e0 100644
> --- a/arch/arm/plat-samsung/irq-vic-timer.c
> +++ b/arch/arm/plat-samsung/irq-vic-timer.c

Same...already applied some changes in this file...

> @@ -24,43 +24,43 @@
> 
>  static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc
*desc)
>  {
> -	generic_handle_irq((int)desc->handler_data);
> +	generic_handle_irq((int)desc->irq_data.handler_data);
>  }
> 
>  /* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
> 
> -static void s3c_irq_timer_mask(unsigned int irq)
> +static void s3c_irq_timer_mask(struct irq_data *d)
>  {
>  	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
> 
>  	reg &= 0x1f;  /* mask out pending interrupts */
> -	reg &= ~(1 << (irq - IRQ_TIMER0));
> +	reg &= ~(1 << (d->irq - IRQ_TIMER0));
>  	__raw_writel(reg, S3C64XX_TINT_CSTAT);
>  }
> 
> -static void s3c_irq_timer_unmask(unsigned int irq)
> +static void s3c_irq_timer_unmask(struct irq_data *d)
>  {
>  	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
> 
>  	reg &= 0x1f;  /* mask out pending interrupts */
> -	reg |= 1 << (irq - IRQ_TIMER0);
> +	reg |= 1 << (d->irq - IRQ_TIMER0);
>  	__raw_writel(reg, S3C64XX_TINT_CSTAT);
>  }
> 
> -static void s3c_irq_timer_ack(unsigned int irq)
> +static void s3c_irq_timer_ack(struct irq_data *d)
>  {
>  	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
> 
>  	reg &= 0x1f;
> -	reg |= (1 << 5) << (irq - IRQ_TIMER0);
> +	reg |= (1 << 5) << (d->irq - IRQ_TIMER0);
>  	__raw_writel(reg, S3C64XX_TINT_CSTAT);
>  }
> 
>  static struct irq_chip s3c_irq_timer = {
>  	.name		= "s3c-timer",
> -	.mask		= s3c_irq_timer_mask,
> -	.unmask		= s3c_irq_timer_unmask,
> -	.ack		= s3c_irq_timer_ack,
> +	.irq_mask	= s3c_irq_timer_mask,
> +	.irq_unmask	= s3c_irq_timer_unmask,
> +	.irq_ack	= s3c_irq_timer_ack,
>  };
> 
>  /**
> @@ -82,5 +82,5 @@ void __init s3c_init_vic_timer_irq(unsigned int
parent_irq,
>  	set_irq_handler(timer_irq, handle_level_irq);
>  	set_irq_flags(timer_irq, IRQF_VALID);
> 
> -	desc->handler_data = (void *)timer_irq;
> +	desc->irq_data.handler_data = (void *)timer_irq;
>  }
> diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
> index 27cfca5..510a9c6 100644
> --- a/arch/arm/plat-samsung/pm.c
> +++ b/arch/arm/plat-samsung/pm.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/serial_core.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
> 
>  #include <asm/cacheflush.h>
>  #include <mach/hardware.h>
> @@ -136,15 +137,15 @@ static void s3c_pm_restore_uarts(void) { }
>  unsigned long s3c_irqwake_intmask	= 0xffffffffL;
>  unsigned long s3c_irqwake_eintmask	= 0xffffffffL;
> 
> -int s3c_irqext_wake(unsigned int irqno, unsigned int state)
> +int s3c_irqext_wake(struct irq_data *d, unsigned int state)

Already applied.

>  {
> -	unsigned long bit = 1L << IRQ_EINT_BIT(irqno);
> +	unsigned long bit = 1L << IRQ_EINT_BIT(d->irq);

Same.

> 
>  	if (!(s3c_irqwake_eintallow & bit))
>  		return -ENOENT;
> 
>  	printk(KERN_INFO "wake %s for irq %d\n",
> -	       state ? "enabled" : "disabled", irqno);
> +	       state ? "enabled" : "disabled", d->irq);

Same.

> 
>  	if (!state)
>  		s3c_irqwake_eintmask |= bit;
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
