From: tbm@cyrius.com (Martin Michlmayr)
Date: Sat, 19 Jun 2010 15:06:29 +0100
Subject: [PATCH] orion/kirkwood: reset PCIe unit on boot
In-Reply-To: <1276029158-22159-1-git-send-email-razzor@kopf-tisch.de>
References: <1276029158-22159-1-git-send-email-razzor@kopf-tisch.de>
Message-ID: <20100619140628.GP1573@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olaf Rempel <razzor@kopf-tisch.de> [2010-06-08 22:32]:
> Patch found in QNAPs vendor source package, with some cleanups
> (proper defines, shortened max. timeout from 1s to 200ms).
> 
> Without this patch the PCIe SATA controller (Marvell 88sx7042/sata_mv)
> in my QNAP TS-419P (Marvell 88f6281/Kirkwood) stops working after a
> few minutes.
> The symptomes are described in this thread:
> http://marc.info/?l=linux-ide&m=124822863706181&w=2

Nico, Saeed: do you have any comments on this patch?

A number of Debian users ran into this issue so I'm glad Olaf found a
solution.


> ---
>  arch/arm/plat-orion/pcie.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
> index 54c84a4..779553a 100644
> --- a/arch/arm/plat-orion/pcie.c
> +++ b/arch/arm/plat-orion/pcie.c
> @@ -13,6 +13,7 @@
>  #include <linux/mbus.h>
>  #include <asm/mach/pci.h>
>  #include <plat/pcie.h>
> +#include <linux/delay.h>
>  
>  /*
>   * PCIe unit register offsets.
> @@ -46,6 +47,8 @@
>  #define  PCIE_STAT_BUS_OFFS		8
>  #define  PCIE_STAT_BUS_MASK		0xff
>  #define  PCIE_STAT_LINK_DOWN		1
> +#define PCIE_DEBUG_CTRL         0x1a60
> +#define  PCIE_DEBUG_SOFT_RESET		(1<<20)
>  
>  
>  u32 __init orion_pcie_dev_id(void __iomem *base)
> @@ -85,6 +88,32 @@ void __init orion_pcie_set_local_bus_nr(void __iomem *base, int nr)
>  	writel(stat, base + PCIE_STAT_OFF);
>  }
>  
> +void __init orion_pcie_reset(void __iomem *base)
> +{
> +	u32 reg;
> +	int i;
> +
> +	/*
> +	 * MV-S104860-U0, Rev. C:
> +	 * PCI Express Unit Soft Reset
> +	 * When set, generates an internal reset in the PCI Express unit.
> +	 * This bit should be cleared after the link is re-established.
> +	 */
> +	reg = readl(base + PCIE_DEBUG_CTRL);
> +	reg |= PCIE_DEBUG_SOFT_RESET;
> +	writel(reg, base + PCIE_DEBUG_CTRL);
> +
> +	for (i = 0; i < 20; i++) {
> +		mdelay(10);
> +
> +		if (orion_pcie_link_up(base))
> +			break;
> +	}
> +
> +	reg &= ~(PCIE_DEBUG_SOFT_RESET);
> +	writel(reg, base + PCIE_DEBUG_CTRL);
> +}
> +
>  /*
>   * Setup PCIE BARs and Address Decode Wins:
>   * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
> @@ -153,6 +182,11 @@ void __init orion_pcie_setup(void __iomem *base,
>  	u32 mask;
>  
>  	/*
> +	 * soft reset PCIe unit
> +	 */
> +	orion_pcie_reset(base);
> +
> +	/*
>  	 * Point PCIe unit MBUS decode windows to DRAM space.
>  	 */
>  	orion_pcie_setup_wins(base, dram);
> -- 
> 1.6.3.3

-- 
Martin Michlmayr
http://www.cyrius.com/
