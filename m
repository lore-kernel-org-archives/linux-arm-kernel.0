From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 16:19:28 +0200
Subject: [PATCH V3 1/3] mmc: Add size for caller in init+register
In-Reply-To: <CAPDyKFoPO0KTfW_i1EP8urSUT+U8yEaafrE2HdN2mmEkYCZm-w@mail.gmail.com>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
 <CAPDyKFoPO0KTfW_i1EP8urSUT+U8yEaafrE2HdN2mmEkYCZm-w@mail.gmail.com>
Message-ID: <201305291619.28396.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013, Ulf Hansson wrote:
> > diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> > index 1210ed1..ed4a85d 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.h
> > +++ b/drivers/mmc/host/sdhci-pltfm.h
> > @@ -27,6 +27,8 @@ struct sdhci_pltfm_host {
> >         /* migrate from sdhci_of_host */
> >         unsigned int clock;
> >         u16 xfer_mode_shadow;
> > +
> > +       unsigned long private[0] ____cacheline_aligned;
> 
> Why do you need this to be "____cacheline_aligned"?

This is common practice for additional members in data structures
like this. The reason is that we append a structure which
may have larger alignment requirements than 'unsigned long'.

The kmalloc function generally returns a cache line aligned
object, so this provides the same alignment that we get
with a separate allocation.

	Arnd
