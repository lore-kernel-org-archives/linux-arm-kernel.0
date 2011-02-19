From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 17:13:20 +0000
Subject: [PATCH V5 36/63] ST SPEAr : EMI (Extrenal Memory Interface)
	controller driver
In-Reply-To: <942264b07d606a02eb68561c7be559b6a4904961.1295499395.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<942264b07d606a02eb68561c7be559b6a4904961.1295499395.git.viresh.kumar@st.com>
Message-ID: <20110219171320.GO29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:56:14PM +0530, Viresh Kumar wrote:
> From: Vipin Kumar <vipin.kumar@st.com>


Subject: [PATCH V5 36/63] ST SPEAr : EMI (Extrenal Memory Interface)
        controller driver

"External"

> 2 SPEAr platform SoCs(spear310 and spear320) support an External Memory
> Interface controller. This controller is used to interface with
> Parallel NOR Flash devices.
> 
> This patch adds just the platform code needed for EMI (mainly EMI
> initialization). The driver being used is driver/mtd/maps/physmap.c
> 
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/mach-spear3xx/Makefile                |    4 +
>  arch/arm/mach-spear3xx/emi.c                   |  101 ++++++++++++++++++++++++
>  arch/arm/mach-spear3xx/include/mach/emi.h      |   64 +++++++++++++++
>  arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +
>  arch/arm/mach-spear3xx/include/mach/spear310.h |    9 ++
>  arch/arm/mach-spear3xx/include/mach/spear320.h |    6 ++
>  arch/arm/mach-spear3xx/spear310.c              |    9 ++
>  arch/arm/mach-spear3xx/spear310_evb.c          |   28 +++++++
>  arch/arm/mach-spear3xx/spear320.c              |    9 ++
>  arch/arm/mach-spear3xx/spear320_evb.c          |   27 ++++++
>  10 files changed, 259 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-spear3xx/emi.c
>  create mode 100644 arch/arm/mach-spear3xx/include/mach/emi.h
> 
> diff --git a/arch/arm/mach-spear3xx/Makefile b/arch/arm/mach-spear3xx/Makefile
> index b248624..d38ae47 100644
> --- a/arch/arm/mach-spear3xx/Makefile
> +++ b/arch/arm/mach-spear3xx/Makefile
> @@ -24,3 +24,7 @@ obj-$(CONFIG_MACH_SPEAR320) += spear320.o
>  
>  # spear320 boards files
>  obj-$(CONFIG_BOARD_SPEAR320_EVB) += spear320_evb.o
> +
> +# specific files
> +obj-$(CONFIG_MACH_SPEAR310) += emi.o
> +obj-$(CONFIG_MACH_SPEAR320) += emi.o
> diff --git a/arch/arm/mach-spear3xx/emi.c b/arch/arm/mach-spear3xx/emi.c
> new file mode 100644
> index 0000000..7b62ff0
> --- /dev/null
> +++ b/arch/arm/mach-spear3xx/emi.c
> @@ -0,0 +1,101 @@
> +/*
> + * arch/arm/mach-spear3xx/emi.c
> + *
> + * EMI (External Memory Interface) file
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar<vipin.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <mach/emi.h>
> +
> +int __init emi_init(struct platform_device *pdev, unsigned long base,
> +		u32 bank, u32 width)
> +{
> +	void __iomem *emi_reg_base;
> +	struct clk *clk;
> +	int ret;
> +
> +	if (bank > (EMI_MAX_BANKS - 1))
> +		return -EINVAL;
> +
> +	emi_reg_base = ioremap(base, EMI_REG_SIZE);
> +	if (!emi_reg_base)
> +		return -ENOMEM;
> +
> +	clk = clk_get(NULL, "emi");

What is the platform device pointer passed into this function?  It seems
unused - would using &pdev->dev here be appropriate?  Possibly not as it
seems to be the physmap device.

> +	if (IS_ERR(clk)) {
> +		iounmap(emi_reg_base);
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_enable(clk);
> +	if (ret) {
> +		iounmap(emi_reg_base);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Note: These are relaxed NOR device timings. Nor devices on spear
> +	 * eval machines are working fine with these timings. Specific board
> +	 * files can optimize these timings based on devices found on board.
> +	 */
> +	writel(0x10, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TAP_REG);
> +	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TSDP_REG);
> +	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPW_REG);
> +	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPR_REG);
> +	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDCS_REG);
> +
> +	switch (width) {
> +	case EMI_FLASH_WIDTH8:
> +		width = EMI_CNTL_WIDTH8;
> +		break;
> +
> +	case EMI_FLASH_WIDTH16:
> +		width = EMI_CNTL_WIDTH16;
> +		break;
> +
> +	case EMI_FLASH_WIDTH32:
> +		width = EMI_CNTL_WIDTH32;
> +		break;
> +	default:
> +		width = EMI_CNTL_WIDTH8;
> +		break;
> +	}
> +	/* set the data width */
> +	writel(width | EMI_CNTL_ENBBYTERW,
> +		emi_reg_base + (EMI_BANK_REG_SIZE * bank) + CTRL_REG);
> +
> +	/* disable all the acks */
> +	writel(0x3f, emi_reg_base + ack_reg);
> +
> +	iounmap(emi_reg_base);
> +
> +	return 0;
> +}
> +
> +void __init
> +emi_init_board_info(struct platform_device *pdev, struct resource *resources,
> +		int res_num, struct mtd_partition *partitions,
> +		unsigned int nr_partitions, unsigned int width)
> +{
> +	struct physmap_flash_data *emi_plat_data = dev_get_platdata(&pdev->dev);
> +
> +	pdev->resource = resources;
> +	pdev->num_resources = res_num;
> +
> +	if (partitions) {
> +		emi_plat_data->parts = partitions;
> +		emi_plat_data->nr_parts = nr_partitions;
> +	}
> +
> +	emi_plat_data->width = width;
> +}

I don't see why this has to be code rather than in the platform specific
files as static initializers.  Also, you seem to be passing stuff like
'EMI_FLASH_WIDTH32' in for 'width', which seems very odd as this is the
byte width.  I don't see why you need #defined constants for this.

It's waiting someone who doesn't realise that it has a proper meaning
to change it to an enum or something like that.

If you think the physmap flash API is lacking some definitions for this,
please talk to the MTD people.
