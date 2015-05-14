From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 13 May 2015 22:25:29 -0500
Subject: [PATCH 1/4] edac, altera: Generalize driver to use DT Memory size
In-Reply-To: <1431553787-27741-2-git-send-email-tthayer@opensource.altera.com>
References: <1431553787-27741-1-git-send-email-tthayer@opensource.altera.com>
 <1431553787-27741-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <555415A9.8030408@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/13/15 4:49 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> The Arria10 SOC uses a completely different SDRAM controller from the
> earlier CycloneV and ArriaV SoCs. The memory size is calculated in
> the bootloader and passed via the device tree. Using this device
> tree size is more generic than using the register fields to
> calculate the memory size for different SDRAM controllers.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  drivers/edac/altera_edac.c |   53 ++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 3c4929f..e18a205 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -219,36 +219,35 @@ static void altr_sdr_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
>  {}
>  #endif
>  
> -/* Get total memory size in bytes */
> -static u32 altr_sdram_get_total_mem_size(struct regmap *mc_vbase)
> +/* Get total memory size from Open Firmware DTB */
> +static unsigned long get_total_mem(void)
>  {
> -	u32 size, read_reg, row, bank, col, cs, width;
> +	struct device_node *np = NULL;
> +	const unsigned int *reg, *reg_end;
> +	int len, sw, aw;
> +	unsigned long start, size, total_mem;
>  
> -	if (regmap_read(mc_vbase, DRAMADDRW_OFST, &read_reg) < 0)
> +	np = of_find_node_by_type(NULL, "memory");
> +	if (!np)
>  		return 0;
>  
> -	if (regmap_read(mc_vbase, DRAMIFWIDTH_OFST, &width) < 0)
> -		return 0;
> -
> -	col = (read_reg & DRAMADDRW_COLBIT_MASK) >>
> -		DRAMADDRW_COLBIT_SHIFT;
> -	row = (read_reg & DRAMADDRW_ROWBIT_MASK) >>
> -		DRAMADDRW_ROWBIT_SHIFT;
> -	bank = (read_reg & DRAMADDRW_BANKBIT_MASK) >>
> -		DRAMADDRW_BANKBIT_SHIFT;
> -	cs = (read_reg & DRAMADDRW_CSBIT_MASK) >>
> -		DRAMADDRW_CSBIT_SHIFT;
> -
> -	/* Correct for ECC as its not addressible */
> -	if (width == DRAMIFWIDTH_32B_ECC)
> -		width = 32;
> -	if (width == DRAMIFWIDTH_16B_ECC)
> -		width = 16;
> -
> -	/* calculate the SDRAM size base on this info */
> -	size = 1 << (row + bank + col);
> -	size = size * cs * (width / 8);
> -	return size;
> +	aw = of_n_addr_cells(np);
> +	sw = of_n_size_cells(np);
> +	reg = (const unsigned int *)of_get_property(np, "reg", &len);
> +	reg_end = reg + (len / sizeof(u32));
> +
> +	total_mem = 0;
> +	do {
> +		start = of_read_number(reg, aw);
> +		reg += aw;
> +		size = of_read_number(reg, sw);
> +		reg += sw;
> +		total_mem += size;
> +	} while (reg < reg_end);
> +
> +	of_node_put(np);
> +	edac_printk(KERN_ERR, EDAC_MC, "total_mem 0x%lx\n", total_mem);

Use edac_dbg() here.

Dinh
