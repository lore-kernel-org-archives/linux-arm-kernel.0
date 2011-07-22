From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jul 2011 19:22:42 +0100
Subject: [PATCH, RFC] fix UP futex code to not generate invalid streqt
	instruction
In-Reply-To: <CA+wbFdepS+QNL2QzM87ZHw8kruhaLqhahS9-x=PVsz42fjiWuA@mail.gmail.com>
References: <20009.45690.158286.161591@pilspetsen.it.uu.se>
	<CA+wbFdepS+QNL2QzM87ZHw8kruhaLqhahS9-x=PVsz42fjiWuA@mail.gmail.com>
Message-ID: <20110722182242.GF25947@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 07:12:30PM +0100, Dave Martin wrote:
> Do we have the same potential bug for the __put_user functions in
> arch/arm/include/asm/uaccess.h? Although cases where the two
> relevant arguments could be statically assigned to the same register
> by the compiler will be rare, those macros are used all over the place.

The only time it will happen is if the compiler sees that we're doing
this:

	__put_user(x, x);

In other words, you pass the same argument in for the value and pointer.

That should never happen for two reasons:
1. It will fail the type checking and issue compiler warnings about
   mismatched types.
2. This is silly code.

That goes for the futex case too - it can only happen if you pass in
the same pointer twice (or an alias of it.)  And that's rubbish code.

The only other case it could happen is:

	__put_user(NULL, NULL);

and I mean the constant 'NULL' not some NULL pointer.  Again, this
has to be written explicitly, and writing to address 0 is... very
silly like this.

So, nothing to fix there either.
