From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 11 Jul 2011 18:02:55 +0530
Subject: [PATCH v3] davinci: da850 EVM: read mac address from SPI flash
In-Reply-To: <1310376501-14189-1-git-send-email-sudhakar.raj@ti.com>
References: <1310376501-14189-1-git-send-email-sudhakar.raj@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DA7AA0C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudhakar,

On Mon, Jul 11, 2011 at 14:58:21, Rajashekhara, Sudhakar wrote:

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index a7b41bf..5bb6556 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -115,6 +115,25 @@ static struct spi_board_info da850evm_spi_info[] = {
>  	},
>  };
>  
> +#ifdef CONFIG_MTD
> +static void da850_evm_m25p80_notify_add(struct mtd_info *mtd)
> +{
> +	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
> +	size_t retlen;
> +
> +	if (!strcmp(mtd->name, "MAC-Address")) {
> +		mtd->read(mtd, 0, ETH_ALEN, &retlen, mac_addr);
> +		if (retlen == ETH_ALEN)
> +			pr_info("Read MAC addr from SPI Flash: %pM\n",
> +				mac_addr);
> +	}
> +}
> +
> +static struct mtd_notifier da850evm_spi_notifier = {
> +	.add	= da850_evm_m25p80_notify_add,
> +};
> +#endif
> +
>  static struct mtd_partition da850_evm_norflash_partition[] = {
>  	{
>  		.name           = "bootloaders + env",
> @@ -1117,6 +1136,15 @@ static __init int da850_evm_init_cpufreq(void)
>  static __init int da850_evm_init_cpufreq(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_MTD
> +static void da850_evm_setup_mac_addr(void)
> +{
> +	register_mtd_user(&da850evm_spi_notifier);
> +}
> +#else
> +static void da850_evm_setup_mac_addr(void) { }
> +#endif

Why not combine this ifdef construct with
earlier one?

Rest of it looks good to me.

Thanks,
Sekhar
