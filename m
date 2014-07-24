From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Jul 2014 18:12:52 +0100
Subject: [PATCH v3] platform: Make platform_bus device a platform device
In-Reply-To: <20140723193434.GA31983@kroah.com>
References: <20140722173713.GA8959@kroah.com>
 <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
 <1406052069.25343.93.camel@hornet> <20140722181505.GA9898@kroah.com>
 <1406135762.25343.151.camel@hornet> <20140723193434.GA31983@kroah.com>
Message-ID: <1406221972.25343.184.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-23 at 20:34 +0100, Greg Kroah-Hartman wrote:
> > > > > diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> > > > > index 3cbb57a..c14c36f 100644
> > > > > --- a/drivers/scsi/hosts.c
> > > > > +++ b/drivers/scsi/hosts.c
> > > > > @@ -218,7 +218,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
> > > > >                 goto fail;
> > > > > 
> > > > >         if (!shost->shost_gendev.parent)
> > > > > -               shost->shost_gendev.parent = dev ? dev : &platform_bus;
> > > > > +               shost->shost_gendev.parent = dev ? dev : &platform_bus.dev;
> > > > >         if (!dma_dev)
> > > > >                 dma_dev = shost->shost_gendev.parent;
> > > > > 
> > > > 
> > > > shost_gendev is a generic (as in struct device, non-platform one)
> > > > device, that is being explicitly placed in the hierarchy.
> > > 
> > > Then make it a virtual device, as that's what it is, replace this with
> > > NULL.
> > 
> > Makes sense to me, I just wonder what the author meant.
> 
> With scsi code, who knows :)

Looking at this further, it seems that the main purpose here is to make
sure that dma_dev is not NULL...

So it's not just simply a case of s/&platform_bus/NULL/ - maybe the
function should fail when !dma_dev? I'll split the patch so each case is
separate and post them to relevant maintainers.

Pawel
