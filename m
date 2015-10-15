From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 17:04:50 +0200
Subject: [PATCH] scsi: advansys needs ISA dma api for ISA support
In-Reply-To: <561F977B.1030009@suse.de>
References: <5081546.QjQ32dGX2L@wuerfel> <561F96B7.4050300@suse.de>
 <561F977B.1030009@suse.de>
Message-ID: <8749889.aUxSEGWaCq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 14:09:31 Hannes Reinecke wrote:
> On 10/15/2015 02:06 PM, Hannes Reinecke wrote:
> > On 10/12/2015 05:10 PM, Arnd Bergmann wrote:
> >> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> >> index d2f480b04a52..d4aa6a1a806c 100644
> >> --- a/drivers/scsi/Kconfig
> >> +++ b/drivers/scsi/Kconfig
> >> @@ -499,6 +499,7 @@ config SCSI_ADVANSYS
> >>      tristate "AdvanSys SCSI support"
> >>      depends on SCSI
> >>      depends on ISA || EISA || PCI
> >> +    depends on ISA_DMA_API || !ISA
> >>      help
> >>        This is a driver for all SCSI host adapters manufactured by
> >>        AdvanSys. It is documented in the kernel source in
> >>
> > Sorry to chime in again, but wouldn't this allow to build on platforms
> > which have neither ISA_DMA_API nor ISA, like oldish sparc systems with
> > proprietary S-BUS?

No, the first dependency is still in place. It could also be written as

depends on (ISA && ISA_DMA_API) || EISA || PCI

which might be easier to understand. Do you want me to resubmit it like that?

> > Why not ISA_DMA_API || EISA || PCI ?

That would indeed make it possible to enable it on ancient systems that
have none of ISA, EISA or PCI but still support ISA_DMA_API, e.g. for
a floppy controller.

A theoretical downside is that a system with a PCI advansys adapter
and ISA slots but no ISA_DMA_API would not be able to build this.
As far as I know, such a system does not exist.

> Gnaa. Ignore this.
> 
> Mailer got confused about which mails are more recent than others 

Just to make sure we are on the same page: James thought my second patch
was making things too ugly and wanted to get back to this one.

	Arnd
