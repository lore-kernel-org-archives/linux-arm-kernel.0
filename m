From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 03 Dec 2010 20:37:31 +0900
Subject: [PATCH 1/2] ARM: SAMSUNG: Convert irq-uart to use new irq_
	functions
In-Reply-To: <1290783085-20098-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290783085-20098-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <015601cb92de$7b6913b0$723b3b10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Convert to the new irq_ versions of the IRQ operations. As well as
> the textual substituion of irq_data for the raw IRQ number we also
> convert the register base lookup to in s3c_irq_uart_base() to pick
> the irq_data up directly.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-samsung/irq-uart.c |   36
++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-
> uart.c
> index 4f8c102..da31d78 100644
> --- a/arch/arm/plat-samsung/irq-uart.c
> +++ b/arch/arm/plat-samsung/irq-uart.c
> @@ -28,9 +28,9 @@
>   * are consecutive when looking up the interrupt in the demux routines.
>   */
> 
> -static inline void __iomem *s3c_irq_uart_base(unsigned int irq)
> +static inline void __iomem *s3c_irq_uart_base(struct irq_data *data)
>  {
> -	struct s3c_uart_irq *uirq = get_irq_chip_data(irq);
> +	struct s3c_uart_irq *uirq = data->chip_data;
>  	return uirq->regs;
>  }
> 
> @@ -39,10 +39,10 @@ static inline unsigned int s3c_irq_uart_bit(unsigned
int
> irq)
>  	return irq & 3;
>  }
> 
> -static void s3c_irq_uart_mask(unsigned int irq)
> +static void s3c_irq_uart_mask(struct irq_data *data)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(data);
> +	unsigned int bit = s3c_irq_uart_bit(data->irq);
>  	u32 reg;
> 
>  	reg = __raw_readl(regs + S3C64XX_UINTM);
> @@ -50,10 +50,10 @@ static void s3c_irq_uart_mask(unsigned int irq)
>  	__raw_writel(reg, regs + S3C64XX_UINTM);
>  }
> 
> -static void s3c_irq_uart_maskack(unsigned int irq)
> +static void s3c_irq_uart_maskack(struct irq_data *data)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(data);
> +	unsigned int bit = s3c_irq_uart_bit(data->irq);
>  	u32 reg;
> 
>  	reg = __raw_readl(regs + S3C64XX_UINTM);
> @@ -62,10 +62,10 @@ static void s3c_irq_uart_maskack(unsigned int irq)
>  	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
>  }
> 
> -static void s3c_irq_uart_unmask(unsigned int irq)
> +static void s3c_irq_uart_unmask(struct irq_data *data)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(data);
> +	unsigned int bit = s3c_irq_uart_bit(data->irq);
>  	u32 reg;
> 
>  	reg = __raw_readl(regs + S3C64XX_UINTM);
> @@ -73,10 +73,10 @@ static void s3c_irq_uart_unmask(unsigned int irq)
>  	__raw_writel(reg, regs + S3C64XX_UINTM);
>  }
> 
> -static void s3c_irq_uart_ack(unsigned int irq)
> +static void s3c_irq_uart_ack(struct irq_data *data)
>  {
> -	void __iomem *regs = s3c_irq_uart_base(irq);
> -	unsigned int bit = s3c_irq_uart_bit(irq);
> +	void __iomem *regs = s3c_irq_uart_base(data);
> +	unsigned int bit = s3c_irq_uart_bit(data->irq);
> 
>  	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
>  }
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
> --

Looks ok to me...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
