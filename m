From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 20 Apr 2012 16:58:01 +0800
Subject: [PATCH] ARM pxa pcm027: use ioremap to access CPLD
In-Reply-To: <1334223908-14690-1-git-send-email-s.hauer@pengutronix.de>
References: <1334223908-14690-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAMPhdO-+AVHmo40tzhADLysnenbD=72hgx5U6sv09HuA9haZ2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 5:45 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The pcm990 baseboard for the pcm027 module used to setup a static
> mapping for accessing the CPLD. It became illegal to call iotable_init
> that late. The pcm027 support is broken since then. This patch
> switches the cpld support to ioremap and removes all references to
> previous static mappings.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Looks good to me.

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
>
> Please consider applying for -rc since the board is currently broken.
>
> ?arch/arm/mach-pxa/include/mach/pcm990_baseboard.h | ? 68 +----------------
> ?arch/arm/mach-pxa/pcm990-baseboard.c ? ? ? ? ? ? ?| ? 83 +++++++++++++--------
> ?2 files changed, 52 insertions(+), 99 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
> index d727916..0260aaa 100644
> --- a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
> +++ b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
> @@ -31,7 +31,6 @@
> ?#define PCM990_CTRL_INT_IRQ ? ? ? ? ? ?PXA_GPIO_TO_IRQ(PCM990_CTRL_INT_IRQ_GPIO)
> ?#define PCM990_CTRL_INT_IRQ_EDGE ? ? ? IRQ_TYPE_EDGE_RISING
> ?#define PCM990_CTRL_PHYS ? ? ? ? ? ? ? PXA_CS1_PHYS ? ?/* 16-Bit */
> -#define PCM990_CTRL_BASE ? ? ? ? ? ? ? 0xea000000
> ?#define PCM990_CTRL_SIZE ? ? ? ? ? ? ? (1*1024*1024)
>
> ?#define PCM990_CTRL_PWR_IRQ_GPIO ? ? ? 14
> @@ -69,13 +68,13 @@
> ?#define PCM990_CTRL_MMC2DE ? ? 0x0004 ?/* R MMC2 Card detect */
> ?#define PCM990_CTRL_MMC2WP ? ? 0x0008 ?/* R MMC2 Card write protect */
>
> -#define PCM990_CTRL_REG6 ? ? ? 0x000C ?/* Interrupt Clear REGISTER */
> +#define PCM990_CTRL_INTSETCLR ?0x000C ?/* Interrupt Clear REGISTER */
> ?#define PCM990_CTRL_INTC0 ? ? ?0x0001 ?/* Clear Reg BT Detect */
> ?#define PCM990_CTRL_INTC1 ? ? ?0x0002 ?/* Clear Reg FR RI */
> ?#define PCM990_CTRL_INTC2 ? ? ?0x0004 ?/* Clear Reg MMC1 Detect */
> ?#define PCM990_CTRL_INTC3 ? ? ?0x0008 ?/* Clear Reg PM_5V off */
>
> -#define PCM990_CTRL_REG7 ? ? ? 0x000E ?/* Interrupt Enable REGISTER */
> +#define PCM990_CTRL_INTMSKENA ?0x000E ?/* Interrupt Enable REGISTER */
> ?#define PCM990_CTRL_ENAINT0 ? ?0x0001 ?/* Enable Int BT Detect */
> ?#define PCM990_CTRL_ENAINT1 ? ?0x0002 ?/* Enable Int FR RI */
> ?#define PCM990_CTRL_ENAINT2 ? ?0x0004 ?/* Enable Int MMC1 Detect */
> @@ -102,32 +101,6 @@
> ?#define PCM990_CTRL_ACPRES ? ? 0x0004 ?/* DC Present */
> ?#define PCM990_CTRL_ACALARM ? ?0x0008 ?/* Error Akku */
>
> -#define PCM990_CTRL_P2V(x) ? ? ((x) - PCM990_CTRL_PHYS + PCM990_CTRL_BASE)
> -#define PCM990_CTRL_V2P(x) ? ? ((x) - PCM990_CTRL_BASE + PCM990_CTRL_PHYS)
> -
> -#ifndef __ASSEMBLY__
> -# ?define __PCM990_CTRL_REG(x) \
> - ? ? ? ? ? ? ? (*((volatile unsigned char *)PCM990_CTRL_P2V(x)))
> -#else
> -# ?define __PCM990_CTRL_REG(x) PCM990_CTRL_P2V(x)
> -#endif
> -
> -#define PCM990_INTMSKENA __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG7)
> -#define PCM990_INTSETCLR __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG6)
> -#define PCM990_CTRL0 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG0)
> -#define PCM990_CTRL1 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG1)
> -#define PCM990_CTRL2 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG2)
> -#define PCM990_CTRL3 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG3)
> -#define PCM990_CTRL4 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG4)
> -#define PCM990_CTRL5 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG5)
> -#define PCM990_CTRL6 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG6)
> -#define PCM990_CTRL7 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG7)
> -#define PCM990_CTRL8 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG8)
> -#define PCM990_CTRL9 ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG9)
> -#define PCM990_CTRL10 ?__PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG10)
> -#define PCM990_CTRL11 ?__PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG11)
> -
> -
> ?/*
> ?* IDE
> ?*/
> @@ -166,24 +139,6 @@
> ?#define PCM990_IDE_PLD_P2V(x) ((x) - PCM990_IDE_PLD_PHYS + PCM990_IDE_PLD_BASE)
> ?#define PCM990_IDE_PLD_V2P(x) ((x) - PCM990_IDE_PLD_BASE + PCM990_IDE_PLD_PHYS)
>
> -#ifndef __ASSEMBLY__
> -# define ?__PCM990_IDE_PLD_REG(x) \
> - ? ? ? (*((volatile unsigned char *)PCM990_IDE_PLD_P2V(x)))
> -#else
> -# define ?__PCM990_IDE_PLD_REG(x) ? ? ?PCM990_IDE_PLD_P2V(x)
> -#endif
> -
> -#define PCM990_IDE0 \
> - ? ? ? __PCM990_IDE_PLD_REG(PCM990_IDE_PLD_PHYS + PCM990_IDE_PLD_REG0)
> -#define PCM990_IDE1 \
> - ? ? ? __PCM990_IDE_PLD_REG(PCM990_IDE_PLD_PHYS + PCM990_IDE_PLD_REG1)
> -#define PCM990_IDE2 \
> - ? ? ? __PCM990_IDE_PLD_REG(PCM990_IDE_PLD_PHYS + PCM990_IDE_PLD_REG2)
> -#define PCM990_IDE3 \
> - ? ? ? __PCM990_IDE_PLD_REG(PCM990_IDE_PLD_PHYS + PCM990_IDE_PLD_REG3)
> -#define PCM990_IDE4 \
> - ? ? ? __PCM990_IDE_PLD_REG(PCM990_IDE_PLD_PHYS + PCM990_IDE_PLD_REG4)
> -
> ?/*
> ?* Compact Flash
> ?*/
> @@ -196,10 +151,6 @@
> ?#define PCM990_CF_CD_EDGE ? ? ?IRQ_TYPE_EDGE_RISING
>
> ?#define PCM990_CF_PLD_PHYS ? ? 0x30000000 ? ? ?/* 16 bit wide */
> -#define PCM990_CF_PLD_BASE ? ? 0xef000000
> -#define PCM990_CF_PLD_SIZE ? ? (1*1024*1024)
> -#define PCM990_CF_PLD_P2V(x) ? ((x) - PCM990_CF_PLD_PHYS + PCM990_CF_PLD_BASE)
> -#define PCM990_CF_PLD_V2P(x) ? ((x) - PCM990_CF_PLD_BASE + PCM990_CF_PLD_PHYS)
>
> ?/* visible CPLD (U6) registers */
> ?#define PCM990_CF_PLD_REG0 ? ? 0x1000 ?/* OFFSET CF REGISTER 0 */
> @@ -239,21 +190,6 @@
> ?#define PCM990_CF_REG6_CD1 ? ? 0x0001 ?/* R CF Card_Detect1 */
> ?#define PCM990_CF_REG6_CD2 ? ? 0x0002 ?/* R CF Card_Detect2 */
>
> -#ifndef __ASSEMBLY__
> -# ?define ?__PCM990_CF_PLD_REG(x) \
> - ? ? ? (*((volatile unsigned char *)PCM990_CF_PLD_P2V(x)))
> -#else
> -# ?define ?__PCM990_CF_PLD_REG(x) ? ? ?PCM990_CF_PLD_P2V(x)
> -#endif
> -
> -#define PCM990_CF0 __PCM990_CF_PLD_REG(PCM990_CF_PLD_PHYS + PCM990_CF_PLD_REG0)
> -#define PCM990_CF1 __PCM990_CF_PLD_REG(PCM990_CF_PLD_PHYS + PCM990_CF_PLD_REG1)
> -#define PCM990_CF2 __PCM990_CF_PLD_REG(PCM990_CF_PLD_PHYS + PCM990_CF_PLD_REG2)
> -#define PCM990_CF3 __PCM990_CF_PLD_REG(PCM990_CF_PLD_PHYS + PCM990_CF_PLD_REG3)
> -#define PCM990_CF4 __PCM990_CF_PLD_REG(PCM990_CF_PLD_PHYS + PCM990_CF_PLD_REG4)
> -#define PCM990_CF5 __PCM990_CF_PLD_REG(PCM990_CF_PLD_PHYS + PCM990_CF_PLD_REG5)
> -#define PCM990_CF6 __PCM990_CF_PLD_REG(PCM990_CF_PLD_PHYS + PCM990_CF_PLD_REG6)
> -
> ?/*
> ?* Wolfson AC97 Touch
> ?*/
> diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
> index abab4e2..cb723e8 100644
> --- a/arch/arm/mach-pxa/pcm990-baseboard.c
> +++ b/arch/arm/mach-pxa/pcm990-baseboard.c
> @@ -65,6 +65,18 @@ static unsigned long pcm990_pin_config[] __initdata = {
> ? ? ? ?GPIO31_AC97_SYNC,
> ?};
>
> +static void __iomem *pcm990_cpld_base;
> +
> +static u8 pcm990_cpld_readb(unsigned int reg)
> +{
> + ? ? ? return readb(pcm990_cpld_base + reg);
> +}
> +
> +static void pcm990_cpld_writeb(u8 value, unsigned int reg)
> +{
> + ? ? ? writeb(value, pcm990_cpld_base + reg);
> +}
> +
> ?/*
> ?* pcm990_lcd_power - control power supply to the LCD
> ?* @on: 0 = switch off, 1 = switch on
> @@ -78,13 +90,13 @@ static void pcm990_lcd_power(int on, struct fb_var_screeninfo *var)
> ? ? ? ? ? ? ? ?/* enable LCD-Latches
> ? ? ? ? ? ? ? ? * power on LCD
> ? ? ? ? ? ? ? ? */
> - ? ? ? ? ? ? ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG3) =
> - ? ? ? ? ? ? ? ? ? ? ? PCM990_CTRL_LCDPWR + PCM990_CTRL_LCDON;
> + ? ? ? ? ? ? ? pcm990_cpld_writeb(PCM990_CTRL_LCDPWR + PCM990_CTRL_LCDON,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PCM990_CTRL_REG3);
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?/* disable LCD-Latches
> ? ? ? ? ? ? ? ? * power off LCD
> ? ? ? ? ? ? ? ? */
> - ? ? ? ? ? ? ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG3) = 0x00;
> + ? ? ? ? ? ? ? pcm990_cpld_writeb(0, PCM990_CTRL_REG3);
> ? ? ? ?}
> ?}
> ?#endif
> @@ -243,15 +255,26 @@ static unsigned long pcm990_irq_enabled;
> ?static void pcm990_mask_ack_irq(struct irq_data *d)
> ?{
> ? ? ? ?int pcm990_irq = (d->irq - PCM027_IRQ(0));
> - ? ? ? PCM990_INTMSKENA = (pcm990_irq_enabled &= ~(1 << pcm990_irq));
> +
> + ? ? ? pcm990_irq_enabled &= ~(1 << pcm990_irq);
> +
> + ? ? ? pcm990_cpld_writeb(pcm990_irq_enabled, PCM990_CTRL_INTMSKENA);
> ?}
>
> ?static void pcm990_unmask_irq(struct irq_data *d)
> ?{
> ? ? ? ?int pcm990_irq = (d->irq - PCM027_IRQ(0));
> + ? ? ? u8 val;
> +
> ? ? ? ?/* the irq can be acknowledged only if deasserted, so it's done here */
> - ? ? ? PCM990_INTSETCLR |= 1 << pcm990_irq;
> - ? ? ? PCM990_INTMSKENA ?= (pcm990_irq_enabled |= (1 << pcm990_irq));
> +
> + ? ? ? pcm990_irq_enabled |= (1 << pcm990_irq);
> +
> + ? ? ? val = pcm990_cpld_readb(PCM990_CTRL_INTSETCLR);
> + ? ? ? val |= 1 << pcm990_irq;
> + ? ? ? pcm990_cpld_writeb(val, PCM990_CTRL_INTSETCLR);
> +
> + ? ? ? pcm990_cpld_writeb(pcm990_irq_enabled, PCM990_CTRL_INTMSKENA);
> ?}
>
> ?static struct irq_chip pcm990_irq_chip = {
> @@ -261,7 +284,10 @@ static struct irq_chip pcm990_irq_chip = {
>
> ?static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
> ?{
> - ? ? ? unsigned long pending = (~PCM990_INTSETCLR) & pcm990_irq_enabled;
> + ? ? ? unsigned long pending;
> +
> + ? ? ? pending = ~pcm990_cpld_readb(PCM990_CTRL_INTSETCLR);
> + ? ? ? pending &= pcm990_irq_enabled;
>
> ? ? ? ?do {
> ? ? ? ? ? ? ? ?/* clear our parent IRQ */
> @@ -270,7 +296,8 @@ static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
> ? ? ? ? ? ? ? ? ? ? ? ?irq = PCM027_IRQ(0) + __ffs(pending);
> ? ? ? ? ? ? ? ? ? ? ? ?generic_handle_irq(irq);
> ? ? ? ? ? ? ? ?}
> - ? ? ? ? ? ? ? pending = (~PCM990_INTSETCLR) & pcm990_irq_enabled;
> + ? ? ? ? ? ? ? pending = ~pcm990_cpld_readb(PCM990_CTRL_INTSETCLR);
> + ? ? ? ? ? ? ? pending &= pcm990_irq_enabled;
> ? ? ? ?} while (pending);
> ?}
>
> @@ -285,8 +312,9 @@ static void __init pcm990_init_irq(void)
> ? ? ? ? ? ? ? ?set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> ? ? ? ?}
>
> - ? ? ? PCM990_INTMSKENA = 0x00; ? ? ? ?/* disable all Interrupts */
> - ? ? ? PCM990_INTSETCLR = 0xFF;
> + ? ? ? /* disable all Interrupts */
> + ? ? ? pcm990_cpld_writeb(0x0, PCM990_CTRL_INTMSKENA);
> + ? ? ? pcm990_cpld_writeb(0xff, PCM990_CTRL_INTSETCLR);
>
> ? ? ? ?irq_set_chained_handler(PCM990_CTRL_INT_IRQ, pcm990_irq_handler);
> ? ? ? ?irq_set_irq_type(PCM990_CTRL_INT_IRQ, PCM990_CTRL_INT_IRQ_EDGE);
> @@ -309,13 +337,16 @@ static int pcm990_mci_init(struct device *dev, irq_handler_t mci_detect_int,
> ?static void pcm990_mci_setpower(struct device *dev, unsigned int vdd)
> ?{
> ? ? ? ?struct pxamci_platform_data *p_d = dev->platform_data;
> + ? ? ? u8 val;
> +
> + ? ? ? val = pcm990_cpld_readb(PCM990_CTRL_REG5);
>
> ? ? ? ?if ((1 << vdd) & p_d->ocr_mask)
> - ? ? ? ? ? ? ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG5) =
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PCM990_CTRL_MMC2PWR;
> + ? ? ? ? ? ? ? val |= PCM990_CTRL_MMC2PWR;
> ? ? ? ?else
> - ? ? ? ? ? ? ? __PCM990_CTRL_REG(PCM990_CTRL_PHYS + PCM990_CTRL_REG5) =
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~PCM990_CTRL_MMC2PWR;
> + ? ? ? ? ? ? ? val &= ~PCM990_CTRL_MMC2PWR;
> +
> + ? ? ? pcm990_cpld_writeb(PCM990_CTRL_MMC2PWR, PCM990_CTRL_REG5);
> ?}
>
> ?static void pcm990_mci_exit(struct device *dev, void *data)
> @@ -481,23 +512,6 @@ static struct platform_device pcm990_camera[] = {
> ?#endif /* CONFIG_VIDEO_PXA27x ||CONFIG_VIDEO_PXA27x_MODULE */
>
> ?/*
> - * enable generic access to the base board control CPLDs U6 and U7
> - */
> -static struct map_desc pcm990_io_desc[] __initdata = {
> - ? ? ? {
> - ? ? ? ? ? ? ? .virtual ? ? ? ?= PCM990_CTRL_BASE,
> - ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(PCM990_CTRL_PHYS),
> - ? ? ? ? ? ? ? .length ? ? ? ? = PCM990_CTRL_SIZE,
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE ? ? /* CPLD */
> - ? ? ? }, {
> - ? ? ? ? ? ? ? .virtual ? ? ? ?= PCM990_CF_PLD_BASE,
> - ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(PCM990_CF_PLD_PHYS),
> - ? ? ? ? ? ? ? .length ? ? ? ? = PCM990_CF_PLD_SIZE,
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE ? ? /* CPLD */
> - ? ? ? }
> -};
> -
> -/*
> ?* system init for baseboard usage. Will be called by pcm027 init.
> ?*
> ?* Add platform devices present on this baseboard and init
> @@ -507,8 +521,11 @@ void __init pcm990_baseboard_init(void)
> ?{
> ? ? ? ?pxa2xx_mfp_config(ARRAY_AND_SIZE(pcm990_pin_config));
>
> - ? ? ? /* register CPLD access */
> - ? ? ? iotable_init(ARRAY_AND_SIZE(pcm990_io_desc));
> + ? ? ? pcm990_cpld_base = ioremap(PCM990_CTRL_PHYS, PCM990_CTRL_SIZE);
> + ? ? ? if (!pcm990_cpld_base) {
> + ? ? ? ? ? ? ? pr_err("pcm990: failed to ioremap cpld\n");
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
>
> ? ? ? ?/* register CPLD's IRQ controller */
> ? ? ? ?pcm990_init_irq();
> --
> 1.7.9.5
>
