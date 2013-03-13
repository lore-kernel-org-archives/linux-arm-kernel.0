From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 14 Mar 2013 08:08:41 +1300
Subject: [Bulk] Re: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol
 driver for arch-vt8500
In-Reply-To: <CACRpkdYTKk-fPkUX_jOoHoqxgpsEh2L1ryGC7VSNiAbsmOtcEg@mail.gmail.com>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <513E09FE.5040104@wwwdotorg.org> <1363062095.23051.16.camel@gitbox>
 <CACRpkdYTKk-fPkUX_jOoHoqxgpsEh2L1ryGC7VSNiAbsmOtcEg@mail.gmail.com>
Message-ID: <1363201721.2452.8.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 15:29 +0100, Linus Walleij wrote:
> On Tue, Mar 12, 2013 at 5:21 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> > On Mon, 2013-03-11 at 10:44 -0600, Stephen Warren wrote:
> 
> >> > +Required subnode-properties:
> >> > +- wm,pins: An array of cells. Each cell contains the ID of a pin.
> >>
> >> That's a little odd. Presumably this is to allow configuring "pin
> >> configuration" data beyond the mux function and pull. Why aren't those
> >> options exposed as explicit properties, rather than allowing manual
> >> register tweaking?
> >
> > Little confused about this one - wm,pins is the same as the brcm binding
> > and is the pins being configured.
> >
> > I assume you mean wm,pinmux is confusing.
> >
> > The wm,pinmux does, as you guessed, control some addition pinmux
> > alternate features. I exposed it this way because we don't know what
> > most of the bits in the register do (There is no vendor hardware
> > documentation for these SoCs), and rather than having to churn the code
> > constantly to add the new configurations it seemed to make sense to just
> > expose the register this way and let people configure it in the DT. It
> > is masked so that we can change only the bits we know and leave the rest
> > as configured by the bootloader.
> >
> > Also, it would also add a lot of complexity to the pinctrl code to
> > support the few additional functions we know this register provides
> > because each SoC has a different layout for bits in this register, and
> > we don't actually know which pins/pads are controlled by each bit
> > (again, lack of documentation).
> >
> > I realise this is contradictory to the point of having a pinctrl driver,
> > but it was the best I could come up with given the poor information we
> > have.
> >
> > Always open to suggestions..
> 
> In that case I strongly prefer that you try to encode this into the driver
> as such if that is possible. Putting it into the device tree will be
> subject to flux, and while we can handle some drastic code changes
> internally in the kernel, device trees will need to stay
> backward-compatible.
> 
> Isn't it possible to put a table for this into the kernel code and just
> switch the right numbers in from the compatible= string?
> 
> Yours,
> Linus Walleij

To give an example of what this register does...

On VT8500 we have some basic hardware docs which show this register as:
bit 0 - CCIR/LCD selection
bit 1:2 - AC97/PCM/I2S/Reserved
bit 3:4 - NOR+GUP/SF+NAND/SF+NAND/SF+PATA
bit 5:6 - UART2 disabled/UART1+UART2 pin shared/4 full function UARTS
bit 7 - PATA enable/disable
bit 8:31 - Reserved

It doesn't have any details about which pads are related to which
function, so implementing a proper pinmux feature would be next to
impossible.

The only reason we use this register at present is to enable the LCD
selection (bit 0 in this example - bit 31 on the other SoCs).

Other than that, we rely on uboot to have 'done the right thing'.

Regards
Tony P
