From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 29 Apr 2016 01:39:55 +0200
Subject: [RFC v4 3/8] gpio: generic: add DT support for generic
 memory-mapped GPIOs
In-Reply-To: <CAHp75VeSf_=rQBRQ+1ox=fn7aJ53mGg_huH7HRbZck0HEhxBAQ@mail.gmail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
 <a5d6bb7bb73ff9396c9e8053a8e8e0975b857934.1461806071.git.chunkeey@googlemail.com>
 <CAHp75VeSf_=rQBRQ+1ox=fn7aJ53mGg_huH7HRbZck0HEhxBAQ@mail.gmail.com>
Message-ID: <3841493.Kd66QyCgCc@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 28, 2016 12:58:03 PM Andy Shevchenko wrote:
> On Thu, Apr 28, 2016 at 12:05 PM, Christian Lamparter
> <chunkeey@googlemail.com> wrote:
> > From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> >
> > This patch adds support for defining memory-mapped GPIOs
> > which provide a compatible interface for the existing
> > generic-gpio driver.

Thanks for your comments! I've prepared a new series which
I'm going to post tomorrow. I've incorporated most of the
remarks, but there's something I have to say about: 

> > +static inline void set_resource_address(struct resource *res,
> > +                                       resource_size_t start,
> > +                                       resource_size_t len)
> > +{
> > +       res->start = start;
> > +       res->end = start + len - 1;
> > +}
> 
> It might make sense to put this in the generic (resource related, e.g.
> ioport.h) header. There are plenty users of such already and who knows
> how many will come.

I looked around and found plenty of code in drivers/
alone doing the same song and dance around it:

acpi/pci_root.c acpi/resource.c
bus/mvebu-mbus.c
i2c/busses/i2c-i801.c
irqchip/irq-mips-gic.c
memory/omap-gpmc.c
mfd/janz-cmodio.c mfd/lpc_ich.c mfd/sm501.c mtd/devices/ms02-nv.c
nvdimm/namespace_devs.c
of/address.c
parisc/ccio-dma.c parisc/dino.c parisc/lba_pci.c
pci/hotplug/ibmphp_res.c pci/bus.c pci/iov.c pci/setup-res.c
pci/setup-bus.c pci/hotplug/ibmphp_res.c
pcmcia/rsrc_mgr.c pcmcia/pcmcia_resource.c
pnp/manager.c
platform/x86/intel_pmc_ipc.c
pinctrl/sh-pfc/core.c
etc...

I think arch/ will have a few more. If anything this will require
help from coccinelle and more stuff. For now I'll convert the code
to do the same thing as everybody else. And after the "linux,gpio-mmio"
has been successfully mainlined I can worry about how to write the
perfect set_resource_address or set_resource_range (needs to handle
over- and underflows, etc...) and setup the automatic tools to convert
the whole tree. So, unless someone else beats me to this, this would
be my plan.

Regards,
Christian
