From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 13 May 2014 14:55:48 -0600
Subject: [PATCH 2/2] mtd: orion-nand: fix build error with ARMv4
In-Reply-To: <20140509220915.GA391@arch.cereza>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-4-git-send-email-arnd@arndb.de>
 <20140509184505.GA30330@arch.cereza>
 <20140509212810.GF18257@obsidianresearch.com>
 <20140509220915.GA391@arch.cereza>
Message-ID: <20140513205548.GC22907@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 07:09:15PM -0300, Ezequiel Garcia wrote:
> On 09 May 03:28 PM, Jason Gunthorpe wrote:
> > 
> > > I gave this a try in order to answer Arnd's performance
> > > question. First of all, the patch seems wrong. I guess it's because
> > > readsl reads 4-bytes pieces, instead of 8-bytes.
> > > 
> > > This patch below is tested (but not completely, see below) and works:
> > 
> > Compilers are better now, I think you can just ditch the weirdness:
> > 
> [..]
> > 
> > The below gives:
> > 
> >   c8:   ea000002        b       d8 <orion_nand_read_buf+0x84>
> >   cc:   e5dc0000        ldrb    r0, [ip]
> >   d0:   e7c30001        strb    r0, [r3, r1]
> >   d4:   e2811001        add     r1, r1, #1
> >   d8:   e1510002        cmp     r1, r2
> > 
> > Which looks the same as the asm version to me.
> > 
> 
> Nice! It wasn't really needed but since I have the board here:
> 
> # time nanddump /dev/mtd5 -f /dev/null -q
> real	0m 5.82s
> user	0m 0.20s
> sys	0m 5.60s
> 
> Jason: Care to submit a proper patch?

Sure, but did anyone (Arnd?) have thoughts on a better way to do this:

+#ifdef CONFIG_64BIT
+               buf64[i++] = readq_relaxed(io_base);
+#else
+               buf64[i++] = *(const volatile u64 __force *)io_base;
+#endif

IMHO, readq should exist on any platform that can issue a 64 bit bus
transaction, and I expect many ARM's qualify.

> On 08 May 04:56 PM, Arnd Bergmann wrote:

> Ok, so it takes 5.6 seconds in kernel mode to access 31MB, which
> comes down to 5.60MB/s. That isn't very fast compared to the time
> the CPU should take for those instructions, so I'm surprised it
> actually makes any difference at all.

Likely, what is happening is that the bus interface is holding off
returning the read data until it complets the bus cycles, then the
response travels to the CPU which turns around another.

This creates a dead time where the bus isn't do anything.

The larger bus transfer the CPU can do the less percentage of time the
turnaround takes as overhead.

If the cpu could pipeline two reads then it could be highest-possible,
but I guess the memory ordering for the mapping prevents that??

Regarding DMA, who knows if the interface can handle a burst
transfer..

Jason
