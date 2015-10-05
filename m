From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Oct 2015 14:49:49 +0200
Subject: [linux-sunxi] [PATCH 1/3] ARM: dts: sun4i: Allow to use the PH6
 pin for GPIO on pcDuino1/2
In-Reply-To: <20151005083940.78d04f63@i7>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
 <1443985128-23137-2-git-send-email-siarhei.siamashka@gmail.com>
 <CAGb2v65n6ymon+sEASa726sam0KLOvMPbxTxCqvV4j0ust2PCA@mail.gmail.com>
 <20151005083940.78d04f63@i7>
Message-ID: <20151005124949.GM2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 08:39:40AM +0300, Siarhei Siamashka wrote:
> On Mon, 5 Oct 2015 09:55:28 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
> 
> > On Mon, Oct 5, 2015 at 2:58 AM, Siarhei Siamashka
> > <siarhei.siamashka@gmail.com> wrote:
> > > The pcDuino1 board does not use any power switches at all for its
> > > two USB host ports and the VBUS pins are always connected to 5V.
> > >
> > > The pcDuino2 board uses the RT9701GB power switch for its single
> > > USB host port, but the USB_EN pin (PD2) is pulled up with a 10K
> > > resistor. So that the USB power is still enabled by default even
> > > if nobody bothers to configure the PD2 pin or runs the pcDuino1
> > > firmware.
> > 
> > Seems like it would be better if you had a regulator controlled
> > by PD2. At least can shut down VBUS power when it wants to?
> 
> That's a good question.
> 
> Describing the regulator controlled by PD2 in the dts file is surely
> the right solution for pcDuino2 boards. But in the case of using this
> dts for pcDuino1, the kernel would think that it can shut down VBUS
> power, while in fact this is not true.

I do agree that this is the right solution for the pcduino1, but it's
definitely not the right one for the pcduino 2 then.

Declaring this as a regulator isn't just meant for the USB to be
working, it's also meant so that it keeps working. If the pin is not
claimed by anyone, the userspace and / or some other driver, will
actually be able to grab that pin and do whatever it wants with it,
effectively fiddling with the VBUS supply behind the USB driver's
back.

It also allows to disable the regulator if VBUS isn't going to be
used, for example because the driver has not be compiled in, or that
it's actually a module that might (or might not) be loaded later.

Finally, it also allows to keep track of who consumes what amount of
power in the system, which is a nice plus.

> The RT9701GB switch also provides the current limiting feature in
> addition to the ability to enable/disable the VBUS power. Probably
> this was a real reason why it was added to the board.
> 
> Everything boils down to the question whether we want to have a
> common dts file for pcDuino1 and pcDuino2 or decide to split them.

You don't have to split them, if this is really the only difference,
just create a new dts for the pcduino2 that includes the first one,
and add the supply there.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/3159b90f/attachment.sig>
