From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Jun 2010 13:26:48 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <20100601165540.GC7123@oksana.dev.rtsoft.ru>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
	<20100601165540.GC7123@oksana.dev.rtsoft.ru>
Message-ID: <4C0623D8.6030701@ru.mvista.com>
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

    Why aren't you using I/O accessors?

WBR, Sergei
