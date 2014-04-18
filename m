From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Fri, 18 Apr 2014 19:47:24 +0200
Subject: [linux-sunxi] Re: [PATCH 7/7] ARM: sun7i: cubietruck: enable
 bluetooth module
In-Reply-To: <CAGb2v67HzB22a3huRRZyufXkdTFE410MhXqAHyC-MmVo0-GCFA@mail.gmail.com>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-8-git-send-email-wens@csie.org>
 <20140415144215.GG3207@lukather>
 <CAGb2v643HyvFdhQ0znreB8ENXHWpcx6tFwdeU7VuU8KYWcT4ZA@mail.gmail.com>
 <20140416094428.GK3207@lukather>
 <CAGb2v67HzB22a3huRRZyufXkdTFE410MhXqAHyC-MmVo0-GCFA@mail.gmail.com>
Message-ID: <20140418174724.GG4132@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 06:39:28PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Apr 16, 2014 at 5:44 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > Please try to keep me in CC, even though the ML doesn't make it easy..
> 
> Sorry about that.
> 
> > On Wed, Apr 16, 2014 at 12:06:59AM +0800, Chen-Yu Tsai wrote:
> >> >> @@ -139,4 +152,16 @@
> >> >>       reg_usb2_vbus: usb2-vbus {
> >> >>               status = "okay";
> >> >>       };
> >> >> +
> >> >> +     rfkill_bt {
> >> >> +             compatible = "rfkill-gpio";
> >> >> +             pinctrl-names = "default";
> >> >> +             pinctrl-0 = <&bt_pwr_pin_cubietruck>, <&clk_out_a_pins_a>;
> >> >> +             clocks = <&clk_out_a>;
> >> >> +             clock-frequency = <32768>;
> >> >> +             gpios = <&pio 7 18 0>; /* PH18 */
> >> >> +             gpio-names = "reset";
> >> >> +             rfkill-name = "bt";
> >> >> +             rfkill-type = <2>;
> >> >> +     };
> >> >
> >> > Hmmm, I don't think that's actually right.
> >> >
> >> > If you have such a device, then I'd expect it to be represented as a
> >> > full device in the DT, probably with one part for the WiFi, one part
> >> > for the Bluetooth, and here the definition of the rfkill device that
> >> > controls it.
> >>
> >> The AP6210 is not one device, but 2 separate chips in one module. Each
> >> chip has its own controls and interface. They just so happen to share
> >> the same enclosure. Even 2-in-1 chips by Broadcom have separate controls
> >> and interfaces. The WiFi side is most likely connected via SDIO, while
> >> the Bluetooth side is connected to a UART, and optionally I2S for sound.
> >
> > It's even easier to represent then.
> >
> >> > But tying parts of the device to the rfkill that controls it, such as
> >> > the clocks, or the frequency it runs at seems just wrong.
> >>
> >> I understand where you're coming from. For devices on buses that require
> >> drivers (such as USB, SDIO) these properties probably should be tied to
> >> the device node.
> >>
> >> For our use case here, which is a bluetooth chip connected on the UART,
> >> there is no in kernel representation or driver to tie them to. Same goes
> >> for UART based GPS chips. They just so happen to require toggling a GPIO,
> >> and maybe enabling a specific clock, to get it running. Afterwards,
> >> accessing it is done solely from userspace. For our Broadcom chips, the
> >> user has to upload its firmware first, then designate the tty as a Bluetooth
> >> HCI using hciattach.
> >>
> >> We are using the rfkill device as a on-off switch.
> >
> > I understand your point, but the fact that it's implemented in
> > user-space, or that UART is not a bus (which probably should be), is
> > only a Linux specific story, and how it's implemented in Linux (even
> > if the whole rfkill node is another one, but let's stay on topic).
> 
> I gave it some thought last night. You are right. My whole approach
> is wrong. But let's try to make it right.
> 
> So considering the fact that it's primarily connected to a UART,
> maybe I should make it a sub-node to the UART node it's actually
> connected to? Something like:
> 
>         uart2: serial at 01c28800 {
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&uart2_pins_a>;
>                 status = "okay";
> 
>                 bt: bt_hci {
>                         compatible = "brcm,bcm20710";
>                         /* maybe add some generic compatible */
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&clk_out_a_pins_a>,
> <&bt_pwr_pin_cubietruck>;
>                         clocks = <&clk_out_a>;
>                         clock-frequency = <32768>;
>                         gpios = <&pio 7 18 0>; /* PH18 */
>                 };
>         };
> 
> And let the uart core handle power sequencing for sub-nodes.
> 
> The rfkill node would still have the gpios and clocks, but not the
> clock-frequency property. It's sole purpose would be to toggle the
> controls. But I think the placement is still odd. Perhaps these
> virtual devices shouldn't live in the DT at all.

Yes, it looks much better.

I agree with you on the virtual devices things, and we have a lot of
other examples unfortunately.

However, since the rfkill nodes are in the DT, I think you'd still
have a rfkill node to handle the gpio, and a reference to the killed
device of some sort.

As far as the clock is concerned, I don't know if it makes sense to
have the BT clock in the RF kill node.

You probably want to use it to gate it whenever the device is killed,
but if the device is setting the frequency, it will more likely hold a
reference to that clock, so calling the disable in rfkill won't do
much.

Is rfkill sending any notification of some sort that the device is
being killed?

> > This is a huge abstraction leak.
> >
> > Let's say you need the I2S stream you mentionned for some
> > reason. Would you tie the audio stream to the rfkill node as well?
> > I'm sorry, but from an hardware description perspective, it makes no
> > sense.
> 
> The above revision should be better, from a hardware perspective. I'm
> not sure how to tie in the I2S stream, and there I haven't found any
> examples in the DT tree.

If it acts like an I2S "consumer", you can use ASoC's simple-card, and
you have a few examples in the other DTs.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/2e2d4cde/attachment.sig>
