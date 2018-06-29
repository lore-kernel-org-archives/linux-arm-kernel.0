From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 29 Jun 2018 09:40:35 +0200
Subject: [PATCH v3 01/17] platform-msi: allow creation of MSI domain
 without interrupt number
In-Reply-To: <c5b38c34-5ba0-6545-3635-45be1858fa3b@arm.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-2-miquel.raynal@bootlin.com>
 <c5b38c34-5ba0-6545-3635-45be1858fa3b@arm.com>
Message-ID: <20180629094035.5199fe89@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 28 Jun 2018 12:12:04
+0100:

> On 22/06/18 16:14, Miquel Raynal wrote:
> > platform_msi_alloc_priv_data() checks that a number of interrupts is
> > always given. This extra-check has no real impact and just prevents
> > uselessly the user to create an MSI tree domain: remove it.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/base/platform-msi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> > index 60d6cc618f1c..9f001f4ccc0f 100644
> > --- a/drivers/base/platform-msi.c
> > +++ b/drivers/base/platform-msi.c
> > @@ -203,7 +203,7 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
> >  	 * accordingly (which would impact the max number of MSI
> >  	 * capable devices).
> >  	 */
> > -	if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
> > +	if (!dev->msi_domain || !write_msi_msg || nvec > MAX_DEV_MSIS)
> >  		return ERR_PTR(-EINVAL);
> >  
> >  	if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
> >   
> 
> Huh... It's not that simple.
> 
> Yes, it allows you to get a tree via platform_msi_create_device_domain
> (assuming that's why you're changing it -- your commit message doesn't
> say much)

Indeed. That was exactly my intention.

> but it also has some impact on the way msi_domain_prepare_irqs
> works (see how it is called from platform_msi_create_device_domain).
> 
> Importantly, the msi_prepare callback takes nvec as a parameter, and
> that ends up trickling down to the irqchip, or whatever will setup the
> MSI domain. Things like the GICv3 ITS do rely on that to carve out the
> LPI space that subsequently gets used to populate the domain.
> 
> So no, you can't do it like that. If you really want a tree, add a
> helper that does so.

So if I understand correctly, what should be done is writting a new
helper that would do something similar to
platform_msi_create_device_domain(), but creating instead a tree domain
and still giving msi_domain_prepare_irqs() a meaningful number (as
nvec) that would be the maximum number of MSIs that could be allocated.
Am I right here?


Thanks,
Miqu?l
