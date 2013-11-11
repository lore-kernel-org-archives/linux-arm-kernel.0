From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Nov 2013 09:54:32 +0100
Subject: [PATCH v2 3/5] ata: Add APM X-Gene SATA driver
In-Reply-To: <CAOesGMjEpC9-i52zYb2LtmyfV7FZQQGeeo4Umg-LXOYytZ4E-A@mail.gmail.com>
References: <1383980431-6572-1-git-send-email-lho@apm.com>
 <1383980431-6572-4-git-send-email-lho@apm.com>
 <CAOesGMjEpC9-i52zYb2LtmyfV7FZQQGeeo4Umg-LXOYytZ4E-A@mail.gmail.com>
Message-ID: <201311110954.32904.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 10 November 2013, Olof Johansson wrote:
>
> > diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> > index 46518c6..022f9d1 100644
> > --- a/drivers/ata/Makefile
> > +++ b/drivers/ata/Makefile
> > @@ -11,6 +11,8 @@ obj-$(CONFIG_SATA_SIL24)      += sata_sil24.o
> >  obj-$(CONFIG_SATA_DWC)         += sata_dwc_460ex.o
> >  obj-$(CONFIG_SATA_HIGHBANK)    += sata_highbank.o libahci.o
> >  obj-$(CONFIG_AHCI_IMX)         += ahci_imx.o
> > +sata-xgene-objs := sata_xgene.o sata_xgene_serdes.o
> > +obj-$(CONFIG_SATA_XGENE)       += sata-xgene.o
> 
> Why not just doing obj-$(CONFIG_SATA_XGENE)       += sata_xgene.o
> sata_xgene_serdes.o
> ?
> 

That wouldn't create a single module built from two files. However, if
the serdes part is moved to the more appropriate drivers/phy directory
and changed to use generic interfaces (I guess they are merged now,
need to check), then it would be two modules anyay.

> 
> > +/* Flush the IOB to ensure all SATA controller writes completed before
> > +   servicing the completed command. */
> > +static int xgene_ahci_iob_flush(struct xgene_ahci_context *ctx)
> > +{
> > +       if (ctx->ahbc_io_base == NULL) {
> > +               void *ahbc_base;
> > +               u32 val;
> > +
> > +               /* The AHBC address is fixed in X-Gene */
> > +               ahbc_base = devm_ioremap(ctx->dev, 0x1F2A0000, 0x80000);
> 
> Even if fixed, having a defined constant makes sense here and below.

I would still insist on having the address be part of the DT and described
in the binding. You never know if the HW designers change their minds
on the next generation, or if the part is actually licensed from some
other company that also licensed the same thing to someone else.

I think this ought to be put into a proper device driver. It's not clear
from the comment why this is required here, but it seems to be either
working around a bug in MSI signalling that could go away entirely with
a fixed chip revision, or it's something that would be required by every
single DMA master in the system and should not be open-coded in the
individual device drivers.

> This doesn't quite make sense for me. In the case of ACPI firmware on
> server, the firmware can setup SERDES on its own. And if you want to
> provide new override values, you need to rebuild the firmware anyway,
> so there's no way to supply the overrides separately. Thus it really
> makes no sense to do these in the ACPI case.

Agreed.
 
> For DT the case is slightly different since the DT is supplied
> separate from the firmware image, so it's possible to ship newer
> settings. Still, even there there's no reason to not have firmware do
> the setup in most cases.

I'd argue that you shouldn't have to ship a fixed DT to change those
values, but instead put the values into the device driver and fix the
kernel when you need to change them.

	Arnd
