From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 12 Mar 2013 17:21:35 +1300
Subject: [Bulk] Re: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol
 driver for arch-vt8500
In-Reply-To: <513E09FE.5040104@wwwdotorg.org>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <513E09FE.5040104@wwwdotorg.org>
Message-ID: <1363062095.23051.16.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 10:44 -0600, Stephen Warren wrote:
> On 03/08/2013 10:39 PM, Tony Prisk wrote:
> > This patch adds support for the GPIO/pinmux controller found on the VIA
> > VT8500 and Wondermedia WM8xxx-series SoCs.
> > 
> > Each pin within the controller is capable of operating as a GPIO or as
> > an alternate function. The pins are numbered according to their control
> > bank/bit so that if new pins are added, the existing numbering is maintained.
> > 
> > All currently supported SoCs are included: VT8500, WM8505, WM8650, WM8750 and
> > WM8850.
> 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt
> 
> > +Required properties:
> > +- compatible: "via,vt8500-pinctrl", "wm,wm8505-pinctrl", "wm,wm8650-pinctrl",
> > +	"wm8750-pinctrl" or "wm,wm8850-pinctrl"
> > +- reg: Should contain the physical address of the module's registers.
> > +- gpio-controller: Marks the device node as a GPIO controller.
> > +- #gpio-cells : Should be two. The first cell is the pin number and the
> > +  second cell is used to specify optional parameters.
> 
> Can the GPIOs generate interrupts? If the HW can support this, even if
> the driver doesn't initially support it, the binding should describe the
> required interrupt-controller and #interrupt-cells properties.

Yes they can - we don't have a use-case for them so, as you mentioned,
there is no support. Will add the binding info.

> 
> > +Required subnode-properties:
> > +- wm,pins: An array of cells. Each cell contains the ID of a pin.
> 
> That's a little odd. Presumably this is to allow configuring "pin
> configuration" data beyond the mux function and pull. Why aren't those
> options exposed as explicit properties, rather than allowing manual
> register tweaking?
> 

Little confused about this one - wm,pins is the same as the brcm binding
and is the pins being configured.

I assume you mean wm,pinmux is confusing.

The wm,pinmux does, as you guessed, control some addition pinmux
alternate features. I exposed it this way because we don't know what
most of the bits in the register do (There is no vendor hardware
documentation for these SoCs), and rather than having to churn the code
constantly to add the new configurations it seemed to make sense to just
expose the register this way and let people configure it in the DT. It
is masked so that we can change only the bits we know and leave the rest
as configured by the bootloader.

Also, it would also add a lot of complexity to the pinctrl code to
support the few additional functions we know this register provides
because each SoC has a different layout for bits in this register, and
we don't actually know which pins/pads are controlled by each bit
(again, lack of documentation).

I realise this is contradictory to the point of having a pinctrl driver,
but it was the best I could come up with given the poor information we
have.

Always open to suggestions..

Regards
Tony P 
