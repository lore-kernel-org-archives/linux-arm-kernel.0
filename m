From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jun 2014 12:54:20 +0200
Subject: [RFC 09/10] drm/tegra: Add IOMMU support
In-Reply-To: <20140627124614.050be2e406a4b9a02d9fe97c@nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-10-git-send-email-thierry.reding@gmail.com>
 <20140627124614.050be2e406a4b9a02d9fe97c@nvidia.com>
Message-ID: <4455459.GtiCHWk2CB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 June 2014 12:46:14 Hiroshi DOyu wrote:
> 
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > From: Thierry Reding <treding@nvidia.com>
> >
> > When an IOMMU device is available on the platform bus, allocate an IOMMU
> > domain and attach the display controllers to it. The display controllers
> > can then scan out non-contiguous buffers by mapping them through the
> > IOMMU.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > @@ -1283,8 +1284,18 @@ static int tegra_dc_init(struct host1x_client *client)
> >  {
> >         struct drm_device *drm = dev_get_drvdata(client->parent);
> >         struct tegra_dc *dc = host1x_client_to_dc(client);
> > +       struct tegra_drm *tegra = drm->dev_private;
> >         int err;
> >
> > +       if (tegra->domain) {
> > +               err = iommu_attach_device(tegra->domain, dc->dev);
> 
> I wanted to keep device drivers iommu-free with the following:
> 
> http://patchwork.ozlabs.org/patch/354074/
> 

We definitely need something like your series to make iommus work transparently
on ARM for normal devices, using the of_dma_configure() to look up the correct
iommu per device and initialize it.

However, any devices that work with multiple iommu domains cannot do that
and still need to use the iommu API directy. I believe the tegra drm code
falls into this category.

	Arnd
