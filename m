From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 16 Apr 2014 11:44:28 +0200
Subject: [linux-sunxi] Re: [PATCH 7/7] ARM: sun7i: cubietruck: enable
 bluetooth module
In-Reply-To: <CAGb2v643HyvFdhQ0znreB8ENXHWpcx6tFwdeU7VuU8KYWcT4ZA@mail.gmail.com>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-8-git-send-email-wens@csie.org>
 <20140415144215.GG3207@lukather>
 <CAGb2v643HyvFdhQ0znreB8ENXHWpcx6tFwdeU7VuU8KYWcT4ZA@mail.gmail.com>
Message-ID: <20140416094428.GK3207@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please try to keep me in CC, even though the ML doesn't make it easy..

On Wed, Apr 16, 2014 at 12:06:59AM +0800, Chen-Yu Tsai wrote:
> >> @@ -139,4 +152,16 @@
> >>       reg_usb2_vbus: usb2-vbus {
> >>               status = "okay";
> >>       };
> >> +
> >> +     rfkill_bt {
> >> +             compatible = "rfkill-gpio";
> >> +             pinctrl-names = "default";
> >> +             pinctrl-0 = <&bt_pwr_pin_cubietruck>, <&clk_out_a_pins_a>;
> >> +             clocks = <&clk_out_a>;
> >> +             clock-frequency = <32768>;
> >> +             gpios = <&pio 7 18 0>; /* PH18 */
> >> +             gpio-names = "reset";
> >> +             rfkill-name = "bt";
> >> +             rfkill-type = <2>;
> >> +     };
> >
> > Hmmm, I don't think that's actually right.
> >
> > If you have such a device, then I'd expect it to be represented as a
> > full device in the DT, probably with one part for the WiFi, one part
> > for the Bluetooth, and here the definition of the rfkill device that
> > controls it.
> 
> The AP6210 is not one device, but 2 separate chips in one module. Each
> chip has its own controls and interface. They just so happen to share
> the same enclosure. Even 2-in-1 chips by Broadcom have separate controls
> and interfaces. The WiFi side is most likely connected via SDIO, while
> the Bluetooth side is connected to a UART, and optionally I2S for sound.

It's even easier to represent then.

> > But tying parts of the device to the rfkill that controls it, such as
> > the clocks, or the frequency it runs at seems just wrong.
> 
> I understand where you're coming from. For devices on buses that require
> drivers (such as USB, SDIO) these properties probably should be tied to
> the device node.
> 
> For our use case here, which is a bluetooth chip connected on the UART,
> there is no in kernel representation or driver to tie them to. Same goes
> for UART based GPS chips. They just so happen to require toggling a GPIO,
> and maybe enabling a specific clock, to get it running. Afterwards,
> accessing it is done solely from userspace. For our Broadcom chips, the
> user has to upload its firmware first, then designate the tty as a Bluetooth
> HCI using hciattach.
> 
> We are using the rfkill device as a on-off switch.

I understand your point, but the fact that it's implemented in
user-space, or that UART is not a bus (which probably should be), is
only a Linux specific story, and how it's implemented in Linux (even
if the whole rfkill node is another one, but let's stay on topic).

This is a huge abstraction leak.

Let's say you need the I2S stream you mentionned for some
reason. Would you tie the audio stream to the rfkill node as well?
I'm sorry, but from an hardware description perspective, it makes no
sense.

What's the feeling of the DT maintainers?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/c0798416/attachment-0001.sig>
