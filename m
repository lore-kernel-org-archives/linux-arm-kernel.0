From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 28 Sep 2015 08:58:17 +0000
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <3461169.v5xKdGLGjP@vostro.rjw.lan>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <2524822.pQu4UKMrlb@vostro.rjw.lan>
 <1443297128.2181.11.camel@HansenPartnership.com>
 <3461169.v5xKdGLGjP@vostro.rjw.lan>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBA3BF7@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafael J. Wysocki
> Sent: 27 September 2015 15:09
...
> > > Say you have three adjacent fields in a structure, x, y, z, each one byte long.
> > > Initially, all of them are equal to 0.
> > >
> > > CPU A writes 1 to x and CPU B writes 2 to y at the same time.
> > >
> > > What's the result?
> >
> > I think every CPU's  cache architecure guarantees adjacent store
> > integrity, even in the face of SMP, so it's x==1 and y==2.  If you're
> > thinking of old alpha SMP system where the lowest store width is 32 bits
> > and thus you have to do RMW to update a byte, this was usually fixed by
> > padding (assuming the structure is not packed).  However, it was such a
> > problem that even the later alpha chips had byte extensions.

Does linux still support those old Alphas?

The x86 cpus will also do 32bit wide rmw cycles for the 'bit' operations.

> OK, thanks!

You still have to ensure the compiler doesn't do wider rmw cycles.
I believe the recent versions of gcc won't do wider accesses for volatile data.

	David
