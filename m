From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 3 Feb 2015 10:37:36 +0100
Subject: [PATCH 2/4] mtd: nand: atmel: Update DT documentation after
 splitting NFC and NAND
In-Reply-To: <54D08AD7.3050209@atmel.com>
References: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417732214-3292-3-git-send-email-boris.brezillon@free-electrons.com>
 <20150202075737.GC3523@norris-Latitude-E6410>
 <20150202104236.649f99ad@bbrezillon> <54D08AD7.3050209@atmel.com>
Message-ID: <20150203103736.3bcc222e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Feb 2015 16:46:15 +0800
Josh Wu <josh.wu@atmel.com> wrote:

> Hi, Boris, Brian
> 
> On 2/2/2015 5:42 PM, Boris Brezillon wrote:
> > Hi Brian,
> >
> > On Sun, 1 Feb 2015 23:57:37 -0800
> > Brian Norris <computersforpeace@gmail.com> wrote:
> >
> >> Hi Boris,
> >>
> >> BTW, this series has a few conflicts with other things I have queued, so
> >> you'll need to refresh.
> > Yes, that's not a problem, but I'd like to be sure this is the way we
> > want to go before rebasing this series.
> >
> >> On Thu, Dec 04, 2014 at 11:30:12PM +0100, Boris Brezillon wrote:
> >>> The NAND and NFC (NAND Flash Controller) were linked together with a
> >>> parent <-> child relationship.
> >>>
> >>> This model has several drawbacks:
> >>> - it does not allow for multiple NAND chip handling while the controller
> >>>    support multi-chip (even though the driver is not ready yet)
> >>> - it mixes NAND partitions and NFC nodes at the same level (which is a bit
> >>>    disturbing)
> >> I agree that this is disturbing. (FWIW, it also seems a bit disturbing
> >> that atmel_nand.c actually registers two different drivers and the tries
> >> to synchronize them; this seems like it could be handled better, but I'm
> >> not sure how at the moment.)
> > Yep, that's my feeling too, but I'm not sure how this could/should be
> > done.
> > My problem here is that the pinmux should be requested by the EBI
> > device because the EBI manages several type of devices and the data and
> > address signals are shared by all the devices, hence the idea of
> > defining the nand chip node under the EBI node.
> > In the other hand, the NFC is not part of the EBI bus, and thus should
> > not be defined under the EBI node.
> >
> > This might lead to the NFC device being probed before the NAND chip,
> > hence the need for this synchronization.
> 
> OMHO, there is another way, which is change the NFC node to many NFC 
> properties, just like PMECC.
> As NFC, PMECC or hamming ecc HW could be part of current NAND node (in 
> sama5, HSMC maybe a better name for this node. )
> 
> And this change can avoid the sync problem and avoid two drivers in 
> atmel_nand.c.

Sorry I don't get it...
You gave a pseudo DT example in your following answers but I still
don't understand how you'll link the NFC and its associated NAND chips.

> 
> >
> >>> - the introduction of the EBI bus implies defining NAND chips under the
> >>>    EBI node, and the ranges available under the EBI node should be
> >>>    restricted to EBI address space, while the NFC references several
> >>>    registers outside of these EBI ranges.
> >> That's an interesting bit. I've actually run across this sort of problem
> >> on other SoCs, where we have a relationship between two pieces of
> >> hardware--the NAND chip and the NAND controller--where the former might
> >> be on one bus (like your EBI bus, with chip selects), and the latter is
> >> part of the top-level MMIO register space.
> >>
> >> But can you elaborate here a bit more? Does the NAND chip actually need
> >> to be represented under your EBI bus?
> > Yes, as said above this is all about pinmux conflicts, the NAND
> > controller has to request the appropriate pinmux for its NAND chips but
> > it will conflict with the pinmux requested by the EBI bus (data and
> > address signals are shared by all the devices connected on the EBI).
> >
> >>> Move the NFC node outside of the NAND node, to get a more future-proof
> >>> model.
> >> I'm curious if an alternative solution might work, maybe one like the
> >> Allwiner NAND (sunxi-nand) DT, which just reverses the roles; the 'NFC'
> >> is the parent of the NAND chip(s). We've seen this pattern in other
> >> contexts too.
> 
> I also prefer this. Then the dt node should looks like finally:
> 
> nand (SMC may be more correct) node {

This nand node contains nand chip nodes, so 'nand' is definitely not
the appropriate name for this node.
We could name it SMC, but I'd like to keep EBI (External Bus
Interface), because the only thing that can register child devices in
linux are busses (or MFD devices :-)).
The SMC (Static Memory Controller) is just a additional control logic
acting on top of the EBI.

>      PMECC properties
>      NFC properties --> we can make the NFC not a node, just many NFC 
> properties.

But all NAND chips will have to point to the same nfc struct, and I'd
rather represent the NFC IP in the DT than hide it into the driver's
logic.
Moreover, the NFC IP is not part of the EBI memory range, so I'd prefer
to keep it outside of the EBI node (though I'm not sure you're trying to
represent the EBI bus here).

> 
>      pinctrl-nand0
>      nand chip 0: {
>          partitions...
>      }
> 
>      pinctrl-nand1
>      nand chip 1: {
>          partitions...
>      }
> }


Could you give a real DT example instead of a pseudo DT representation,
maybe I'll understand what you're suggesting then.

> 
> > I would have preferred this solution too, but the EBI/pinmux constraint
> > explained above prevents this approach.
> I am not very clear about the pinmux constraint.
> Maybe we just leave one DT node (either EBI or current nand node) to 
> take care the pins.
> 
> > What I can do though, is reverse the referencing: reference nand chips
> > from the nand controller node.
> 
> I guess the dt looks like: (correct me if I am wrong)
> 
> EBI node {
>      pinctrl-nand0
>      nand chip 0: {
>          partitions...
>      }
> 
>      pinctrl-nand1
>      nand chip 1: {
>          partitions...
>      }
> }

Well, that's more someting like:

ebi at xxxx {
	pinctrl-0 = <&ebi_data_bus_pins &ebi_addr_bus_pins
		     &ebi_nand_cs0_pin &ebi_nand_rb0_pin ...>;

	nand at 0,xxxx {
		/* ../ */
	};

	nand at 1,xxxx {
		/* ../ */
	}
}

> 
> nand (SMC/HSMC may be more correct) node {
>      PMECC properties
>      NFC properties --> we can make the NFC not a node, just many NFC 
> properties.
> 
>      &nand chip0
>      &nand chip1
> }

Okay, I guess I understand what you were talking about in your previous
suggestion, and I'm not a big fan of this representation.

The SMC IP provides a set of registers to configure external devices
timings (and other related stuff).
Here you're representing NAND chip devices under the SMC node, which is
not exactly how I would represent them.
The IP controlling the available NAND chips is actually the NFC (NAND
Flash Controller).
How about this representation instead ?

nfc at xxxxx {
	nand-chips = <&nand0 &nand1>;
}

Josh, could you rework your proposal with a real DT representation so
that I'll be sure to understand what you're suggesting ?

Thanks.

Best Regards,

Boris



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
