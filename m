From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 30 May 2017 15:09:13 +0000
Subject: [PATCH v9 1/7] LIB: Introduce a generic PIO mapping method
In-Reply-To: <20170526205744.GA21531@bhelgaas-glaptop.roam.corp.google.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-2-git-send-email-gabriele.paoloni@huawei.com>
 <20170526205744.GA21531@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A771E6@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: 26 May 2017 21:58
> To: Gabriele Paoloni
> Cc: catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; rafael at kernel.org;
> arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> lorenzo.pieralisi at arm.com; mark.rutland at arm.com; minyard at acm.org;
> benh at kernel.crashing.org; John Garry; linux-kernel at vger.kernel.org;
> xuwei (O); Linuxarm; linux-acpi at vger.kernel.org; zhichang.yuan; linux-
> pci at vger.kernel.org; olof at lixom.net; brian.starkey at arm.com
> Subject: Re: [PATCH v9 1/7] LIB: Introduce a generic PIO mapping method
> 
> On Thu, May 25, 2017 at 12:37:22PM +0100, Gabriele Paoloni wrote:
> > From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> >
> > In 'commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> > pci_pio_to_address()")' a new I/O space management was supported.
> With that
> > driver, the I/O ranges configured for PCI/PCIE hosts on some
> architectures
> > can be mapped to logical PIO, converted easily between CPU address
> and the
> > corresponding logicial PIO. Based on this, PCI I/O devices can be
> accessed
> > in a memory read/write way through the unified in/out accessors.
> >
> > But on some archs/platforms, there are bus hosts which access I/O
> > peripherals with host-local I/O port addresses rather than memory
> > addresses after memory-mapped.
> > To support those devices, a more generic I/O mapping method is
> introduced
> > here. Through this patch, both the CPU addresses and the host-local
> port
> > can be mapped into the logical PIO space with different logical/fake
> PIOs.
> > After this, all the I/O accesses to either PCI MMIO devices or host-
> local
> > I/O peripherals can be unified into the existing I/O accessors
> defined in
> > asm-generic/io.h and be redirected to the right device-specific hooks
> > based on the input logical PIO.
> >
> > Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > ---
> >  include/asm-generic/io.h  |  50 +++++++++
> >  include/linux/logic_pio.h | 110 ++++++++++++++++++
> >  lib/Kconfig               |  26 +++++
> >  lib/Makefile              |   2 +
> >  lib/logic_pio.c           | 280
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 468 insertions(+)
> >  create mode 100644 include/linux/logic_pio.h
> >  create mode 100644 lib/logic_pio.c
> >
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 7ef015e..f7fbec3 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > ...
> 
> >  #ifndef inb
> > +#ifdef CONFIG_INDIRECT_PIO
> > +#define inb logic_inb
> > +#else
> >  #define inb inb
> >  static inline u8 inb(unsigned long addr)
> >  {
> >  	return readb(PCI_IOBASE + addr);
> >  }
> > +#endif /* CONFIG_INDIRECT_PIO */
> >  #endif
> >
> >  #ifndef inw
> > +#ifdef CONFIG_INDIRECT_PIO
> > +#define inw logic_inw
> 
> Cosmetic: could these ifdefs all be collected in one place, e.g.,
> 
>   #ifdef CONFIG_INDIRECT_PIO
>   #define inb logic_inb
>   #define inw logic_inw
>   #define inl logic_inl
>   ...
>   #endif
> 
> to avoid cluttering every one of the default definitions?  Could the
> collection be in logic_pio.h itself, next to the extern declarations?

Yes I think it should be doable. I will rework this in the next patchset

> 
> > +#else
> >  #define inw inw
> >  static inline u16 inw(unsigned long addr)
> >  {
> >  	return readw(PCI_IOBASE + addr);
> >  }
> > +#endif /* CONFIG_INDIRECT_PIO */
> >  #endif
> 
> >  #ifndef insb_p
> > diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
> > new file mode 100644
> > index 0000000..8e4dc65
> > --- /dev/null
> > +++ b/include/linux/logic_pio.h
> > ...
> 
> > +extern u8 logic_inb(unsigned long addr);
> 
> I think you only build the definitions for these if
> CONFIG_INDIRECT_PIO, so the declarations could be under that #idef,
> too.

Yes agreed

> 
> In PCI code, I omit the "extern" from function declarations.  This
> isn't PCI code, and I don't know if there's a real consensus on this,
> but there is some precedent: 5bd085b5fbd8 ("x86: remove "extern" from
> function prototypes in <asm/proto.h>")
> 

To be honest I have no clue...

If you look at include/asm-generic/io.h we have extern declarations...

BTW I can remove the extern and then let's see if somebody complains...


> > +#ifdef CONFIG_LOGIC_PIO
> > +extern struct logic_pio_hwaddr
> > +*find_io_range_by_fwnode(struct fwnode_handle *fwnode);
> 
> If you have to split the line (this one would fit without the
> "extern"), the "*" goes with the type, e.g.,
> 
>   struct logic_pio_hwaddr *
>   find_io_range_by_fwnode(struct fwnode_handle *fwnode);
> 
> More occurrences below.

Ok I will rework these

> 
> > diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> > new file mode 100644
> > index 0000000..4a960cd
> > --- /dev/null
> > +++ b/lib/logic_pio.c
> > ...
> 
> > +#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
> > +#define BUILD_LOGIC_PIO(bw, type)\
> > +type logic_in##bw(unsigned long addr)\
> > +{\
> > +	type ret = -1;\
> > +\
> > +	if (addr < MMIO_UPPER_LIMIT) {\
> > +		ret = read##bw(PCI_IOBASE + addr);\
> > +	} else {\
> > +		struct logic_pio_hwaddr *entry = find_io_range(addr);\
> > +\
> > +		if (entry && entry->ops)\
> > +			ret = entry->ops->pfin(entry->devpara,\
> > +					addr, sizeof(type));\
> > +		else\
> > +			WARN_ON_ONCE(1);\
> > +	}	\
> > +	return ret;\
> > +}	\
> 
> I think these would be slightly easier to read if the line continuation
> backslashes were aligned at the right, as with
> ACPI_DECLARE_PROBE_ENTRY(), __atomic_op_acquire(), DECLARE_EWMA(),
> etc.

Ok agreed I will rework this too

Many Thanks
Gab

> 
> Bjorn
