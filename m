From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Oct 2013 22:25:22 +0200
Subject: [linux-sunxi] [PATCH 0/4] Add support for the Allwinner A31
 Reset Controllers
In-Reply-To: <CAPNxggZX+cXpXL4DZstaNm=68=pc=kLUYYZpERLMO9=i3en5Gw@mail.gmail.com>
References: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAPNxggaUW1B8Ea-gSo+XV2P9s4MRa1L25_ZAvOWyLN6VqQ6wsQ@mail.gmail.com>
 <20131006082917.GD3106@lukather>
 <CAPNxggb_dhQWPDkO_7LVyyn5537tDThtBU5SY1oZfZhri0QacQ@mail.gmail.com>
 <20131007142603.GE3106@lukather>
 <CAPNxggZX+cXpXL4DZstaNm=68=pc=kLUYYZpERLMO9=i3en5Gw@mail.gmail.com>
Message-ID: <20131007202522.GA3041@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 09:57:50PM +0200, Arokux X wrote:
> >> Let me now ask how I should go about my reset bits.
> >>
> >> So far you were dealing with the registers where all the bits were
> >> used for reset bits. In the case of USB clock module (and several
> >> others) only several bits are reset bits. So I will proceed to use
> >> your new driver like this (here, for the sake of clarity I use names
> >> for registers and reset bits)
> >>
> >> +               usb_rst: reset at USB_CLK_REG {
> >> +                       #reset-cells = <1>;
> >> +                       compatible = "allwinner,sun4i-a10-usb-reset";
> >> +                       reg = <USB_CLK_REG 0x4>;
> >> +               };
> >>
> >> And somewhere in the EHCI/OHCI binding:
> >>
> >>                  ohci0: .... {
> >>                           ...
> >> +                       resets = <&usb_rst USB0_RESET_BIT>;
> >>                           ...
> >>                 }
> >>
> >>                  ehci0: .... {
> >>                           ...
> >> +                       resets = <&usb_rst USB0_RESET_BIT>;
> >>                           ...
> >>                 }
> >>
> >> If I understand right, here is the problem with this approach. As you
> >> see ohci0/ehci0 are sharing the very same bit. So if device_reset is
> >> used in both ohci0/ehci0 kernel modules we will have a situation where
> >> one kernel module will reset the hardware used by the other kernel
> >> module. The problem is that reset bit really belongs to a USB PHY,
> >> which is shared between ohci0/ehci0. So as it looks like I would need
> >> to add another module that handles USB PHY?
> >>
> >>                  usb0-phy: {
> >>                           resets = <&usb_rst USB0_RESET_BIT>;
> >>                  }
> >>
> >>                  ohci0: .... {
> >>                           ...
> >> +                       phy = <&usb0-phy>
> >>                           ...
> >>                 }
> >>
> >>                  ehci0: .... {
> >>                           ...
> >> +                       phy = <&usb0-phy>
> >>                           ...
> >>                 }
> >
> > Are those ohci and ehci nodes the same IP?
> As far as I understand - yes.

Then, it should be the same DT node. And you get only one driver, that
can handle both the ehci and ohci cases, and problem solved.

> > Anyway, it seems like it's the way to go, yes. There's a USB PHY
> > framework in review right now: https://lwn.net/Articles/548814/
> 
> Thanks a lot for this pointer. This is actually merged already and is
> currently in Greg's usb-next tree
> 
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ff764963479a1b18721ab96e531404c50fefe8b1

Oh, ok :)

> So I'd need to use yet another framework in my miniature glue
> driver... it actually only touches a bunch of registers. :)
> 
> >> By the way, now you can see the advantages of the semantics that clock
> >> framework is offering. If several devices want to disable a clock it
> >> will only be disabled if no other devices are using it. Reset
> >> framework does not offer this feature.
> >
> > Good thing we have the code and that we can patch it then.
> What do you mean?

If that behaviour doesn't fit your needs, change the behaviour, and send
the patches. It's the way things go here.

> > However, it's
> > not much of a problem in our case, since both drivers will only want to
> > deassert the reset.
> 
> It is a problem, since there will be two different modules one for
> ohci and the other for ehci. So if you unload ohci for example it will
> assert (write 0 to) the reset register. The ehci module will get into
> trouble then.

And if no one put the device back into reset, it just works.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/7091aede/attachment-0001.sig>
