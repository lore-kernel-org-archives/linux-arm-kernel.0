From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Nov 2015 15:36:34 +0000
Subject: next build: 235 warnings 3 failures (next/next-20151117)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBD57A5@AcuExch.aculab.com>
References: <564a9961.878b420a.331b8.fffffd62@mx.google.com>
 <6370082.rfihnaNWhf@wuerfel> <20151117171236.GJ30101@arm.com>
 <3723928.99NZh1TC6E@wuerfel> <20151118101427.GC22731@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBD53BB@AcuExch.aculab.com>
 <20151118122804.GD1588@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBD57A5@AcuExch.aculab.com>
Message-ID: <20151118153634.GH1588@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 03:21:19PM +0000, David Laight wrote:
> From: Will Deacon
> > Sent: 18 November 2015 12:28
> > On Wed, Nov 18, 2015 at 12:11:25PM +0000, David Laight wrote:
> > > From: Will Deacon
> > > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386094.html
> > >
> > > That patch forces a memory write-read and returns uninitialised stack
> > > for short reads.
> > 
> > Really? The disassembly looks fine to me. Do you have a concrete example
> > of where you think it goes wrong, please?
> > 
> > > Who knows what happens on big-endian systems.
> > 
> > The same thing as READ_ONCE? I'll test it there to make sure, but I
> > don't see a problem.
> 
> Ah, god, it is absolutely horrid. But probably right :-(

Yeah, I wasn't pretending it was nice :) FWIW, I've given it a reasonable
testing in both little-endian and big-endian configurations and it seems
to be happy.

> Do all the lda variants zero extend to 64 bits ?

Yes.

> If so maybe you could use a single 64 bit variable for the result of the read
> and then cast it to typeof(*p) to get the required sign extension for
> small integer types.

That was the original proposal from Arnd, but I want this to work with
structures smaller than 64-bit (e.g. arch_spinlock_t), so that's why
I decided to follow the approach laid down by READ_ONCE.

Will
