From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 11:14:59 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTimLcGEDrexVCyMROYA1x_GsXdpx_6_ziYWVipMp@mail.gmail.com>
References: <20101217231449.GF9937@n2100.arm.linux.org.uk>
	<AANLkTi=-foyb9c5F4tFpGK6KzQnP9htJW8GwYoUHVK0r@mail.gmail.com>
	<20101218000828.GG9937@n2100.arm.linux.org.uk>
	<AANLkTinSg+iCGM64iQqLn32Wjpta_87=HWuG==KJ9-eW@mail.gmail.com>
	<20101218120154.GA4803@n2100.arm.linux.org.uk>
	<AANLkTimG8yuCMOJPz9-ANi_2hf7E2HPYPy9sWaxVPXmE@mail.gmail.com>
	<20101218200443.GM9937@n2100.arm.linux.org.uk>
	<AANLkTikHGX6OQWfGoNiQj-UX81=8_HwP3W+DXwZASatN@mail.gmail.com>
	<20101224173824.GI20587@n2100.arm.linux.org.uk>
	<AANLkTimLcGEDrexVCyMROYA1x_GsXdpx_6_ziYWVipMp@mail.gmail.com>
Message-ID: <20110113111459.GC24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 04:19:40AM -0600, Andrei Warkentin wrote:
> I fully agree. Would you be interested in me bringing back the actual
> synchronization code from platform-dependent code into the preinit
> function and posting that as a patch for review?

I really don't like the idea of a preinit function - it's completely
unnecessary as I've been trying to point out.  It has been shown that
it takes a hundred or so microseconds to get into the kernel, and
then a couple of hundred milliseconds to run the delay loop.

As platforms are expected to wait in their boot_secondary() for the
first half - currently platforms wait one second - we're talking
about around a hundred microseconds vs a timeout of one second.
That's a factor of 10000 beyond what's required.

It has also been shown that the problem you were seeing was down to
synchronization/delayed write bugs which have since been solved - and
adding yet more synchronization is not the answer to buggy
synchronization.

So, as the timeouts are already well in excess and the root cause of
your problem has been resolved, I see no need to make this stuff more
complex - the more complexity there is, the more chance there is of
things going wrong.
