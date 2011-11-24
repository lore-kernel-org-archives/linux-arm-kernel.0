From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Nov 2011 12:59:38 -0500 (EST)
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111124160853.GB2509@sirena.org.uk>
References: <20111123130134.GB12227@opensource.wolfsonmicro.com>
 <20111123133237.GC7382@totoro>
 <20111123135033.GA20272@opensource.wolfsonmicro.com>
 <20111123143322.GD7382@totoro>
 <20111123145517.GE20272@opensource.wolfsonmicro.com>
 <4ECD32CA.2030601@gmail.com>
 <20111123175446.GI30049@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
 <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
 <20111124125615.GJ8470@opensource.wolfsonmicro.com>
 <20111124160853.GB2509@sirena.org.uk>
Message-ID: <alpine.LFD.2.02.1111241254310.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Nov 2011, Mark Brown wrote:

> On Thu, Nov 24, 2011 at 12:56:16PM +0000, Mark Brown wrote:
> > On Wed, Nov 23, 2011 at 07:32:58PM -0500, Nicolas Pitre wrote:
> 
> > > That should provide you with the ability to figure out what's wrong.
> 
> > Found one problem which I just sent a patch for, iotable_init() was not
> > coping with being passed an empty table which it had previously been OK
> > with.  However, the boot still dies shortly afterwards when we try to
> > read the CPU ID in s3c64xx_init_cpu() and presumably take an exception
> > due to the system address either not being mapped or mapped somewhere
> > other than where the code expects.
> 
> I went back and had another look at this - the reason we're dying in
> s3c64xx_init_cpu() is that it attempts to use the virtual address to
> read the ID register but due to the debug patch Nicholas provided to
> keep the serial port alive when I have DEBUG_LL turned on the mappings
> set up by the CPU initialization were not actually being used by the
> kernel yet.  The upshot is that the boot problems in current -next are
> fixed by the combination of the irq_domain patch and the patch I posted
> earlier today and DEBUG_LL will need something a bit different to keep
> it running while doing the remapping.

No.  The s3c64xx code is wrong.  It relies on a freshly installed 
mapping that has not been flushed to RAM yet.  So when it works for you, 
That's due to pure luck, most probably because the page table is not 
cached when the mapping is created and the cache is not allocated on 
write.


Nicolas
