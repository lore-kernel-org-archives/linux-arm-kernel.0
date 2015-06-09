From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jun 2015 22:27:09 +0100
Subject: [PATCH 02/15] regmap: kill off set_irq_flags usage
In-Reply-To: <20150609191211.GA14071@sirena.org.uk>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-3-git-send-email-robh@kernel.org>
 <20150609191211.GA14071@sirena.org.uk>
Message-ID: <20150609212709.GJ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 08:12:11PM +0100, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 01:26:28PM -0500, Rob Herring wrote:
> 
> > clear that is really needed. There appears to be a great deal of blind
> > copy and paste of this code.
> 
> Well, I don't think it's blind - IIRC it's just that this code all
> predates the genirq flags and ARM had the opposite default to x86 (I
> guess because of being conservative about all the random interrupt
> controllers you get and what might be hanging off them) so we needed to
> do this dance to get interrupts to work.

It's because there exist platforms where specific IRQs are permanently
asserted, and unexpectedly claiming such an interrupt (eg, through IRQ
probing) would lock the system - at least before we ended up with the
detection in genirq (which has its roots in the ARM code.)

The problem is we're dealing with history here, and flipping ARM from
defaulting to "IRQs not valid" to "All IRQs valid" is a far from
trivial task.

I'd suggest people think carefully about applying these patches.  They
have only been around for a matter of hours, so to rush to apply them
when they haven't been revewied as a whole to assess whether the approach
is the right one is rather hasty.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
