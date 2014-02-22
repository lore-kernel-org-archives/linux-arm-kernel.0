From: tj@kernel.org (Tejun Heo)
Date: Sat, 22 Feb 2014 15:40:29 -0500
Subject: [PATCH v7 07/15] ARM: sunxi: Add support for Allwinner SUNXi
 SoCs sata to ahci_platform
In-Reply-To: <1393084424-31099-8-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-8-git-send-email-hdegoede@redhat.com>
Message-ID: <20140222204029.GB16272@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 04:53:36PM +0100, Hans de Goede wrote:
...
> +static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
> +{
> +	u32 reg_val;
> +	int timeout;
> +
> +	/* This magic is from the original code */
> +	writel(0, reg_base + AHCI_RWCR);
> +	mdelay(5);
> +
> +	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> +			 (0x7 << 24),
> +			 (0x5 << 24) | BIT(23) | BIT(18));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
> +			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
> +			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
> +	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
> +	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> +			 (0x7 << 20), (0x3 << 20));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
> +			 (0x1f << 5), (0x19 << 5));
> +	mdelay(5);

Please use msleep() instead.  This is called with full process
context.  mdelay() is almost always wrong.  Even if the hardware is
broken enough to require millisec level breather, the better thing to
do would be using threaded handler and using msleep(), not mdelay().

Thanks.

-- 
tejun
