From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 20 Feb 2014 12:00:22 +0000
Subject: [PATCH v3 2/6] drivers: of: add initialization code for reserved
 memory
In-Reply-To: <53046935.3090900@samsung.com>
References: <1392730681-14695-1-git-send-email-m.szyprowski@samsung.com> <
 1392730681-14695-3-git-send-email-m.szyprowski@samsung.com> <20140218165616
 .E1755C40517@trevor.secretlab.ca> <53046935.3090900@samsung.com>
Message-ID: <20140220120022.874A7C4050F@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Feb 2014 09:20:05 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hello,
> 
> On 2014-02-18 17:56, Grant Likely wrote:
> > On Tue, 18 Feb 2014 14:37:57 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > > This patch adds device tree support for contiguous and reserved memory
> > > regions defined in device tree.
> > >
> > > Large memory blocks can be reliably reserved only during early boot.
> > > This must happen before the whole memory management subsystem is
> > > initialized, because we need to ensure that the given contiguous blocks
> > > are not yet allocated by kernel. Also it must happen before kernel
> > > mappings for the whole low memory are created, to ensure that there will
> > > be no mappings (for reserved blocks) or mapping with special properties
> > > can be created (for CMA blocks). This all happens before device tree
> > > structures are unflattened, so we need to get reserved memory layout
> > > directly from fdt.
> > >
> > > Later, those reserved memory regions are assigned to devices on each
> > > device structure initialization.
> > >
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > [joshc: rework to implement new DT binding, provide mechanism for
> > >  plugging in new reserved-memory node handlers via
> > >  RESERVEDMEM_OF_DECLARE]
> > > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > > [mszyprow: added generic memory reservation code]
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >  drivers/of/Kconfig                |    5 +
> > >  drivers/of/Makefile               |    1 +
> > >  drivers/of/fdt.c                  |    2 +
> > >  drivers/of/of_reserved_mem.c      |  390 +++++++++++++++++++++++++++++++++++++
> > >  drivers/of/platform.c             |    7 +
> > >  include/asm-generic/vmlinux.lds.h |   11 ++
> > >  include/linux/of_reserved_mem.h   |   65 +++++++
> > >  7 files changed, 481 insertions(+)
> > >  create mode 100644 drivers/of/of_reserved_mem.c
> > >  create mode 100644 include/linux/of_reserved_mem.h
> > >
> > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > index c6973f101a3e..f25931dfc6db 100644
> > > --- a/drivers/of/Kconfig
> > > +++ b/drivers/of/Kconfig
> > > @@ -75,4 +75,9 @@ config OF_MTD
> > >  	depends on MTD
> > >  	def_bool y
> > >
> > > +config OF_RESERVED_MEM
> > > +	bool
> > > +	help
> > > +	  Helpers to allow for reservation of memory regions
> > > +
> > >  endmenu # OF
> > > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > > index efd05102c405..ed9660adad77 100644
> > > --- a/drivers/of/Makefile
> > > +++ b/drivers/of/Makefile
> > > @@ -9,3 +9,4 @@ obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
> > >  obj-$(CONFIG_OF_PCI)	+= of_pci.o
> > >  obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
> > >  obj-$(CONFIG_OF_MTD)	+= of_mtd.o
> > > +obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
> >
> > As mentioned previously, parts of this are absolutely non-optional and
> > cannot be compiled out. If a region is marked as reserved with this
> > binding, then the kernel must respect it. That part of the code must be
> > always configured in.
> 
> How can I make it non-optional if all this code must be called from arch
> specific early-boot init code to properly reserve memory. Do you want me
> to add those calls to every architecture which supports OF?

As discussed on IRC, since the static and dynamic regions need to be
parsed in separate passes anyway, it would be fine to do the static pass
during early_init_dt_scan() and defer the dynamic allocation to later.

That said, it requires Laura's series to get rid of meminfo to be merged
first. I'm fine with the calling point to still be done arch specific
and I won't ask you to enable every platform in this patch. That can be
a fixup after Laura's series goes in and I'll help you with the other
architectures.

g.
