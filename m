From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Jun 2018 12:12:04 +0100
Subject: [PATCH v3 01/17] platform-msi: allow creation of MSI domain
 without interrupt number
In-Reply-To: <20180622151432.1566-2-miquel.raynal@bootlin.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-2-miquel.raynal@bootlin.com>
Message-ID: <c5b38c34-5ba0-6545-3635-45be1858fa3b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/18 16:14, Miquel Raynal wrote:
> platform_msi_alloc_priv_data() checks that a number of interrupts is
> always given. This extra-check has no real impact and just prevents
> uselessly the user to create an MSI tree domain: remove it.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/base/platform-msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 60d6cc618f1c..9f001f4ccc0f 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -203,7 +203,7 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
>  	 * accordingly (which would impact the max number of MSI
>  	 * capable devices).
>  	 */
> -	if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
> +	if (!dev->msi_domain || !write_msi_msg || nvec > MAX_DEV_MSIS)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
> 

Huh... It's not that simple.

Yes, it allows you to get a tree via platform_msi_create_device_domain
(assuming that's why you're changing it -- your commit message doesn't
say much) but it also has some impact on the way msi_domain_prepare_irqs
works (see how it is called from platform_msi_create_device_domain).

Importantly, the msi_prepare callback takes nvec as a parameter, and
that ends up trickling down to the irqchip, or whatever will setup the
MSI domain. Things like the GICv3 ITS do rely on that to carve out the
LPI space that subsequently gets used to populate the domain.

So no, you can't do it like that. If you really want a tree, add a
helper that does so.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
