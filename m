From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Apr 2012 08:08:34 +0000
Subject: [PATCH 1/3] PATA host controller driver for ep93xx
In-Reply-To: <4F795AD1.4070101@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <201203302018.43681.arnd@arndb.de>
 <4F795AD1.4070101@metasoft.pl>
Message-ID: <201204020808.34529.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Rafal Prylowski wrote:
> > 
> > And I think this should be consequently be sorted below nonstandard ports, instead of the SFF list.
> > 
> >       Arnd
> 
> I selected "PATA SFF controllers with BMDMA" list because the driver
> inherits .ata_bmdma_port_ops (this is in libata-sff.c, which is compiled
> only if ATA_SFF is set).

Ok, I see. Is it actually the right one to inherit from though?

You end up overriding most of the opterations that are set there again,
the only ones that you use are:

ata_bmdma_error_handler, ata_bmdma_post_internal_cmd, ata_bmdma_qc_issue,
ata_sff_qc_fill_rtf, ata_sff_freeze, ata_sff_thaw, ata_sff_prereset,
ata_sff_postreset and ata_sff_error_handler.

Are you sure they are all doing the righ thing on your hardware? If
not, it might be better to explicitly just set the ones you need and
see if that still uses any sff functions in the end.

	Arnd
