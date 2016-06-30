From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Jun 2016 13:26:26 +0100
Subject: [Question] Memory attribute reserved by Device Tree?
In-Reply-To: <577504D7.7080106@arm.com>
References: <CAK7LNATGoP-Wn-wiK_CgD_v=rQXyt937qRvr8LkUQ06jHB7FAA@mail.gmail.com>
 <577504D7.7080106@arm.com>
Message-ID: <20160630122554.GC20363@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 12:39:03PM +0100, Robin Murphy wrote:
> On 30/06/16 12:10, Masahiro Yamada wrote:
> > Hello.
> > 
> > Which memory attribute will ARM/ARM64 Linux
> > set to the memory region reserved by
> > /memreserve/ of Device Tree?
> > 
> > 
> > Normal memory non-cacheable?
> > Or, cacheable?
> > Or, not defined?
> > 
> > Perhaps actual behavior depends on whether the reserved area is
> > located in the low-memory region?
> 
> Isn't the point of memreserve that the kernel avoids mapping it at all?

Not quite. A /memreserve/ allows the kernel to map a region, so long as
it doesn't use the region for general allocation.

While not strictly defined for arm64 today, in practice the kernel may
map a region with Normal Inner-Shareable Inner-WB Outer-WB attributes,
following similar behaviour for PPC as defined in ePAPR.

Generally I would advise against the use of a memreserve, and favour
carving memory out of memory nodes as required, as that imposes stricter
requirements.

> If a reserved region is later mapped in by a driver using
> dma_declare_coherent_memory(), ioremap(), memremap() or whatever else,
> then the attributes will vary depending on the exact method used.

Indeed. This applies even with the above.

Thanks,
Mark.
