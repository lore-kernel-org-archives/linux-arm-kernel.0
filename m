From: balbi@ti.com (Felipe Balbi)
Date: Fri, 22 Jul 2011 11:58:20 +0300
Subject: [RFC/PATCH 3/7] OMAP: McBSP: use existing macros for converting
	between devices
In-Reply-To: <1311292338-11830-5-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-5-git-send-email-khilman@ti.com>
Message-ID: <20110722085819.GJ32058@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 04:52:14PM -0700, Kevin Hilman wrote:
> For converting from struct device to platform_device, and from
> platform_device to struct device, there are existing macros.  Use
> them instead of manual use of container_of().
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 6c62af1..02199e8 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -260,9 +260,9 @@ EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
>  #ifdef CONFIG_ARCH_OMAP3
>  static struct omap_device *find_omap_device_by_dev(struct device *dev)
>  {
> -	struct platform_device *pdev = container_of(dev,
> -					struct platform_device, dev);
> -	return container_of(pdev, struct omap_device, pdev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	return to_omap_device(pdev);

could simplify to:

	return to_omap_device(to_platform_device(dev));

but it won't change much. Only decrease readability, probably.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110722/62086604/attachment.sig>
