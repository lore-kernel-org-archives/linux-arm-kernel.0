From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Sep 2012 11:44:28 +0100
Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
In-Reply-To: <20120928104216.GC18125@mudshark.cambridge.arm.com>
References: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
 <alpine.LFD.2.02.1209280011340.6667@xanadu.home>
 <20120928095808.GB18125@mudshark.cambridge.arm.com>
 <20120928103109.GD7916@n2100.arm.linux.org.uk>
 <20120928104216.GC18125@mudshark.cambridge.arm.com>
Message-ID: <20120928104428.GE7916@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 11:42:16AM +0100, Will Deacon wrote:
> How are these regions mapped? If it's something like ioremap_wc, then this
> gives us normal non-cacheable memory on ARMv7, which wouldn't be subject to
> the restrictions that you have with device memory. 

Yes, ioremap_wc() but we can't guarantee that for all causes of memset_io.

> > Either that or we allow DRM to be a security hole by omitting any kind
> > of buffer clearing, because using the existing memset_io() is just far
> > too expensive to clear 8MB a byte at a time.
> 
> If DRM is using normal memory, it sounds like the *_io string functions need
> to be made to work with different memory types.

Take a look at the *_io string function declarations, and observe the use
of __iomem.  That means they're only used with memory returned from the
ioremap*() suite of functions (or they're being used non-compliantly and
sparse should be spitting warnings.)
