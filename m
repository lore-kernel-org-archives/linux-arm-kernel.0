From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Nov 2011 14:08:42 -0500 (EST)
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111123175446.GI30049@opensource.wolfsonmicro.com>
References: <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111123120534.GO21073@opensource.wolfsonmicro.com>
 <20111123122855.GB7382@totoro>
 <20111123130134.GB12227@opensource.wolfsonmicro.com>
 <20111123133237.GC7382@totoro>
 <20111123135033.GA20272@opensource.wolfsonmicro.com>
 <20111123143322.GD7382@totoro>
 <20111123145517.GE20272@opensource.wolfsonmicro.com>
 <4ECD32CA.2030601@gmail.com>
 <20111123175446.GI30049@opensource.wolfsonmicro.com>
Message-ID: <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Nov 2011, Mark Brown wrote:

> On Wed, Nov 23, 2011 at 11:52:10AM -0600, Rob Herring wrote:
> > On 11/23/2011 08:55 AM, Mark Brown wrote:
> 
> > > My bisect turned up a second candidate - Nicholas' commit 549158d (ARM:
> > > move iotable mappings within the vmalloc region).  I reverted that and
> > > subsequent commits depending on it and my system now appears to boot
> > > fine with -next (with OF turned on to get the ops for the VIC).  This
> > > code is all a bit deep for me so I've no real idea what might be wrong.
> 
> > The first suspect should be overlapping static mappings in the iotable.
> > This was allowed before and now is not. Looking at some of the 6410
> > platforms, I don't see any though. But you didn't mention which platform
> > you are on. There is a 1KB mapping which is a bit unusual.
> 
> I'm on Cragganmore 6410 which just calls a bunch of arch-generic stuff
> (though now I look I do see a comment saying that we're relying on some
> setup from the bootloader which I get may have been trashed...).

I'm working on a way to get sensible debug messages out.

The problem is that, as soon as we execute this loop in 
devicemaps_init():

        for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
                pmd_clear(pmd_off_k(addr));

we lose all means of communication with the outside world until 
mdesc->map_io() and the following TLB/cache flushes are done.  It is 
most likely that you are having a problem in the middle of that.


Nicolas
