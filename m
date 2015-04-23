From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Apr 2015 09:43:55 +0200
Subject: [PATCH v2 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
In-Reply-To: <1429757950-28789-4-git-send-email-computersforpeace@gmail.com>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
 <1429757950-28789-4-git-send-email-computersforpeace@gmail.com>
Message-ID: <3096499.KSW6zqWKEA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 April 2015 19:59:08 Brian Norris wrote:
> Pretty straightforward driver, using the nice library-ization of the
> generic ahci_platform driver.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

There is an alternative way to do this, by writing a separate phy driver
for drivers/phy and using the generic ahci-platform driver. Have you
considered that as well? I don't know which approach works better here,
but in general we should try to have the generic driver handle as many
chips as possible.

> diff --git a/drivers/ata/sata_brcmstb.c b/drivers/ata/sata_brcmstb.c
> new file mode 100644
> index 000000000000..ab8d2261fa96
> --- /dev/null
> +++ b/drivers/ata/sata_brcmstb.c
> @@ -0,0 +1,285 @@
> +/*
> + * Broadcom SATA3 AHCI Controller Driver

Is this AHCI or not? Most AHCI drivers are called ahci_*.c, not sata_*.c


> +#ifdef __BIG_ENDIAN
> +#define DATA_ENDIAN			 2 /* AHCI->DDR inbound accesses */
> +#define MMIO_ENDIAN			 2 /* CPU->AHCI outbound accesses */
> +#else
> +#define DATA_ENDIAN			 0
> +#define MMIO_ENDIAN			 0
> +#endif

Is this for MIPS or ARM based chips or both? ARM SoCs should never care
about the endianess of the CPU, so I'd expect something like

#if defined(__BIG_ENDIAN) && defined(CONFIG_MIPS)
/* mips big-endian stuff */
#else
/* all other combinations */
#endif

> +static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
> +{
> +	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> +				(port * SATA_TOP_CTRL_PHY_OFFS);
> +	void __iomem *p;
> +	u32 reg;
> +
> +	/* clear PHY_DEFAULT_POWER_STATE */
> +	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
> +	reg = __raw_readl(p);
> +	reg &= ~SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE;
> +	__raw_writel(reg, p);

Similarly, the use of __raw_readl() is broken on ARM here and won't
work on big-endian kernels. Better use a driver specific helper
function that does the right thing based on the architecture and
endianess. You can use the same conditional as above and do

#if defined(__BIG_ENDIAN) && defined(CONFIG_MIPS)

static inline brcm_sata_phy_read(struct brcm_ahci_phy *priv, int port int reg)
{
	void __iomem *phyctrl = priv->regs;

	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
		return __raw_readl(regs->reg);

	return readl_relaxed(regs->reg);
}

> +static const struct of_device_id ahci_of_match[] = {
> +	{.compatible = "brcm,sata3-ahci"},
> +	{},

This sounds awefully generic. Can you guarantee that no part of Broadcom
has produced another ahci-like SATA3 controller in the past, or will
have one in the future?

If not, please be more specific here, and use the internal specifier for
this version of the IP block. If you can't find out what that is, use the
identifier for the oldest chip you know that has it.

	Arnd
