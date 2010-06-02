From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Jun 2010 16:49:13 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <20100601165540.GC7123@oksana.dev.rtsoft.ru>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
	<20100601165540.GC7123@oksana.dev.rtsoft.ru>
Message-ID: <4C065349.80005@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Anton Vorontsov wrote:

> CNS3xxx chips have AHCI-compatible SATA controller. This patch adds
> the support using generic ahci_platform driver.

> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

[...]

> diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
> index 549ad0c..bf6044b 100644
> --- a/arch/arm/mach-cns3xxx/devices.c
> +++ b/arch/arm/mach-cns3xxx/devices.c
> @@ -14,14 +14,75 @@
>  #include <linux/init.h>
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> +#include <linux/ahci_platform.h>
>  #include <linux/mmc/host.h>
>  #include <linux/sdhci-pltfm.h>
>  #include "../../../drivers/mmc/host/sdhci.h"
> +#include "core.h"
>  #include "devices.h"
>  
>  /*
> + * AHCI
> + */
> +static int cns3xxx_ahci_init(struct device *dev)
> +{
> +	u32 tmp;
> +
> +	tmp = MISC_SATA_POWER_MODE;
> +	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
> +	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
> +	MISC_SATA_POWER_MODE = tmp;
> +
> +	/* Enable SATA PHY */
> +	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
> +	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
> +
> +	/* Enable SATA Clock */
> +	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
> +
> +	/* De-Asscer SATA Reset */
> +	tmp = PM_SOFT_RST_REG;
> +	tmp |= 0x1 << PM_SOFT_RST_REG_OFFST_SATA;

    You have *REG_OFFSET* everywhere, and *REG_OFFST* here -- a typo?

WBR, Sergei
