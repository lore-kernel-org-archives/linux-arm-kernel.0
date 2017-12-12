From: joonas.lahtinen@linux.intel.com (Joonas Lahtinen)
Date: Tue, 12 Dec 2017 16:04:16 +0200
Subject: [PATCH V3 09/29] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <bd6c6365-c265-30f4-029b-3e19af3078f2@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <bd6c6365-c265-30f4-029b-3e19af3078f2@codeaurora.org>
Message-ID: <1513087456.3809.17.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I sent this individual i915 patch to our CI, and it is passing on all platforms:

https://patchwork.freedesktop.org/series/34822/

Is it ok if I merge this to drm-tip already?

Regards, Joonas

On Mon, 2017-11-27 at 13:50 -0500, Sinan Kaya wrote:
> +dri-devel at lists.freedesktop.org
> 
> On 11/27/2017 11:57 AM, Sinan Kaya wrote:
> > pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> > where a PCI device is present. This restricts the device drivers to be
> > reused for other domain numbers.
> > 
> > Getting ready to remove pci_get_bus_and_slot() function in favor of
> > pci_get_domain_bus_and_slot().
> > 
> > Extract the domain number from drm_device and pass it into
> > pci_get_domain_bus_and_slot() function.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > ---
> >  drivers/gpu/drm/i915/i915_drv.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> > index 9f45cfe..5a8cb79 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.c
> > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > @@ -419,7 +419,10 @@ static int i915_getparam(struct drm_device *dev, void *data,
> >  
> >  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
> >  {
> > -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> > +	int domain = pci_domain_nr(dev_priv->drm.pdev->bus);
> > +
> > +	dev_priv->bridge_dev =
> > +		pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(0, 0));
> >  	if (!dev_priv->bridge_dev) {
> >  		DRM_ERROR("bridge device not found\n");
> >  		return -1;
> > 
> 
> 
-- 
Joonas Lahtinen
Open Source Technology Center
Intel Corporation
