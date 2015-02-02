From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 2 Feb 2015 10:42:36 +0100
Subject: [PATCH 2/4] mtd: nand: atmel: Update DT documentation after
 splitting NFC and NAND
In-Reply-To: <20150202075737.GC3523@norris-Latitude-E6410>
References: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417732214-3292-3-git-send-email-boris.brezillon@free-electrons.com>
 <20150202075737.GC3523@norris-Latitude-E6410>
Message-ID: <20150202104236.649f99ad@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Sun, 1 Feb 2015 23:57:37 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> Hi Boris,
> 
> BTW, this series has a few conflicts with other things I have queued, so
> you'll need to refresh.

Yes, that's not a problem, but I'd like to be sure this is the way we
want to go before rebasing this series.

> 
> On Thu, Dec 04, 2014 at 11:30:12PM +0100, Boris Brezillon wrote:
> > The NAND and NFC (NAND Flash Controller) were linked together with a
> > parent <-> child relationship.
> > 
> > This model has several drawbacks:
> > - it does not allow for multiple NAND chip handling while the controller
> >   support multi-chip (even though the driver is not ready yet)
> > - it mixes NAND partitions and NFC nodes at the same level (which is a bit
> >   disturbing)
> 
> I agree that this is disturbing. (FWIW, it also seems a bit disturbing
> that atmel_nand.c actually registers two different drivers and the tries
> to synchronize them; this seems like it could be handled better, but I'm
> not sure how at the moment.)

Yep, that's my feeling too, but I'm not sure how this could/should be
done.
My problem here is that the pinmux should be requested by the EBI
device because the EBI manages several type of devices and the data and
address signals are shared by all the devices, hence the idea of
defining the nand chip node under the EBI node.
In the other hand, the NFC is not part of the EBI bus, and thus should
not be defined under the EBI node.

This might lead to the NFC device being probed before the NAND chip,
hence the need for this synchronization.

> 
> > - the introduction of the EBI bus implies defining NAND chips under the
> >   EBI node, and the ranges available under the EBI node should be
> >   restricted to EBI address space, while the NFC references several
> >   registers outside of these EBI ranges.
> 
> That's an interesting bit. I've actually run across this sort of problem
> on other SoCs, where we have a relationship between two pieces of
> hardware--the NAND chip and the NAND controller--where the former might
> be on one bus (like your EBI bus, with chip selects), and the latter is
> part of the top-level MMIO register space.
> 
> But can you elaborate here a bit more? Does the NAND chip actually need
> to be represented under your EBI bus?

Yes, as said above this is all about pinmux conflicts, the NAND
controller has to request the appropriate pinmux for its NAND chips but
it will conflict with the pinmux requested by the EBI bus (data and
address signals are shared by all the devices connected on the EBI).

> 
> > Move the NFC node outside of the NAND node, to get a more future-proof
> > model.
> 
> I'm curious if an alternative solution might work, maybe one like the
> Allwiner NAND (sunxi-nand) DT, which just reverses the roles; the 'NFC'
> is the parent of the NAND chip(s). We've seen this pattern in other
> contexts too.

I would have preferred this solution too, but the EBI/pinmux constraint
explained above prevents this approach.
What I can do though, is reverse the referencing: reference nand chips
from the nand controller node.

Josh, Brian, any idea to solve this EBI/nand-chip/nand-controller
dependency problem is welcome.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
