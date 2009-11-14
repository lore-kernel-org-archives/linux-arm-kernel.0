From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Nov 2009 21:05:34 +0000
Subject: IXP4xx: Indirect PCI MMIO compile failure
In-Reply-To: <m3pr7kyi9x.fsf@intrepid.localdomain>
References: <m3pr7kyi9x.fsf@intrepid.localdomain>
Message-ID: <20091114210533.GA30027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2009 at 09:15:54PM +0100, Krzysztof Halasa wrote:
> Guess nobody uses indirect PCI MMIO on IXP4xx - since 2.6.29:
> arch/arm/mach-ixp4xx/include/mach/io.h:70: error: 'VMALLOC_START' undeclared
> 
> (and so on)
> 
> That's a part of commit 4b78a9ffabbb03af4032ff704689912298e19070, dated
> 2008-11-29. Perhaps we should get rid of this hack (indirect MMIO) if
> nobody uses it? 64 MB of MMIO PCI space should be more than enough for
> everyone :-)
> 
> Since VMALLOC_START wants high_memory, I guess the correct patch is
> (attached) and that's what I'm going to use if nobody comes with a
> better idea.

This is rather horrible, linux/mm.h is one of those headers which drag
in lots of other headers, and we're risking horrible include loops if we
do this.  (while ifdefs give some protection against those running away,
it does mean that we lose ordering of definitions - which can and does
lead to indeterminent behaviour.)

Probably the best solution is to move __ixp4xx_iounmap out of the header
files.
