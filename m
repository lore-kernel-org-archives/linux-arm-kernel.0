From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Mar 2010 19:44:11 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201003061156.41136.wolfgang@iksw-muees.de>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<201003040754.57800.wolfgang@iksw-muees.de>
	<20100304093117.GA5282@n2100.arm.linux.org.uk>
	<201003061156.41136.wolfgang@iksw-muees.de>
Message-ID: <20100306194411.GC13262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 06, 2010 at 11:56:41AM +0100, Wolfgang M?es wrote:
> > 3. A page may be read in response to an application issuing a read(2) call.
> >    - the data is read from the kernel mapping, and isn't mapped into a
> >      userspace address.
> > 
> > So, in case (3), flushing the I and D caches could be completely wasteful
> But how do you AVOID the writeback of the data cache in (3)?
> IMHO, the dirty data is in the cache, and the cache will writeback this data 
> on its own.

You don't avoid the writeback - you avoid explicitly causing the
writeback _and_ having to wait for it.

If you're writing data into a page (pio) which you then access via that
same mapping (via read(2)), it is totally pointless to sit in a loop
asking the cache to write the data back to memory.

The point when you need this data written back to memory is the point
where you start to create mappings which may alias with the existing
mapping.  Up until that point, the hardware itself can deal with the
writebacks when it decides it's a good time to do so.

Also, cache replaacement policies may not decide to immediately re-use
the cache lines you've just flushed - which means that by forcing them
to be written back, you're just increasing the overall latency of the
system.
