From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Fri, 16 Oct 2015 07:26:20 -0700
Subject: [PATCH v2] scsi: advansys needs ISA dma api for ISA support
In-Reply-To: <5461074.f3cLgYkzKJ@wuerfel>
References: <4351271.eUtUWpTn54@wuerfel>
 <1445003624.2191.2.camel@HansenPartnership.com>
 <5461074.f3cLgYkzKJ@wuerfel>
Message-ID: <1445005580.2191.10.camel@HansenPartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-10-16 at 16:19 +0200, Arnd Bergmann wrote:
> On Friday 16 October 2015 06:53:44 James Bottomley wrote:
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> > > index d2f480b04a52..1d8b8257773d 100644
> > > --- a/drivers/scsi/Kconfig
> > > +++ b/drivers/scsi/Kconfig
> > > @@ -498,7 +498,7 @@ config SCSI_DPT_I2O
> > >  config SCSI_ADVANSYS
> > >       tristate "AdvanSys SCSI support"
> > >       depends on SCSI
> > > -     depends on ISA || EISA || PCI
> > > +     depends on (ISA && ISA_DMA_API) || EISA || PCI
> > 
> > I thought the desire was to avoid a compile failure when ISA && !
> > ISA_DMA_API?  Won't this one fail if ISA is defined with either EISA or
> > PCI and !ISA_DMA_API?
> 
> I thought I had it ruled out, but now I've actually found a combination:
> we can build an ARM kernel that supports two ancient machines, and one
> of them supports ISA (but not ISA_DMA_API), while the other one supports
> PCI. I had looked through several thousand randconfig builds and not
> found this combination together with advansys, but I guess that is
> because those were mostly old builds from the times when there was
> a dependency on VIRT_TO_BUS that this platform doesn't have.
> 
> So screw this one and go back to the original patch.

Agreed ... you've also got PA-RISC that enables EISA and is !
DMA_ISA_API.

James
