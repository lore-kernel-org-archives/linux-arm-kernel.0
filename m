From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 28 Sep 2015 14:50:44 +0000
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <1443450406.2168.3.camel@HansenPartnership.com>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <2524822.pQu4UKMrlb@vostro.rjw.lan>
 <1443297128.2181.11.camel@HansenPartnership.com>
 <3461169.v5xKdGLGjP@vostro.rjw.lan>
 <063D6719AE5E284EB5DD2968C1650D6D1CBA3BF7@AcuExch.aculab.com>
 <1443450406.2168.3.camel@HansenPartnership.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBA4232@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Bottomley [mailto:James.Bottomley at HansenPartnership.com]
> Sent: 28 September 2015 15:27
> On Mon, 2015-09-28 at 08:58 +0000, David Laight wrote:
> > From: Rafael J. Wysocki
> > > Sent: 27 September 2015 15:09
> > ...
> > > > > Say you have three adjacent fields in a structure, x, y, z, each one byte long.
> > > > > Initially, all of them are equal to 0.
> > > > >
> > > > > CPU A writes 1 to x and CPU B writes 2 to y at the same time.
> > > > >
> > > > > What's the result?
> > > >
> > > > I think every CPU's  cache architecure guarantees adjacent store
> > > > integrity, even in the face of SMP, so it's x==1 and y==2.  If you're
> > > > thinking of old alpha SMP system where the lowest store width is 32 bits
> > > > and thus you have to do RMW to update a byte, this was usually fixed by
> > > > padding (assuming the structure is not packed).  However, it was such a
> > > > problem that even the later alpha chips had byte extensions.
> >
> > Does linux still support those old Alphas?
> >
> > The x86 cpus will also do 32bit wide rmw cycles for the 'bit' operations.
> 
> That's different: it's an atomic RMW operation.  The problem with the
> alpha was that the operation wasn't atomic (meaning that it can't be
> interrupted and no intermediate output states are visible).

It is only atomic if prefixed by the 'lock' prefix.
Normally the read and write are separate bus cycles.
 
> > You still have to ensure the compiler doesn't do wider rmw cycles.
> > I believe the recent versions of gcc won't do wider accesses for volatile data.
> 
> I don't understand this comment.  You seem to be implying gcc would do a
> 64 bit RMW for a 32 bit store ... that would be daft when a single
> instruction exists to perform the operation on all architectures.

Read the object code and weep...
It is most likely to happen for operations that are rmw (eg bit set).
For instance the arm cpu has limited offsets for 16bit accesses, for
normal structures the compiler is likely to use a 32bit rmw sequence
for a 16bit field that has a large offset.
The C language allows the compiler to do it for any access (IIRC including
volatiles).

	David
