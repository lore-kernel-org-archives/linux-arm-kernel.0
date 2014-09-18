From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Thu, 18 Sep 2014 17:38:54 +0800
Subject: [PATCH] arm64:free_initrd_mem should also free the memblock
In-Reply-To: <20140917181254.GW12361@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB029@CNBJMBX05.corpusers.net>
 <20140915183334.GA30737@arm.com>
 <20140915184023.GF12361@n2100.arm.linux.org.uk>
 <20140915185027.GC30737@arm.com>
 <35FD53F367049845BC99AC72306C23D103D6DB49160C@CNBJMBX05.corpusers.net>
 <20140917162822.GB15261@e104818-lin.cambridge.arm.com>
 <20140917181254.GW12361@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB49161B@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

mm..
I see your meaning,
But how to debug reserved memory,
I mean how to know which physical memory are reserved in kernel if 
Not use /sys/kernel/debug/memblock/reserved  debug file ?

I think memblock provides a debug interface, so it should keep it 
Correct for debug .

For Catalin 's suggestion,
I am not sure if it is always true to call memblock_free() in
free_reserved_area() , maybe some caller don't want this
behaviors .
So maybe we can introduce another function like free_reserved_area_and_memblock() to implement it.


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Thursday, September 18, 2014 2:13 AM
To: Catalin Marinas
Cc: Wang, Yalin; Will Deacon; 'linux-mm at kvack.org'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'
Subject: Re: [PATCH] arm64:free_initrd_mem should also free the memblock

On Wed, Sep 17, 2014 at 05:28:23PM +0100, Catalin Marinas wrote:
> On Tue, Sep 16, 2014 at 02:53:55AM +0100, Wang, Yalin wrote:
> > The reason that a want merge this patch is that It confuse me when I 
> > debug memory issue by /sys/kernel/debug/memblock/reserved  debug 
> > file, It show lots of un-correct reserved memory.
> > In fact, I also send a patch to cma driver part For this issue too:
> > http://ozlabs.org/~akpm/mmots/broken-out/free-the-reserved-memblock-
> > when-free-cma-pages.patch
> > 
> > I want to remove these un-correct memblock parts as much as 
> > possible, so that I can see more correct info from 
> > /sys/kernel/debug/memblock/reserved
> > debug file .
> 
> Could we not always call memblock_free() from free_reserved_area() 
> (with a dummy definition when !CONFIG_HAVE_MEMBLOCK)?

Why bother?

The next thing is that people will want to have memblock's reserved areas track whether the kernel allocates a page so that the memblock debugging follows the kernel's allocation state.

This is utterly rediculous.  Memblock is purely a method to get the system up and running.  Once it hands memory over to the normal kernel allocators, the reservation information in memblock is no longer valid.

The /useful/ information that it provides is the state of memory passed over to the kernel allocators, which in itself is valuable information.
Destroying it by freeing stuff after that point is not useful.

--
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up according to speedtest.net.
