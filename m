From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 30 Sep 2010 13:32:43 +0200
Subject: [PATCH] ARM: Samsung S5P: Unify defines for both gpio interrupt
	types
In-Reply-To: <00a501cb6091$e25692c0$a703b840$%kim@samsung.com>
References: <1285841906-21194-1-git-send-email-m.szyprowski@samsung.com>
	<00a501cb6091$e25692c0$a703b840$%kim@samsung.com>
Message-ID: <00e101cb6093$34f4d270$9ede7750$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, September 30, 2010 1:23 PM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > Samsung S5P series have the same interrupt type defines for both
> > external interrupts and gpio interrupts. This patch removes all
> > duplicates from s5pc100 and s5pv210 specific includes as well as gpio
> > int code and put a common defines to plat/irqs.h
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > ---
> >
> > Hello,
> >
> Hi ;-)
> 
> > This patch has been prepared as a continuation of my patch series for
> > gpio interrupts (see "[PATCH v3] ARM: S5P: Add support for gpio
> > interrupts" thread). It requires them to be applied first.
> 
> Ok..I got it.
> >
> > Best regards
> > --
> > Marek Szyprowski
> > Samsung Poland R&D Center
> >
> > ---
> >
> >  arch/arm/mach-s5pc100/include/mach/regs-gpio.h |    7 -------
> >  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |    7 -------
> >  arch/arm/plat-s5p/include/plat/irqs.h          |    7 +++++++
> >  arch/arm/plat-s5p/irq-eint.c                   |   10 +++++-----
> >  arch/arm/plat-s5p/irq-gpioint.c                |   16 +++++-----------
> >  5 files changed, 17 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
> b/arch/arm/mach-
> > s5pc100/include/mach/regs-gpio.h
> > index 6abe481..8c47536 100644
> > --- a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
> > +++ b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
> > @@ -64,13 +64,6 @@
> >
> >  #define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
> >
> > -/* values for S5P_EXTINT0 */
> > -#define S5P_EXTINT_LOWLEV		(0x00)
> > -#define S5P_EXTINT_HILEV		(0x01)
> > -#define S5P_EXTINT_FALLEDGE		(0x02)
> > -#define S5P_EXTINT_RISEEDGE		(0x03)
> > -#define S5P_EXTINT_BOTHEDGE		(0x04)
> > -
> >  #define EINT_MODE		S3C_GPIO_SFN(0x2)
> >
> >  #define EINT_GPIO_0(x)		S5PC100_GPH0(x)
> > diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> b/arch/arm/mach-
> > s5pv210/include/mach/regs-gpio.h
> > index 49e029b..de0c899 100644
> > --- a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> > +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> > @@ -31,13 +31,6 @@
> >
> >  #define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
> >
> > -/* values for S5P_EXTINT0 */
> > -#define S5P_EXTINT_LOWLEV		(0x00)
> > -#define S5P_EXTINT_HILEV		(0x01)
> > -#define S5P_EXTINT_FALLEDGE		(0x02)
> > -#define S5P_EXTINT_RISEEDGE		(0x03)
> > -#define S5P_EXTINT_BOTHEDGE		(0x04)
> > -
> >  #define EINT_MODE		S3C_GPIO_SFN(0xf)
> >
> >  #define EINT_GPIO_0(x)		S5PV210_GPH0(x)
> > diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-
> > s5p/include/plat/irqs.h
> > index 5a7bf96..3b402cd 100644
> > --- a/arch/arm/plat-s5p/include/plat/irqs.h
> > +++ b/arch/arm/plat-s5p/include/plat/irqs.h
> > @@ -103,4 +103,11 @@
> >  #define S5P_GPIOINT_GROUP_SIZE	8
> >  #define S5P_GPIOINT_COUNT	(S5P_GPIOINT_GROUP_COUNT *
> > S5P_GPIOINT_GROUP_SIZE)
> >
> > +/* IRQ types common for all s5p platforms */
> > +#define S5P_IRQ_TYPE_LEVEL_LOW		(0x00)
> > +#define S5P_IRQ_TYPE_LEVEL_HIGH		(0x01)
> > +#define S5P_IRQ_TYPE_EDGE_FALLING	(0x02)
> > +#define S5P_IRQ_TYPE_EDGE_RISING	(0x03)
> > +#define S5P_IRQ_TYPE_EDGE_BOTH		(0x04)
> > +
> But the values for S5P64X0 is different. So we should sort it out when
> support this on S5P64X0.
> 
> >  #endif /* __ASM_PLAT_S5P_IRQS_H */
> > diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> > index f36cd33..752f1a6 100644
> > --- a/arch/arm/plat-s5p/irq-eint.c
> > +++ b/arch/arm/plat-s5p/irq-eint.c
> > @@ -67,23 +67,23 @@ static int s5p_irq_eint_set_type(unsigned int irq,
> unsigned
> > int type)
> >
> >  	switch (type) {
> >  	case IRQ_TYPE_EDGE_RISING:
> > -		newvalue = S5P_EXTINT_RISEEDGE;
> > +		newvalue = S5P_IRQ_TYPE_EDGE_RISING;
> >  		break;
> >
> >  	case IRQ_TYPE_EDGE_FALLING:
> > -		newvalue = S5P_EXTINT_FALLEDGE;
> > +		newvalue = S5P_IRQ_TYPE_EDGE_FALLING;
> >  		break;
> >
> >  	case IRQ_TYPE_EDGE_BOTH:
> > -		newvalue = S5P_EXTINT_BOTHEDGE;
> > +		newvalue = S5P_IRQ_TYPE_EDGE_BOTH;
> >  		break;
> >
> >  	case IRQ_TYPE_LEVEL_LOW:
> > -		newvalue = S5P_EXTINT_LOWLEV;
> > +		newvalue = S5P_IRQ_TYPE_LEVEL_LOW;
> >  		break;
> >
> >  	case IRQ_TYPE_LEVEL_HIGH:
> > -		newvalue = S5P_EXTINT_HILEV;
> > +		newvalue = S5P_IRQ_TYPE_LEVEL_HIGH;
> >  		break;
> >
> >  	default:
> > diff --git a/arch/arm/plat-s5p/irq-gpioint.c
> b/arch/arm/plat-s5p/irq-gpioint.c
> > index 768fd39..0e5dc8c 100644
> > --- a/arch/arm/plat-s5p/irq-gpioint.c
> > +++ b/arch/arm/plat-s5p/irq-gpioint.c
> > @@ -28,12 +28,6 @@
> >  #define GPIOINT_MASK_OFFSET		0x900
> >  #define GPIOINT_PEND_OFFSET		0xA00
> >
> > -#define GPIOINT_LEVEL_LOW		0x0
> > -#define GPIOINT_LEVEL_HIGH		0x1
> > -#define GPIOINT_EDGE_FALLING		0x2
> > -#define GPIOINT_EDGE_RISING		0x3
> > -#define GPIOINT_EDGE_BOTH		0x4
> > -
> >  static struct s3c_gpio_chip *irq_chips[S5P_GPIOINT_GROUP_MAXNR];
> >
> >  static int s5p_gpioint_get_group(unsigned int irq)
> > @@ -118,19 +112,19 @@ static int s5p_gpioint_set_type(unsigned int irq,
> > unsigned int type)
> >
> >  	switch (type) {
> >  	case IRQ_TYPE_EDGE_RISING:
> > -		type = GPIOINT_EDGE_RISING;
> > +		type = S5P_IRQ_TYPE_EDGE_RISING;
> >  		break;
> >  	case IRQ_TYPE_EDGE_FALLING:
> > -		type = GPIOINT_EDGE_FALLING;
> > +		type = S5P_IRQ_TYPE_EDGE_FALLING;
> >  		break;
> >  	case IRQ_TYPE_EDGE_BOTH:
> > -		type = GPIOINT_EDGE_BOTH;
> > +		type = S5P_IRQ_TYPE_EDGE_BOTH;
> >  		break;
> >  	case IRQ_TYPE_LEVEL_HIGH:
> > -		type = GPIOINT_LEVEL_HIGH;
> > +		type = S5P_IRQ_TYPE_LEVEL_HIGH;
> >  		break;
> >  	case IRQ_TYPE_LEVEL_LOW:
> > -		type = GPIOINT_LEVEL_LOW;
> > +		type = S5P_IRQ_TYPE_LEVEL_LOW;
> >  		break;
> >  	case IRQ_TYPE_NONE:
> >  	default:
> > --
> 
> Ok..firstly looks ok to me now.
> But I don't know...in the future may have to revert back due to S5P64XX.

Well, these defines are used only by plat-s5p/irq-{eint,gpioint}.c. These generic
functions cannot be used for S5P64XX anyway, because it has S3C64XX style of gpio
registers afair. IMHO this shouldn't be a problem. Just S5P64XX would need to
provide it's own code for gpio/ext interrupts (or share the code with s3c64xx
somehow).

> Firstly will apply.

Thx.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
