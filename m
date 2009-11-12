From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Nov 2009 20:55:28 +0000
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe
	bridge is present
In-Reply-To: <200911121519.42786.dk-arm-linux@gmx.de>
References: <200911121519.42786.dk-arm-linux@gmx.de>
Message-ID: <20091112205528.GA11304@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 03:19:42PM +0100, Dieter Kiermaier wrote:
> diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> index 77617c7..9e57326 100644
> --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
> @@ -14,6 +14,7 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mv643xx_eth.h>
> +#include <asm/io.h>

linux/io.h please (and please ensure future patches similarly use that
header rather than asm/io.h).  checkpatch will tell you this.

>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <mach/kirkwood.h>
> @@ -76,9 +77,19 @@ static void __init openrd_base_init(void)
>  
>  static int __init openrd_base_pci_init(void)
>  {
> +	u32 cpu_config_reg;
> +	void __iomem *base;
> +	base = ioremap(0xf1020100, 4);
> +	if (base)
> +	{

checkpatch will also tell you to put the opening brace on the previous line.
