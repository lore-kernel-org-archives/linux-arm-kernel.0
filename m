From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 8 Dec 2010 08:21:51 +0100
Subject: [PATCH v2 07/15] ARM: mxs: Add gpio support
In-Reply-To: <1291739523-25077-6-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-6-git-send-email-shawn.guo@freescale.com>
Message-ID: <19711.12815.128304.234766@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> MXS-based SoCs implement gpio support in block PINCTRL.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v2:
>  - Create arch/arm/mach-mxs/gpio.h to accommodate stuff private for mach-mxs
>  - Use GPIO_INT_LEV_MASK and GPIO_INT_POL_MASK instead of constant
>  - Remove both edges IRQ support which is not needed
>  - Use SET and CLR register of PINCTRL_DOE in _set_gpio_direction()
>  - Use pr_info over printk(KERN_INFO)
> 
>  arch/arm/mach-mxs/gpio.c              |  331 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/gpio.h              |   36 ++++
>  arch/arm/mach-mxs/include/mach/gpio.h |   35 ++++
>  3 files changed, 402 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/gpio.c
>  create mode 100644 arch/arm/mach-mxs/gpio.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
> 
> diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
> new file mode 100644
> index 0000000..6db7541
> --- /dev/null
> +++ b/arch/arm/mach-mxs/gpio.c
[...]
> +static void mxs_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +	struct mxs_gpio_port *port =
> +		container_of(chip, struct mxs_gpio_port, chip);
> +	u32 l;
> +	unsigned long flags;
> +	void __iomem *reg = port->base + PINCTRL_DOUT(port->id);
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);
> +	__raw_writel(l, reg);
> +	spin_unlock_irqrestore(&port->lock, flags);
Why not:
	__raw_writel(1 << offset, reg + (value ? MXS_SET_ADDR : MXS_CLR_ADDR));
which would not even need any locking.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
