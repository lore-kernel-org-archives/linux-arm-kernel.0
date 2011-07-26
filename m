From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jul 2011 11:46:28 +0100
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH
	2/2] GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO
	controller)
In-Reply-To: <20110726100928.GO9653@n2100.arm.linux.org.uk>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
Message-ID: <20110726104628.GP9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 11:09:28AM +0100, Russell King - ARM Linux wrote:
> Hmm, yet another trivial gpio implementation.  We have 24 others just like
> this.  Well, mainline does... I have just one.  Patches after the merge
> window closes.

As an additional note to this: we _really_ need to get on top of the
includes of mach/gpio.h rather than linux/gpio.h - there are around 139
files in mainline (this morning) which include mach/gpio.h directly.

There's one which includes both asm/gpio.h and mach/gpio.h, which is
silly when you look at what asm/gpio.h contains - maybe one attempt
to include mach/gpio.h wasn't enough!

These includes get in the way of consolidating stuff out of mach/gpio.h
into asm/gpio.h - moving stuff out of mach/gpio.h could take it out of
view of these files, thereby causing build errors.

What is even less clear is whether changing these mach/gpio.h includes
to linux/gpio.h is correct or not.

So, what I'd like all platform and all soc maintainers to do is to:

	grep -rl '<mach/gpio.h>' arch/arm drivers

and investigate their files from that list which they're responsible for,
and submit patches to _me_ to fix these includes up (preferably to use
linux/gpio.h).  I'd also like them to do a better job at spotting these
while reviewing patches on the list to help reduce new occurances of
this.

Thanks.
