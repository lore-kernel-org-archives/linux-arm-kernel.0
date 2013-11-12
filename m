From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 12 Nov 2013 15:00:40 +0000
Subject: Physical memory start contraints in the Linux kernel  (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <201311121437.55826.arnd@arndb.de>
References: <osstest-21486-mainreport@xen.org>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <201311121437.55826.arnd@arndb.de>
Message-ID: <alpine.DEB.2.02.1311121449550.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Nov 2013, Arnd Bergmann wrote:
> > Or is this a lost fight and should we find a workaround (see below if we
> > are curious) to make the start of memory look the same?
> 
> I don't see what hack you are referring to, can you elaborate?

The hack would be mapping dom0 memory at the same start address as it
would be on the native platform but allocating its memory contiguously
at an offset.

For example having dom0 psedo-physical memory start at 0x80000000 (as it
would expect) and end at 0x88000000 (because let's sat that we only give
128MB of memory to dom0). The actual physical memory would be allocated
contiguously from 0xA0000000. The swiotlb-xen code in Linux would be
made aware of the offset 0xA0000000-0x80000000 via device tree and
would calculate the right physical address to use for dma operations.
Today swiotlb-xen assumes that pseudo-phisical addresses correspond to
physical addresses for dom0.

It feels to me like an hack to work around Linux limitations.
