From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 09:55:41 -0500
Subject: [PATCH v6 06/18] ahci-platform: Add enable_ / disable_resources
 helper functions
In-Reply-To: <1392811320-3132-7-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-7-git-send-email-hdegoede@redhat.com>
Message-ID: <20140219145541.GE10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:01:48PM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/ata/ahci_platform.c   | 83 ++++++++++++++++++++++++-------------------
>  include/linux/ahci_platform.h |  2 ++
>  2 files changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 2f319e9..1cce7a2 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -117,6 +117,39 @@ void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>  
>  
> +int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
> +{
> +	int rc;
> +
> +	if (hpriv->target_pwr) {
> +		rc = regulator_enable(hpriv->target_pwr);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = ahci_platform_enable_clks(hpriv);
> +	if (rc)
> +		goto disable_regulator;
> +
> +	return 0;
> +
> +disable_regulator:
> +	if (hpriv->target_pwr)
> +		regulator_disable(hpriv->target_pwr);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
> +
> +void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
> +{
> +	ahci_platform_disable_clks(hpriv);
> +
> +	if (hpriv->target_pwr)
> +		regulator_disable(hpriv->target_pwr);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_disable_resources);
> +
> +

Ditto with comments, double blank lines and devres wrapping.

Thanks.

-- 
tejun
