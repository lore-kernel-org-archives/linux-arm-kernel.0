From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 15 Sep 2010 18:19:50 -0400 (EDT)
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <4C912CE4.3000306@endruntechnologies.com>
References: <4C8DD588.7040009@endruntechnologies.com>
	<20100913100111.GA30787@n2100.arm.linux.org.uk>
	<4C8E7EFF.7020004@endruntechnologies.com>
	<alpine.LFD.2.00.1009141330230.19366@xanadu.home>
	<4C8FB71C.8010208@endruntechnologies.com>
	<alpine.LFD.2.00.1009141442330.19366@xanadu.home>
	<4C912CE4.3000306@endruntechnologies.com>
Message-ID: <alpine.LFD.2.00.1009151753070.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Sep 2010, Bruce M. Penrod wrote:

> 
> 
> Nicolas Pitre wrote:
> > On Tue, 14 Sep 2010, Bruce M. Penrod wrote:
> > 
> > > I think it depended upon how "too big" the kernel was.  With one only
> > > slightly
> > > larger than 4 MB, I did see "Uncompressing Linux...", but not "done,
> > > booting
> > > the kernel."  With a very large kernel (15MB), nothing printed at all.
> > > 
> > > I have not retested since successfully booting one slightly smaller than
> > > 4096
> > > * 1024.  When I do, I will post the results.  Should happen today.
> > 
> > OK.  Also please provide the size of your arch/arm/boot/zImage as well as
> > arch/arm/boot/Image.  Also, at what address do you load your kernel in
> > memory?
> > 
> > 
> > Nicolas
> 
> U-Boot loads the zImage at 0x800000.  Yesterday I added features back into the
> kernel and am up to 4600 * 1024 with no issues.  So definitely not a hard
> limit at 4MB.  It takes quite a while to compile on the OpenRD, so it may take
> a while for me to discover the magic combination that doesn't work.  I removed
> a LOT of stuff, and I'd rather add it back in gradually to get an idea whether
> it is a size issue or some bad other thing with a combination of options.

There is definitely something in the code though.  It is assumed that 
the decompressed kernel code is 4 times larger than the compressed one.  
That is used to relocate the compressed kernel in case it was loaded in 
the final memory area where the decompressed kernel goes.  So two issues 
may occur:

1) Your decompressed kernel ends up being more than 4x larger than the 
   compressed one.  This would cause problems if the compressed data is 
   not moved away when it should be.

2) Your compressed kernel is big, but that's because it includes a big 
   initramfs or something similar which won't compress well.  In that 
   case the presumed 4x expansion factor might be way overestimated, and
   the location where to relocate the compressed kernel might end up 
   outside the available RAM if you don't have much of it.


Nicolas
