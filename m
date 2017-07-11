From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue, 11 Jul 2017 14:37:35 +0000
Subject: [PATCH] gpu: host1x: Free the IOMMU domain when there is no
 device to attach
In-Reply-To: <1499762987.1340.10.camel@paulk.fr>
References: <20170710193305.5987-1-contact@paulk.fr>
 <1499762987.1340.10.camel@paulk.fr>
Message-ID: <1499783851.1520.16.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-07-11 at 11:49 +0300, Paul Kocialkowski wrote:
> On Mon, 2017-07-10 at 21:33 +0200, Paul Kocialkowski wrote:
> > When there is no device to attach to the IOMMU domain, as may be
> > the
> > case when the device-tree does not contain the proper iommu node,
> > it
> > is
> > best to keep going without IOMMU support rather than failing.
> > This allows the driver to probe and function instead of taking down
> > all of the tegra drm driver, leading to missing display support.
> 
> Fixes: 404bfb78daf3 ("gpu: host1x: Add IOMMU support")
> 
> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.
> > org>
> > ---
> > ?drivers/gpu/host1x/dev.c | 8 +++++++-
> > ?1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> > index ac65f52850a6..f296738d0de8 100644
> > --- a/drivers/gpu/host1x/dev.c
> > +++ b/drivers/gpu/host1x/dev.c
> > @@ -186,8 +186,13 @@ static int host1x_probe(struct platform_device
> > *pdev)
> > ?			return -ENOMEM;
> > ?
> > ?		err = iommu_attach_device(host->domain, &pdev-
> > >dev);
> > -		if (err)
> > +		if (err == -ENODEV) {
> > +			iommu_domain_free(host->domain);
> > +			host->domain = NULL;
> > +			goto iommu_skip;
> > +		} else if (err) {
> > ?			goto fail_free_domain;
> > +		}
> > ?
> > ?		geometry = &host->domain->geometry;
> > ?
> > @@ -198,6 +203,7 @@ static int host1x_probe(struct platform_device
> > *pdev)
> > ?		host->iova_end = geometry->aperture_end;
> > ?	}
> > ?
> > +iommu_skip:
> > ?	err = host1x_channel_list_init(host);
> > ?	if (err) {
> > ?		dev_err(&pdev->dev, "failed to initialize channel
> > list\n");

Please note that this does no longer cleanly apply after Mikko's 'gpu:
host1x: Refactor channel allocation code' commit from June 15 already
applied to current -next. Other than that

Tested-by:?Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-on: Apalis TK1, Apalis T30, Beaver, Colibri T30, Jetson-TK1

Finally graphics working again, thanks guys!
