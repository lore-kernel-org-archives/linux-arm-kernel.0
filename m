From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Nov 2009 20:25:23 +0000
Subject: [PATCH] ARM: Introduce HAVE_IOREAD_AND_IOWRITE macro.
In-Reply-To: <m3skbywgr4.fsf@intrepid.localdomain>
References: <m3zl6owvvi.fsf@intrepid.localdomain>
	<20091128182439.GB497@n2100.arm.linux.org.uk>
	<m3skbywgr4.fsf@intrepid.localdomain>
Message-ID: <20091128202523.GD497@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 09:12:31PM +0100, Krzysztof Halasa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > Missed this.
> >
> > If you want to override a function, it's preferred to do it the way we're
> > doing it.
> >
> > In otherwords, if you want to override a symbol using an inline function.
> > Eg:
> >
> > #ifndef ndelay
> > static inline void ndelay(unsigned long x)
> > {
> >         udelay(DIV_ROUND_UP(x, 1000));
> > }
> > #define ndelay(x) ndelay(x)
> > #endif
> 
> I fear someone may want to remove this later thinking that
> "#define a() a()" is not necessary.
> 
> Also we'd need to test each individual macro in the generic header since
> we don't know if having ioread8 also means having other functions.
> 
> #ifndef ioread8
> define ioread8()
> #endif
> 
> #ifndef ioread16
> define ioread16()
> ...
> 
> etc.
> 
> One self-explaining HAVE_IOREAD_AND_IOWRITE has no such problems.
> 
> But I can convert to these #ifndef ioread{8,16,etc} of course if you
> wish. Please let me know if you want only ioread8 tested, or all of
> them respectively.
> 
> What is important to me is that the IXP4xx functions are not called
> __ixp4xx_something() if they do just the something() (instead of maybe
> __raw_something() or __indirect_something()).

The point of the #ifndef is so that you _can_ redefine them.  As illustrated
above, you want:

static inline void writeb(u8 value, volatile void __iomem *p)
{
	u32 addr = (u32)p;
	u32 n, byte_enables, data;

	if (addr >= VMALLOC_START) {
		__raw_writeb(value, addr);
		return;
	}

	n = addr % 4;
	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
	data = value << (8*n);
	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
}

#define writeb(v, p)			writeb(v, p)

etc and just be done with it - absolutely no need what so ever to change
arch/arm/include/asm/io.h.

We've had other platforms cope with this for the last 15 years and it hasn't
been a problem.  I see no reason to change it.
