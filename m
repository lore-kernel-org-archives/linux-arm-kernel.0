From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 18 Jul 2014 15:17:45 +0200
Subject: [PATCH v10 4/8] ata: libahci: allow to use multiple PHYs
In-Reply-To: <1405686607-8126-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140718151745.0b0114a9@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Antoine T?nart wrote:
> The current implementation of the libahci does not allow to use multiple
> PHYs. This patch adds the support of multiple PHYs by the libahci while
> keeping the old bindings valid for device tree compatibility.
> 
> This introduce a new way of defining SATA ports in the device tree, with
> one port per sub-node. This as the advantage of allowing a per port
> configuration. Because some ports may be accessible but disabled in the
> device tree, the port_map mask is computed automatically when using
> this.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  drivers/ata/ahci.h             |   3 +-
>  drivers/ata/libahci_platform.c | 179 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 142 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index cb8d58926851..b0ea7b077d6e 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -332,7 +332,8 @@ struct ahci_host_priv {
>  	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
>  	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
>  	struct regulator	*target_pwr;	/* Optional */
> -	struct phy		*phy;		/* If platform uses phy */
> +	struct phy		**phys;		/* If platform uses phys */
> +	unsigned		nphys;		/* Number of phys */
>  	void			*plat_data;	/* Other platform data */
>  	/*
>  	 * Optional ahci_start_engine override, if not set this gets set to the
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index db9b90d876dd..2c2439b4101d 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -39,6 +39,61 @@ static struct scsi_host_template ahci_platform_sht = {
>  };
>  
>  /**
> + * ahci_platform_enable_phys - Enable PHYs
> + * @hpriv: host private area to store config values
> + *
> + * This function enables all the PHYs found in hpriv->phys, if any.
> + * If a PHY fails to be enabled, it disables all the PHYs already
> + * enabled in reverse order and returns an error.
> + *
> + * RETURNS:
> + * 0 on success otherwise a negative error code
> + */
> +int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
> +{
> +	int i, rc = 0;
> +
You shouldn't have to initialize rc here, or does your gcc falsely
complain about an uninitialized variable if you don't?

> +	for (i = 0; i < hpriv->nphys; i++) {
> +		rc = phy_init(hpriv->phys[i]);
> +		if (rc)
> +			goto disable_phys;
> +
> +		rc = phy_power_on(hpriv->phys[i]);
> +		if (rc) {
> +			phy_exit(hpriv->phys[i]);
> +			goto disable_phys;
> +		}
> +	}
> +
> +	return 0;
> +
> +disable_phys:
> +	while (--i >= 0) {
> +		phy_power_off(hpriv->phys[i]);
> +		phy_exit(hpriv->phys[i]);
> +	}
> +	return rc;
> +}


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
