From: wolfgang@iksw-muees.de (Wolfgang =?iso-8859-1?q?M=FCes?=)
Date: Sat, 6 Mar 2010 11:56:41 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100304093117.GA5282@n2100.arm.linux.org.uk>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<201003040754.57800.wolfgang@iksw-muees.de>
	<20100304093117.GA5282@n2100.arm.linux.org.uk>
Message-ID: <201003061156.41136.wolfgang@iksw-muees.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Am Donnerstag, 4. M?rz 2010 10:31:17 schrieb Russell King - ARM Linux:
> You're assuming that every page is used in the same way.  Here's some
> examples where this is wrong:
> 
> 1. A page is faulted in for an application, and it is a text page.
>    - the data read in to the page needs to be visible to the instruction
>      stream, so on Harvard architecture machines, this may require cache
>      maintainence on both the D and I caches.
Yes. I think that the EXPECTED behaviour of block devices is to give the 
result of the read back in memory. So the driver should do the flush of the 
data cache.

The invalidation of the I cache should be done by the function which makes 
this piece of data executable. (Have I missed something here?)
 
> 3. A page may be read in response to an application issuing a read(2) call.
>    - the data is read from the kernel mapping, and isn't mapped into a
>      userspace address.
> 
> So, in case (3), flushing the I and D caches could be completely wasteful
But how do you AVOID the writeback of the data cache in (3)?
IMHO, the dirty data is in the cache, and the cache will writeback this data 
on its own.

regards
Wolfgang
-- 
Wahre Worte sind nicht sch?n - Sch?ne Worte sind nicht wahr. (Laotse)
