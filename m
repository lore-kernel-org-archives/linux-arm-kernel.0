From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Mar 2010 09:31:17 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201003040754.57800.wolfgang@iksw-muees.de>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<201003040754.57800.wolfgang@iksw-muees.de>
Message-ID: <20100304093117.GA5282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 04, 2010 at 07:54:57AM +0100, Wolfgang M?es wrote:
> ... and this is what *I* don't understand in this discussion. Obviously a 
> flush() in PIO drivers is a clean and quick solution to the problem. And how 
> much execution time will it cost - given the fact that if there is NO flush, 
> the flush operation will not be avoided, only delayed (up to the time the data 
> cache is doing the flush himself). If the data cache is doing the flush BEFORE 
> the data is used in userspace (this includes the most common case of reading 
> large files from the device), there will be no performance impact.

You're assuming that every page is used in the same way.  Here's some
examples where this is wrong:

1. A page is faulted in for an application, and it is a text page.
   - the data read in to the page needs to be visible to the instruction
     stream, so on Harvard architecture machines, this may require cache
     maintainence on both the D and I caches.

2. A page is faulted in for an application's data page.
   - data may be written to the kernel mapping, which may alias with the
     eventual userspace address.  These aliases need to be dealt with, to
     make the data visible to the user mapping of the page.

3. A page may be read in response to an application issuing a read(2) call.
   - the data is read from the kernel mapping, and isn't mapped into a
     userspace address.

So, in case (3), flushing the I and D caches could be completely wasteful
- consider if this file is a 600MB MPEG video file which is being read by
a video player.  There's no need to flush the I cache because MPEG data
will never be executed.  There's no need to flush the D cache because
there isn't a user mapping of that data yet, and therefore there aren't
any aliases.

In case (2), it would be wasteful to flush the I cache - the application
isn't going to execute the data.

In case (1), everything is required to ensure that the instruction stream
can see the instructions.

So, the PG_arch_1 'delayed flush' is not only about delaying flushes until
they're required, it's about eliminating those which are not required to
give additional system performance - maybe to the point where you can
serve MP3 files via NFS with a low enough latency that your player isn't
regularly starved of data because of all the needless flushing going on.
