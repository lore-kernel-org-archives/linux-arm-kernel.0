From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Oct 2013 16:26:03 +0200
Subject: [linux-sunxi] [PATCH 0/4] Add support for the Allwinner A31
 Reset Controllers
In-Reply-To: <CAPNxggb_dhQWPDkO_7LVyyn5537tDThtBU5SY1oZfZhri0QacQ@mail.gmail.com>
References: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAPNxggaUW1B8Ea-gSo+XV2P9s4MRa1L25_ZAvOWyLN6VqQ6wsQ@mail.gmail.com>
 <20131006082917.GD3106@lukather>
 <CAPNxggb_dhQWPDkO_7LVyyn5537tDThtBU5SY1oZfZhri0QacQ@mail.gmail.com>
Message-ID: <20131007142603.GE3106@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 06, 2013 at 11:42:10AM +0200, Arokux X wrote:
> Hi Maxime,
> 
> On Sun, Oct 6, 2013 at 10:29 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Roman,
> >
> > On Sun, Oct 06, 2013 at 01:32:13AM +0200, Arokux X wrote:
> >> On Sat, Oct 5, 2013 at 4:39 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > Hi everyone,
> >> >
> >> > This patchset adds support for the reset controllers found in the Allwinner A31
> >> > SoCs. Since these controllers are pretty simple, basically just a few MMIO
> >> > registers, with a single bit controlling the reset state of the other devices
> >> > it asserts in reset, the driver is quite simple as well.
> >>
> >> I think we need something smarter here. There are reset bits all over
> >> the place. After a hint by Emilio and small chat with Oliver I've
> >> realized I have 3 reset bits in USB host clock module [0].
> >
> > I wasn't aware there were other IPs behaving like this in older SoCs.
> > Thanks for pointing this out.
> >
> > Something smarter in what sense? It's just one bit to put in one
> > register, I don't really see how it can be "smart".
> By something smarter I meant something that prevents you from using
> wrong bits for reset. For example in the USB clock module there are
> only 3 reset bits in a register.

Nothing will ever prevent you from poking in the wrong bits. If your
clock driver has a bug, or if the data coming from device tree are
bogus, it will happen, and there will be no safeguard.

> >> Maybe implementation like this one [1] where a mask can be passed as a
> >> parameter will be more appropriate? (Those reset bits behave the same
> >> as gatable clocks really.)
> >
> > No, they don't behave like gatable clocks, and they shouldn't be
> > implemented with the clock framework. Whenever you disable a clock, the
> > child device will retain its configuration, while with the reset part,
> > well, it will just be reset. This makes one huge difference.
> 
> I'm sorry I wasn't clear. I did not meant to use clock framework for
> reset bits. I was suggesting to implement your driver in a similar
> way. You remember gatable clocks also take several bits per register.
> We are managing them with one function which accepts a mask - ones at
> the positions of the gatable clocks. Now after a closer look at reset
> framework I see that nothing is registered, so the approach taken by
> us with clocks is not possible indeed.

We could do that by overriding the default of_xlate function. I'm not
exactly convinced it makes sense in that case, since bogus data will
possibly come from the DT, and in that case, you are screwed.

> Let me now ask how I should go about my reset bits.
> 
> So far you were dealing with the registers where all the bits were
> used for reset bits. In the case of USB clock module (and several
> others) only several bits are reset bits. So I will proceed to use
> your new driver like this (here, for the sake of clarity I use names
> for registers and reset bits)
> 
> +               usb_rst: reset at USB_CLK_REG {
> +                       #reset-cells = <1>;
> +                       compatible = "allwinner,sun4i-a10-usb-reset";
> +                       reg = <USB_CLK_REG 0x4>;
> +               };
> 
> And somewhere in the EHCI/OHCI binding:
> 
>                  ohci0: .... {
>                           ...
> +                       resets = <&usb_rst USB0_RESET_BIT>;
>                           ...
>                 }
> 
>                  ehci0: .... {
>                           ...
> +                       resets = <&usb_rst USB0_RESET_BIT>;
>                           ...
>                 }
> 
> If I understand right, here is the problem with this approach. As you
> see ohci0/ehci0 are sharing the very same bit. So if device_reset is
> used in both ohci0/ehci0 kernel modules we will have a situation where
> one kernel module will reset the hardware used by the other kernel
> module. The problem is that reset bit really belongs to a USB PHY,
> which is shared between ohci0/ehci0. So as it looks like I would need
> to add another module that handles USB PHY?
> 
>                  usb0-phy: {
>                           resets = <&usb_rst USB0_RESET_BIT>;
>                  }
> 
>                  ohci0: .... {
>                           ...
> +                       phy = <&usb0-phy>
>                           ...
>                 }
> 
>                  ehci0: .... {
>                           ...
> +                       phy = <&usb0-phy>
>                           ...
>                 }

Are those ohci and ehci nodes the same IP?

Anyway, it seems like it's the way to go, yes. There's a USB PHY
framework in review right now: https://lwn.net/Articles/548814/

> By the way, now you can see the advantages of the semantics that clock
> framework is offering. If several devices want to disable a clock it
> will only be disabled if no other devices are using it. Reset
> framework does not offer this feature.

Good thing we have the code and that we can patch it then. However, it's
not much of a problem in our case, since both drivers will only want to
deassert the reset.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/8d8bbf23/attachment.sig>
