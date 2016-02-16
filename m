From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 12:26:23 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <m3d1rxqa4p.fsf@t19.piap.pl>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <4239208.KBB6rfivoa@wuerfel> <m3d1rxqa4p.fsf@t19.piap.pl>
Message-ID: <2702068.KRp0Bplb5Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 10:26:14 Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > The barriers on a spinlock synchronize between CPUs but not an external
> > bus, so (on some architectures) a spinlock protecting an MMIO register
> > does not guarantee that two CPUs doing
> >
> >       spin_lock();
> >       __raw_writel(address);
> >       __raw_writel(data);
> >       spin_unlock();
> >
> > would cause pairs of address/data to be seen on the bus.
> >
> > Of course this is meaningless on ixp4xx, as there is only one CPU.
> 
> I still don't get it. If the spinlocks synchronize between CPUs, there
> can only be one CPU (or core) doing the pair of raw_writel(), so how
> would it be possible to not get the address/data pair written out?
> IOW, how is it different from a system with a single CPU?

Both writes leave the CPU core within the spinlock but are not serialized
with anything else, so there is no ordering between the CPUs when they
enter the shared bus, other than having address before data. You'd
expect to see address0, data0, address1, data1, but it could also
be e.g. address0, address1, data1, data0.

> > On powerpc, we have in_le32/in_be32 for SoC-internal register access,
> > while only PCI devices are allowed to be accessed using readl().
> 
> Yeah, this seems like a sane solution.
> 
> > I would suggest using an ixp4xx specific set of accessors that comes down
> > to either readl() or ioread32_be(), depending on whether CONFIG_CPU_BIG_ENDIAN
> > is set. That makes it clear that there is a magic bus involved and that it
> > works on this platform but not in portable code.
> 
> Hmm. This is actually the opposite - while there may be some magic
> (swapping) in readl() and friends, there is absolutely no magic in the
> __raw_readl() etc. They are essentially equivalent to
> *(volatile u32 *)ptr. This is constant and doesn't depend on endianess,
> PCI, anything.

The point is more what the common case is. Almost all machines we support
have fixed-endian devices, and the drivers are correct when using readl()
or in_le32() but are not endian-safe when using __raw_readl().

Using __raw_readl() has the big danger of someone accidentally "fixing"
the driver to work like all the others in order to solve a theoretical
endian problem, while it should really be made obvious that the hardware
actively swaps its data on the bus.

	Arnd
