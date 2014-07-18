From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 18 Jul 2014 16:30:38 +0200
Subject: [PATCH v10 5/8] ata: ahci_platform: add a generic AHCI compatible
In-Reply-To: <1405686607-8126-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53C92F8E.5000906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/18/2014 02:30 PM, Antoine T?nart wrote:
> The ahci_platform driver is a generic driver using the libahci_platform
> functions. Add a generic compatible to avoid having an endless list of
> compatibles with no differences for the same driver.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  drivers/ata/ahci_platform.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 95f9ca82082a..61b15e784020 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -77,6 +77,8 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>  			 ahci_platform_resume);
>  
>  static const struct of_device_id ahci_of_match[] = {
> +	{ .compatible = "generic-ahci", },
> +	/* Keep the following compatibles for device tree compatibility */
>  	{ .compatible = "snps,spear-ahci", },
>  	{ .compatible = "snps,exynos5440-ahci", },
>  	{ .compatible = "ibm,476gtr-ahci", },
> 

I'm not against this, I've introduced the same for the ehci / uhci platform
driver after all, but this should be documented in Documentation/devicetree,
and please make sure to mention in the docs that the correct way to use this
inside a dts file is:

	compatible = "manufacturer,soc-model-ahci", "generic-ahci";

So that we can later add quirks for the specific soc if necessary without
needing to change the dts.

Regards,

Hans
