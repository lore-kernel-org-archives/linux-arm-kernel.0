From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 13:47:20 +0200
Subject: [PATCH 2/2] mtd: orion-nand: fix build error with ARMv4
In-Reply-To: <20140513205548.GC22907@obsidianresearch.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <20140509220915.GA391@arch.cereza>
 <20140513205548.GC22907@obsidianresearch.com>
Message-ID: <4645786.pJABUgPlCA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 May 2014 14:55:48 Jason Gunthorpe wrote:
> On Fri, May 09, 2014 at 07:09:15PM -0300, Ezequiel Garcia wrote:
> > On 09 May 03:28 PM, Jason Gunthorpe wrote:
> > > 
> > > > I gave this a try in order to answer Arnd's performance
> > > > question. First of all, the patch seems wrong. I guess it's because
> > > > readsl reads 4-bytes pieces, instead of 8-bytes.
> > > > 
> > > > This patch below is tested (but not completely, see below) and works:
> > > 
> > > Compilers are better now, I think you can just ditch the weirdness:
> > > 
> > [..]
> > > 
> > > The below gives:
> > > 
> > >   c8:   ea000002        b       d8 <orion_nand_read_buf+0x84>
> > >   cc:   e5dc0000        ldrb    r0, [ip]
> > >   d0:   e7c30001        strb    r0, [r3, r1]
> > >   d4:   e2811001        add     r1, r1, #1
> > >   d8:   e1510002        cmp     r1, r2
> > > 
> > > Which looks the same as the asm version to me.
> > > 
> > 
> > Nice! It wasn't really needed but since I have the board here:
> > 
> > # time nanddump /dev/mtd5 -f /dev/null -q
> > real  0m 5.82s
> > user  0m 0.20s
> > sys   0m 5.60s
> > 
> > Jason: Care to submit a proper patch?
> 
> Sure, but did anyone (Arnd?) have thoughts on a better way to do this:
> 
> +#ifdef CONFIG_64BIT
> +               buf64[i++] = readq_relaxed(io_base);
> +#else
> +               buf64[i++] = *(const volatile u64 __force *)io_base;
> +#endif
>
> IMHO, readq should exist on any platform that can issue a 64 bit bus
> transaction, and I expect many ARM's qualify.

Well, the original problem happened specifically for the case that doesn't
have a 64-bit bus transaction (building for ARMv4). If we define
readq_relaxed, it has to be an inline assembly, in order to work for
drivers that require an atomic transaction, so that would have the
same problem. We are a bit inconsistent here though: most 32-bit
architectures have no readq, parisc has one that does two 32-bit accesses,
sh relies on the compiler, and tile apparently has a native instruction.

It seems reasonable to replace the inline assembly in this driver with
a new function as a cleanup, but then how do you want to solve the case
of building a combined armv4/v5 kernel?

	Arnd
