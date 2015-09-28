From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 28 Sep 2015 15:31:17 +0000
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <1443453111.2168.9.camel@HansenPartnership.com>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <2524822.pQu4UKMrlb@vostro.rjw.lan>
 <1443297128.2181.11.camel@HansenPartnership.com>
 <3461169.v5xKdGLGjP@vostro.rjw.lan>
 <063D6719AE5E284EB5DD2968C1650D6D1CBA3BF7@AcuExch.aculab.com>
 <1443450406.2168.3.camel@HansenPartnership.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBA4232@AcuExch.aculab.com>
 <1443453111.2168.9.camel@HansenPartnership.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBA42F5@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Bottomley 
> Sent: 28 September 2015 16:12
> > > > The x86 cpus will also do 32bit wide rmw cycles for the 'bit' operations.
> > >
> > > That's different: it's an atomic RMW operation.  The problem with the
> > > alpha was that the operation wasn't atomic (meaning that it can't be
> > > interrupted and no intermediate output states are visible).
> >
> > It is only atomic if prefixed by the 'lock' prefix.
> > Normally the read and write are separate bus cycles.
> 
> The essential point is that x86 has atomic bit ops and byte writes.
> Early alpha did not.

Early alpha didn't have any byte accesses.

On x86 if you have the following:
	struct {
		char  a;
		volatile char b;
	} *foo;
	foo->a |= 4;

The compiler is likely to generate a 'bis #4, 0(rbx)' (or similar)
and the cpu will do two 32bit memory cycles that read and write
the 'volatile' field 'b'.
(gcc definitely used to do this...)

A lot of fields were made 32bit (and probably not bitfields) in the linux
kernel tree a year or two ago to avoid this very problem.

> > > > You still have to ensure the compiler doesn't do wider rmw cycles.
> > > > I believe the recent versions of gcc won't do wider accesses for volatile data.
> > >
> > > I don't understand this comment.  You seem to be implying gcc would do a
> > > 64 bit RMW for a 32 bit store ... that would be daft when a single
> > > instruction exists to perform the operation on all architectures.
> >
> > Read the object code and weep...
> > It is most likely to happen for operations that are rmw (eg bit set).
> > For instance the arm cpu has limited offsets for 16bit accesses, for
> > normal structures the compiler is likely to use a 32bit rmw sequence
> > for a 16bit field that has a large offset.
> > The C language allows the compiler to do it for any access (IIRC including
> > volatiles).
> 
> I think you might be confusing different things.  Most RISC CPUs can't
> do 32 bit store immediates because there aren't enough bits in their
> arsenal, so they tend to split 32 bit loads into a left and right part
> (first the top then the offset).  This (and other things) are mostly
> what you see in code.  However, 32 bit register stores are still atomic,
> which is all we require.  It's not really the compiler's fault, it's
> mostly an architectural limitation.

No, I'm not talking about how 32bit constants are generated.
I'm talking about structure offsets.

	David
