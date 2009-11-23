From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 23:13:53 +0000
Subject: CAS implementation may be broken
In-Reply-To: <20091123222830.GA5598@shareable.org>
References: <4B08055C.3000408@45mercystreet.com>
	<20091123222830.GA5598@shareable.org>
Message-ID: <20091123231353.GJ18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 10:28:30PM +0000, Jamie Lokier wrote:
> That could be an improvement for some algorithms, because often if the
> store doesn't happen, the *inputs* to compare_and_swap() need to be
> recalculated anyway before another try is likely to succeed.  What's
> the point in having code which expands to two loops:

The point is that often its cheaper to retry the LL/SC than it is to
do the recalculation.

However, I don't think you've understood the original problem at all.
The issue is that for a particular 32-bit word, the behaviour required
is:

 - if no change occurs between the _original_ read and the atomic update,
   then go ahead with the update
 - if any change has occured, do not update, but go back and recalculate
   from the beginning.

This is because, even if the value at the pointer is restored back to
the numerically identical value it had at the start, the requirement is
for the store to fail.

No amount of loops (or lack of loops) solves that, even if you have a
proper single atomic 32-bit CAS instruction.

You need to be far more clever, and there's some hints on wikipedia
about possible solutions.  They assume that you can CAS more bits than
your intended value though, which we don't have.

I believe there is a solution to the ABA problem using atomic operations
with one 32-bit word and a separate counter to identify updates, but it
requires a little more time than I have available this evening to fully
put together.
