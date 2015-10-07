From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Wed, 7 Oct 2015 08:11:34 +0300
Subject: [linux-sunxi] [PATCH 1/3] ARM: dts: sun4i: Allow to use the PH6
 pin for GPIO on pcDuino1/2
In-Reply-To: <20151005085853.2dd2373b@i7>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
 <1443985128-23137-2-git-send-email-siarhei.siamashka@gmail.com>
 <CAGb2v65n6ymon+sEASa726sam0KLOvMPbxTxCqvV4j0ust2PCA@mail.gmail.com>
 <20151005083940.78d04f63@i7> <20151005085853.2dd2373b@i7>
Message-ID: <20151007081134.39d0992b@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Oct 2015 08:58:53 +0300
Siarhei Siamashka <siarhei.siamashka@gmail.com> wrote:

> On Mon, 5 Oct 2015 08:39:40 +0300
> Siarhei Siamashka <siarhei.siamashka@gmail.com> wrote:
> 
> > On Mon, 5 Oct 2015 09:55:28 +0800
> > Chen-Yu Tsai <wens@csie.org> wrote:
> > 
> > > On Mon, Oct 5, 2015 at 2:58 AM, Siarhei Siamashka
> > > <siarhei.siamashka@gmail.com> wrote:
> > > > The pcDuino1 board does not use any power switches at all for its
> > > > two USB host ports and the VBUS pins are always connected to 5V.
> > > >
> > > > The pcDuino2 board uses the RT9701GB power switch for its single
> > > > USB host port, but the USB_EN pin (PD2) is pulled up with a 10K
> > > > resistor. So that the USB power is still enabled by default even
> > > > if nobody bothers to configure the PD2 pin or runs the pcDuino1
> > > > firmware.
> > > 
> > > Seems like it would be better if you had a regulator controlled
> > > by PD2. At least can shut down VBUS power when it wants to?
> > 
> > That's a good question.
> > 
> > Describing the regulator controlled by PD2 in the dts file is surely
> > the right solution for pcDuino2 boards. But in the case of using this
> > dts for pcDuino1, the kernel would think that it can shut down VBUS
> > power, while in fact this is not true.
> > 
> > The RT9701GB switch also provides the current limiting feature in
> > addition to the ability to enable/disable the VBUS power. Probably
> > this was a real reason why it was added to the board.
> > 
> > Everything boils down to the question whether we want to have a
> > common dts file for pcDuino1 and pcDuino2 or decide to split them.
> > Based on the schematics comparison, there do not seem to be any
> > substantial differences between these boards if we ignore the PD2
> > pin altogether. LinkSprite says that "Ubuntu images are same for
> > both pcDuino1 and pcDuino2" at their website:
> >     http://www.linksprite.com/?page_id=809
> > 
> > And I actually like their decision to have the PD2 pin pulled-up.
> 
> I'm not sure if everyone would like this, but the following trick
> works. If we configure the PD2 pin as input with pull-down on the SoC
> side and read it, then it still reads as 1 on pcDuino2. Which means
> that the pull-up is apparently stronger (by how much and whether this
> is really reliable is another question). It should read as 0 on
> pcDuino1 and we might use this to detect the board type at runtime.
> 
> Still it is probably an overkill for just this really minor thing :-)

I few more details about this. I have actually measured the voltage
with/without pull-down on the SoC side (which competes with the 10K
pull-up resistor on the PCB) and the results are the following. The
voltage drops from 3.306V to 3.187V on one board and from 3.325V to
3.204V on another. Based on these numbers, we can in estimate
pull-down resistors used for GPIO inside of the A10 SoC as something
like ~270K Ohm.

As such, it looks like we can do reliable runtime detection of
pcDuino1 and pcDuino2 variants by probing this PD2 pin. The most
appropriate place to do the runtime detection is probably the board
type selection stub (sunxi-bootsetup), run as the initial part of
a Linux distribution installer. We are perfectly fine having
separate dts files for the pcDuino1/pcDuino2 boards and the
kernel does not need to become more complicated.

Probing for pull-up and pull-down resistors on the PCB can be
generalized beyond just PD2 and used to further narrow down the
selection of compatible boards (sunxi-bootsetup currently only
considers the SoC type, DRAM size and DRAM bus width for this).

Additional very interesting observation is that the reference
Allwinner schematics and Cubieboard/Cubietruck boards use 510K
pull-down resistor for the USB power switches. With 270K pull-up
by the SoC and 510K pull-down by a resistor on the PCB, the
resulting voltage is going to be around ~2.2V, which should be
enough to be interpreted as digital 1. And indeed, a quick test
shows that if we just configure either PH3 or PH6 pin as input
with pull-up, then the corresponding USB port gets powered up
on the Cubieboard :-)

There are two important consequences:
* As far as generic device independent code is concerned, we can
  reasonably safely enable USB power on the Cubieboard, Cubietruck
  and other device, which did not deviate from the reference
  Allwinner schematics and used 510K pull-down resistors. Configuring
  pins for input can't possibly do much harm (if any at all).
* By doing run-time checks, we can see the difference between the
  boards using 10K pull-down resistors (OLIMEX boards) and the boards
  using 510K pull-down resistors (CubieTech boards).

-- 
Best regards,
Siarhei Siamashka
