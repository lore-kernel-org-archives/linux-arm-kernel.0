From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 18 Nov 2015 15:57:03 +0000
Subject: next build: 235 warnings 3 failures (next/next-20151117)
In-Reply-To: <20151118153634.GH1588@arm.com>
References: <564a9961.878b420a.331b8.fffffd62@mx.google.com>
 <6370082.rfihnaNWhf@wuerfel> <20151117171236.GJ30101@arm.com>
 <3723928.99NZh1TC6E@wuerfel> <20151118101427.GC22731@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBD53BB@AcuExch.aculab.com>
 <20151118122804.GD1588@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBD57A5@AcuExch.aculab.com>
 <20151118153634.GH1588@arm.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBD582E@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: 18 November 2015 15:37
> On Wed, Nov 18, 2015 at 03:21:19PM +0000, David Laight wrote:
> > From: Will Deacon
> > > Sent: 18 November 2015 12:28
> > > On Wed, Nov 18, 2015 at 12:11:25PM +0000, David Laight wrote:
> > > > From: Will Deacon
> > > > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386094.html
> > > >
> > > > That patch forces a memory write-read and returns uninitialised stack
> > > > for short reads.
> > >
> > > Really? The disassembly looks fine to me. Do you have a concrete example
> > > of where you think it goes wrong, please?
> > >
> > > > Who knows what happens on big-endian systems.
> > >
> > > The same thing as READ_ONCE? I'll test it there to make sure, but I
> > > don't see a problem.
> >
> > Ah, god, it is absolutely horrid. But probably right :-(
> 
> Yeah, I wasn't pretending it was nice :) FWIW, I've given it a reasonable
> testing in both little-endian and big-endian configurations and it seems
> to be happy.

I was missing the fact that the *(int_type *)&union is always reading
the full union.
The next version of the compiler might decide to barf at the code
that appears to be reading beyond the end of the union.

> > Do all the lda variants zero extend to 64 bits ?
> 
> Yes.
> 
> > If so maybe you could use a single 64 bit variable for the result of the read
> > and then cast it to typeof(*p) to get the required sign extension for
> > small integer types.
> 
> That was the original proposal from Arnd, but I want this to work with
> structures smaller than 64-bit (e.g. arch_spinlock_t), so that's why
> I decided to follow the approach laid down by READ_ONCE.

That would still be ok.
You'd have something that is effectively:
	_u64 val = *p;
	return typeof(*p)val;
The compiler might mask unsigned values - but it may be able to
determine it isn't needed (which is probably true of your version).
For signed types both versions require the compile sign-extend
the value.

	David
