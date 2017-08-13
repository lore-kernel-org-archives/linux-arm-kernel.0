From: bp@alien8.de (Borislav Petkov)
Date: Sun, 13 Aug 2017 15:02:02 +0200
Subject: [PATCH v2 4/6] edac: synopsys: Add ECC error injection support
In-Reply-To: <738dd1ea12078f98e91d782b3266a41f7918f922.1502091561.git.michal.simek@xilinx.com>
References: <91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek@xilinx.com>
 <738dd1ea12078f98e91d782b3266a41f7918f922.1502091561.git.michal.simek@xilinx.com>
Message-ID: <20170813130202.GA24994@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 09:39:26AM +0200, Michal Simek wrote:
> @@ -181,6 +187,38 @@
>  #define MEM_TYPE_DDR4	0x10
>  #define MEM_TYPE_LPDDR4	0x10
>  
> +/* DDRC Software control register */
> +#define DDRC_SWCTL	0x320
> +
> +/* DDRC ECC CE & UE poison mask */
> +#define ECC_CEPOISON_MASK	0x3
> +#define ECC_UEPOISON_MASK	0x1
> +
> +/* DDRC Device config masks */
> +#define DDRC_MSTR_DEV_CONFIG_MASK	0xC0000000
> +#define DDRC_MSTR_DEV_CONFIG_SHIFT	30
> +#define DDRC_MSTR_DEV_CONFIG_X4_MASK	0
> +#define DDRC_MSTR_DEV_CONFIG_X8_MASK	1
> +#define DDRC_MSTR_DEV_CONFIG_X16_MASK	0x10
> +#define DDRC_MSTR_DEV_CONFIG_X32_MASK	0X11

Ox

> +
> +/* DDR4 and DDR3 device Row,Column,Bank Mapping */
> +#define DDR4_COL_SHIFT		3
> +#define DDR4_BANKGRP_SHIFT	13
> +#define DDR4_BANK_SHIFT		15
> +#define DDR4_ROW_SHIFT		17
> +#define DDR4_COL_MASK		0x3FF
> +#define DDR4_BANKGRP_MASK	0x3
> +#define DDR4_BANK_MASK		0x3
> +#define DDR4_ROW_MASK		0x7FFF
> +
> +#define DDR3_COL_SHIFT		3
> +#define DDR3_BANK_SHIFT		13
> +#define DDR3_ROW_SHIFT		16
> +#define DDR3_COL_MASK		0x3FF
> +#define DDR3_BANK_MASK		0x7
> +#define DDR3_ROW_MASK		0x3FFF
> +
>  /**
>   * struct ecc_error_info - ECC error log information
>   * @row:	Row number
> @@ -223,6 +261,7 @@ struct synps_ecc_status {
>   * @p_data:	Pointer to platform data
>   * @ce_cnt:	Correctable Error count
>   * @ue_cnt:	Uncorrectable Error count
> + * @poison_addr: Data poison address
>   */
>  struct synps_edac_priv {
>  	void __iomem *baseaddr;
> @@ -231,6 +270,7 @@ struct synps_edac_priv {
>  	const struct synps_platform_data *p_data;
>  	u32 ce_cnt;
>  	u32 ue_cnt;
> +	ulong poison_addr;

unsigned long

Also, this error injection interface needs to go to debugfs and be
behind CONFIG_EDAC_DEBUG. We don't want error injection capability
present on production systems.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
