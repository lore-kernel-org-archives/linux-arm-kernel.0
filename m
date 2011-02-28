From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Feb 2011 21:44:45 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
Message-ID: <20110228214445.GD1937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 08:16:25PM +0100, Thomas Gleixner wrote:
> So what's the gain of a barebone chained handler over a regular
> interrupt:
> 
>  - 100 instructions less
>  - lack of statistics

We don't want statistics.  Don't care how many times we go to look
at the interrupt controller - and actually it's really wrong to count
them in the first place.  Counting them means that you double-count
these interrupt events, and the more layers of interrupt controllers
there are the worse that problem gets.

So no, that's a definite argument *for* chained handers.

>  - lack of affinity setting via standard interfaces

Don't want affinity for them, as setting their affinity means that
you then end up forcing the affinity for the sub-interrupts too.
How you do cope with the high-level interrupt having affinity to
CPU0 but a lower level interrupt being affine to CPU1 only?

It's non-sensible, and is broken.  So no, again this isn't an
argument for not using chained handlers.  It's an argument *for*
them.

Sorry, but I think this stuff is right, and chained handlers like
these have their place.
