From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jan 2014 12:12:50 +0100
Subject: [PATCHv8 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1388656624-26570-2-git-send-email-Li.Xiubo@freescale.com>
References: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
 <1388656624-26570-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <3716216.GQHQhxMFvx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 January 2014 17:57:01 Xiubo Li wrote:
> +static inline u32 ftm_readl(bool big_endian, const void __iomem *addr)
> +{
> +       u32 val;
> +
> +       val = __raw_readl(addr);
> +
> +       if (likely(big_endian))
> +               val = be32_to_cpu((__force __be32)val);
> +       else
> +               val = le32_to_cpu((__force __le32)val);
> +       rmb();
> +
> +       return val;
> +}
> +
> +static inline void ftm_writel(bool big_endian, u32 val, void __iomem *addr)
> +{
> +       wmb();
> +       if (likely(big_endian))
> +               val = (__force u32)cpu_to_be32(val);
> +       else
> +               val = (__force u32)cpu_to_le32(val);
> +
> +       __raw_writel(val, addr);

These functions definitely need some comments regarding why this is necessary.
I assume that after 8 rounds of review (that I did not read) this has been
discussed already, so please explain above the functions why you don't just
use ioread32be/ioread32 and iowrite32be/iowrite32 here.

Also all callers seem to be of the style

       val = ftm_readl(fpc->big_endian, fpc->base + FTM_SC);

so I wonder why you don't just pass the fpc pointer to the function
and make it

static inline void ftm_readl(struct fsl_pwm_chip *fpc, unsigned long reg, u32 val)
{
	if (fpc->big_endian)
		iowrite32be(val, fpc->base + reg);
	else
		iowrite32(val, fpc->base + reg);
}

	Arnd
