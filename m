From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 6 Jul 2011 21:22:52 +0530
Subject: [PATCH v2] davinci: da850 EVM: read mac address from SPI flash
In-Reply-To: <1309784838-30903-1-git-send-email-sudhakar.raj@ti.com>
References: <1309784838-30903-1-git-send-email-sudhakar.raj@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D9B4C96@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudhakar,

On Mon, Jul 04, 2011 at 18:37:18, Rajashekhara, Sudhakar wrote:
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
> Since v1:
>      Guarded registering the mtd_notifier only when MTD is enabled.
>      Earlier this was handled using mtd_has_partitions() call, but
>      this has been removed in Linux v3.0.

Current trend is to include the change log into the
commit message itself. It might be useful to examine
at a later time what transformation the patch went
through. It also simplifies things for you since you
don't have to maintain this separately.

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

The function and data structure above are not required
when CONFIG_MTD is not defined so these should be
under #ifdef CONFIG_MTD too. Towards this..

> +#ifdef CONFIG_MTD
> +static void da850_evm_register_mtd_user(struct mtd_notifier *notify)
> +{
> +	register_mtd_user(notify);
> +}

.. rename this function as something like da850_evm_setup_mac_addr() and
make it take void as argument and use:

	register_mtd_user(&da850evm_spi_notifier);

Thanks,
Sekhar

> +#else
> +static void da850_evm_register_mtd_user(struct mtd_notifier *notify) { }
> +#endif
> +
>  static __init void da850_evm_init(void)
>  {
>  	int ret;
> @@ -1237,6 +1263,8 @@ static __init void da850_evm_init(void)
>  	if (ret)
>  		pr_warning("da850_evm_init: spi 1 registration failed: %d\n",
>  				ret);
> +
> +	da850_evm_register_mtd_user(&da850evm_spi_notifier);
>  }
>  
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
> -- 
> 1.7.1
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
