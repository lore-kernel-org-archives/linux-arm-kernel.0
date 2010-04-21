From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 22 Apr 2010 07:23:58 +1000
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <20100421180737.GE4586@mail.wantstofly.org>
References: <1271838486.2330.139.camel@pasglop>
	<20100421180737.GE4586@mail.wantstofly.org>
Message-ID: <1271885038.2330.172.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lennert !

On Wed, 2010-04-21 at 20:07 +0200, Lennert Buytenhek wrote:
> On Wed, Apr 21, 2010 at 06:28:06PM +1000, Benjamin Herrenschmidt wrote:
> 
> >  - Identifying the board requires the ethernet PHY ID as far as I can
> > tell (at least that's how d-link userspace tools do it). I've put some
> > code in dns323_setup.c to do it, it's a bit gross but I don't think
> > trying to tie links with the ethernet driver would be any cleaner.
> >
> >  - I'm not totally sure what's the right approach for changing the
> > config of the PHY LEDs... the PHY drivers have no hooks for that and no
> > way that I have in mind to pass some platform data or something driver
> > specific like that over.
> 
> Just register a different machine ID for the rev C1 board and pass
> that in from the boot loader, that'll solve all these problems.

Well, first it wouldn't solve the above problem with the PHY driver
since the solution I use with this patch is ... to test the ARM
machine_id() in the PHY driver (since only rev C1 uses that specific PHY
model) :-)

Well, also the bootloader is not mine :-) This is an existing off-the
shelves product from dlink. Though the machine ID it passes is already
wrong so most users do have to append something to the zImage to fix it
up. In any case, I think changing the machine ID would be more confusing
to user and userspace tools.

> > Of course a device-tree would help a lot here but you guys don't
> > have that yet :-)
> 
> A device tree would also be useless here if you would use it to pass
> the kernel incorrect info.

Not sure I follow you here. Let's not get too much into the pro and cons
of the device-tree but basically if I was designing the product, I could
provide LED wiring details to the PHY driver via the PHY node in the
tree without the need for some linkage between the PHY driver and the
patform code. Such linkage is awkward and mostly what is missing here
anyways.

> Yet you wouldn't be blaming the device tree
> mechanism in that case -- while if people pass in the wrong machine IDs,
> it's suddenly the fault of the machine ID system.

Ugh ? The wrong machine ID situation has nothing to do with the problem
at hand here.

> I would agree with you that the machine ID system has some shortcomings,
> but as far as criticism on it goes, I don't think this particular bit is
> valid or fair.  Let's not go overboard on the machine ID system bashing. :-)

Heh, I wasn't bashing the machine ID system specifically here :-) Mostly
pointing out that passing platform/board data to the PHY drivers is
awkward at best (whatever your platform identification method is), and
it's one of those cases where a device-tree can be of some use, as a
kind of passing comment :-) I wasn't really trying to make an
argument :-)

> >  - I whack the SATA LED control register directly from dns323_setup.c, a
> > bit gross but whatever code is already in sata_mv.c doesn't make my LEDs
> > blink :-) I think it fails to set bit 0 but I'm not 100% sure, I haven't
> > had a chance to debug further).
> 
> Are your disks using NCQ?

Brand new off the shelves 1TB disks so I suppose they do. But users
mileage will vary. The original (horrible) code from d-link just
arbitrarily whacks this value into the led control register at boot.
Without that, both my disks LEDs remain off. With that added, they get
slightly lighted when the disks aren't accessed and bright on accesses
which seems to match what the original FW does. As I said, I haven't
taken the time to dig more into this, but I can try to play with things
this week-end.

Do you (or somebody else around) have a spec/doco of the 5182's SATA LED
control register so I have a better idea of what I'm doing ?

Thanks !

Cheers,
Ben.
