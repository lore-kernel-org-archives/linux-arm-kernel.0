From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Nov 2014 19:19:36 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141118181425.GY18842@arm.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <CALCETrUAtAJ1CmuxOFiiu53kAWwofUpFaBeFAZF7Th2VXPbHZg@mail.gmail.com>
 <20141118105611.GC28279@e104818-lin.cambridge.arm.com>
 <20141118181425.GY18842@arm.com>
Message-ID: <20141118191936.GE4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 06:14:25PM +0000, Will Deacon wrote:
> The only way I can see hwcap working is if we follow what the architecture
> allows for in ARMv8, which is 4 bits per feature over (currently) around
> 10 32-bit registers. That would mean potentially exposing 1280 hwcaps,
> which is clearly insane.

Exactly my argument, which got called "rediculous" !  I'm glad that
someone with a similar visibility of the problem has come to the
same conclusion that I did.

> We've done a bit better with the crypto extensions, where we provide
> fine-grained sha1, sha2 etc hwcaps, but this is based on the relavant 4-bit
> fields in ISAR5 being positive values. I can't find any architectural
> guarantees that this will work on future cores (e.g. bumping the 4-bit
> field to indicate a subset of previous functionality).

This is the big problem.  An example of this is the barrier bits, which
indicate whether dmb & dsb are present or not.  It's not a single bit,
but a group of four.  If we provide a single bit for dmb, and another
for dsb (to cater for a future possibility that dmb or dsb may be
separately indicated by a future 4-bit binary pattern), that's fine,
but should we then list every instruction which is conditional on any
ISAR bit pattern?  That becomes a /very/ big space indeed.

If we don't do this, and (eg) we use a single bit for both dmb and dsb,
what if a future bit pattern indicates that (eg) dmb is obsolete, but
dsb hasn't.

Contary to what others assert, this is not a trivial problem, and it's
not trivial to just add additional hwcap bits to solve it.

There's also the problem in /knowing/ what information to export to
userspace, before userspace knows that they need it... which is exactly
what's happened with DMB (and this is not the first time it's happened.)

I suspect this won't be the last time either.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
