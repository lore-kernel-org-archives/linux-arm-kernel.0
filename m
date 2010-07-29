From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 14:36:47 +0100
Subject: [PATCH 02/12] mmci: fix multi block transfers
In-Reply-To: <000001cb2f22$65576150$300623f0$@tuckley@arm.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
	<20100729131858.GB18923@n2100.arm.linux.org.uk>
	<000001cb2f22$65576150$300623f0$@tuckley@arm.com>
Message-ID: <20100729133646.GC18923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 02:31:48PM +0100, Colin Tuckley wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM
> 
> > So this is good news.  I've applied the first three patches in this
> > series, but we do need to sort out the card detect situation properly
> > before continuing.
> 
> On the subject of card detection. I recently noticed that although it works
> on the PB926 it doesn't on the AB926 despite it being the same kernel
> binary.

No, it doesn't work on Versatile PB926 in mainline (I tried it this morning)
because the card detection (via the ->status callback) is inverted - just
like it was for realview.  What happens is you get commands issued to the
card on card removal, and nothing on card insertion.

What I'm proposing is that we get rid of these multiple levels of negation
that we're gaining.  The negations only add additional complexity and
confusion over what's the right thing to return at any given point.  Lets
stick to one positive logic method throughout the code - 0 means no card,
!0 means card inserted.

That means your original patch needs to be reverted, and we need to change
the 'return !status;' to just 'return status;' in mmci.c's get_cd function
as per my patch.

However, I think this will make GPIO on Realview wrong - iirc, the card
detection bits from PL061 are inverted.
