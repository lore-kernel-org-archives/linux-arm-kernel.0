From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Jun 2011 23:16:56 +0530
Subject: [PATCH] davinci: da850 EVM: read mac address from SPI flash
In-Reply-To: <1307538155-27197-1-git-send-email-sudhakar.raj@ti.com>
References: <1307538155-27197-1-git-send-email-sudhakar.raj@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D625BDC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudhakar,

On Wed, Jun 08, 2011 at 18:32:35, Rajashekhara, Sudhakar wrote:
> DA850/OMAP-L138 EMAC driver uses random mac address instead of
> a fixed one because the mac address is not stuffed into EMAC
> platform data.
> 
> This patch provides a function which reads the mac address
> stored in SPI flash (registered as MTD device) and populates the
> EMAC platform data. The function which reads the mac address is
> registered as a callback which gets called upon addition of MTD
> device.
> 
> NOTE: In case the MAC address stored in SPI flash is erased, follow
> the instructions at [1] to restore it.
> 
> [1] http://processors.wiki.ti.com/index.php/GSG:_OMAP-L138_DVEVM_Additional_Procedures#Restoring_MAC_address_on_SPI_Flash
> 
> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index a7b41bf..3ff64b8 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -115,6 +115,23 @@ static struct spi_board_info da850evm_spi_info[] = {
>  	},
>  };
>  
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
> +
>  static struct mtd_partition da850_evm_norflash_partition[] = {
>  	{
>  		.name           = "bootloaders + env",
> @@ -1237,6 +1254,9 @@ static __init void da850_evm_init(void)
>  	if (ret)
>  		pr_warning("da850_evm_init: spi 1 registration failed: %d\n",
>  				ret);
> +
> +	if (mtd_has_partitions())
> +		register_mtd_user(&da850evm_spi_notifier);

The v3.0 merge removes mtd_has_partitions() so this fails
to build. Can you please fix and re-submit?

Thanks,
Sekhar
