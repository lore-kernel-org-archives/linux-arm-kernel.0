From: thommyj@gmail.com (Thommy Jakobsson)
Date: Tue, 10 Sep 2013 13:27:07 +0200 (CEST)
Subject: kmalloc memory slower than malloc
In-Reply-To: <1378807816.4200.6.camel@weser.hi.pengutronix.de>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
 <1378807816.4200.6.camel@weser.hi.pengutronix.de>
Message-ID: <alpine.DEB.2.02.1309101317500.1305@kelly.ryd.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 10 Sep 2013, Lucas Stach wrote:

> How do you init the kmalloc memory? If you do a memset right before the
> test loop your "kmalloc in kernel" will most likely always hit in the L1
> cache, that's why it's really fast to do.
I did do a memset previosly but I removed it to see if I still had the 
difference. So now I don't initilize the memory at all. The run from which 
I attached the times had no initilization at all. Besides, I loop through 
all bytes 10000 times, so I would assume that all would be in cache after 
the first loop.

> 
> The userspace mapping of the kmalloc memory will get a different virtual
> address than the kernel mapping. So if you do a memset in kernelspace,
> but the test loop in userspace you'll always miss the cache as the ARM
> v7 caches are virtually indexed. So the processor always fetches data
> from memory. The performance advantage against an uncached mapping is
> entirely due to the fact that you are fetching whole cache lines
> (32bytes) from memory at once, instead of doing a memory/bus transaction
> per byte.

I thought that the L1 data cache was physically indexed and tagged, 
whereas the instruction cache used virtual indexing. But maybe I'm 
wrong. The L2 cache is physically indexed and tagged though, right? 

Thanks,
Thommy
