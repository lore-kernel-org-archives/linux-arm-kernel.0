From: stefan@agner.ch (Stefan Agner)
Date: Thu, 14 May 2015 17:40:01 +0200
Subject: [RFC 2/2] ARM: vf610: Add SoC bus support for Vybrid
In-Reply-To: <f0e54048cd94eb223d831f9a466e1f7a149018ec.1431319599.git.maitysanchayan@gmail.com>
References: <cover.1431319599.git.maitysanchayan@gmail.com>
 <f0e54048cd94eb223d831f9a466e1f7a149018ec.1431319599.git.maitysanchayan@gmail.com>
Message-ID: <1621888acb33854d6e950b77057f59ed@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanchayan,

The implementation looks good from my perspective. While the output
differs a bit from what i.MX6 provides, I think its closer to what is
specified. Also I like that we have the ROM revision available, since
this information is relevant to identify early versions of the chip
which have had issues...

Some minor things below.

On 2015-05-11 07:11, Sanchayan Maity wrote:
> Implements SoC bus support to export SoC specific information. Read
> the unique SoC ID from the Vybrid On Chip One Time Programmable (OCOTP)
> controller, SoC specific information from the Miscellaneous System
> Control Module (MSCM), revision from the ROM revision register and
> expose it via the SoC bus infrastructure.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/mach-imx/mach-vf610.c | 76 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
> index 1ba7738..74681f1 100644
> --- a/arch/arm/mach-imx/mach-vf610.c
> +++ b/arch/arm/mach-imx/mach-vf610.c
> @@ -9,13 +9,87 @@
>  
>  #include <linux/of_platform.h>
>  #include <linux/irqchip.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/random.h>
> +#include <linux/io.h>
>  #include <asm/mach/arch.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include "common.h"
>  
> +#define OCOTP_CFG0_OFFSET      0x00000410
> +#define OCOTP_CFG1_OFFSET      0x00000420
> +#define MSCM_CPxCOUNT_OFFSET   0x0000002C
> +#define MSCM_CPxCFG1_OFFSET    0x00000014
> +#define ROM_REVISION_REGISTER  0x00000080
> +
>  static void __init vf610_init_machine(void)
>  {
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	struct regmap *ocotp_regmap, *mscm_regmap;
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct device *parent = NULL;
> +	struct soc_device *soc_dev;
> +	char soc_type[] = "xx0";
> +	void __iomem *rom_rev;
> +	u32 cpxcount, cpxcfg1;
> +	u32 soc_id1, soc_id2;
> +	u64 soc_id;
> +
> +	ocotp_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-ocotp");
> +	if (IS_ERR(ocotp_regmap)) {
> +		pr_err("regmap lookup for octop failed\n");
> +		goto out;
> +	}
> +
> +	mscm_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-mscm-cpucfg");
> +	if (IS_ERR(mscm_regmap)) {
> +		pr_err("regmap lookup for mscm failed");
> +		goto out;
> +	}
> +
> +	regmap_read(ocotp_regmap, OCOTP_CFG0_OFFSET, &soc_id1);
> +	regmap_read(ocotp_regmap, OCOTP_CFG1_OFFSET, &soc_id2);
> +
> +	soc_id = (u64) soc_id1 << 32 | soc_id2;
> +	add_device_randomness(&soc_id, sizeof(soc_id));
> +
> +	regmap_read(mscm_regmap, MSCM_CPxCOUNT_OFFSET, &cpxcount);
> +	regmap_read(mscm_regmap, MSCM_CPxCFG1_OFFSET, &cpxcfg1);
> +
> +	soc_type[0] = cpxcount ? '6' : '5'; /* Dual Core => VF6x0 */
> +	soc_type[1] = cpxcfg1 ? '1' : '0'; /* L2 Cache => VFx10 */
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		goto out;

This out seems not to take care of the memory allocated just above.

> +
> +	soc_dev_attr->machine = kasprintf(GFP_KERNEL, "Freescale Vybrid");
> +	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%llx", soc_id);

I would prefer %016llx as format, that shows that we have 64 bit
identifier even when the highest bit is 0.

> +	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Freescale Vybrid VF%s",
> +								 soc_type);
> +
> +	rom_rev = ioremap(ROM_REVISION_REGISTER, SZ_1);
> +	if (rom_rev)
> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%08x",
> +						readl(rom_rev));

We should add the ROM to the device tree too. The memory map documented
in the RM states that the ROM is accessable at 0x0000_0000-0x007fffff,
that would be 8MiB. However, according to the RM, the on-chip ROM is
only 96KiB. I quickly checked, U-Boot crashed when reading after
0x00018000, which is the 96KiB boundary, hence I would add a DT node
with compatible fsl,vf610-ocrom or something which has a register range
from 0x0-0x00017fff.

> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		if (!rom_rev)
> +			kfree(soc_dev_attr->revision);
> +		kfree(soc_dev_attr->family);
> +		kfree(soc_dev_attr->soc_id);
> +		kfree(soc_dev_attr->machine);
> +		kfree(soc_dev_attr);
> +		goto out;
> +	}
> +
> +	parent = soc_device_to_device(soc_dev);
> +
> +out:
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
>  	vf610_pm_init();
>  }
