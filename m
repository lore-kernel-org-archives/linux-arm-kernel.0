From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 11 May 2012 13:12:05 -0600
Subject: [PATCH 4/7] drivers/gpio: gpio-nomadik: Provide documentation for
 Device Tree bindings
In-Reply-To: <4F83E041.7040108@linaro.org>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-5-git-send-email-lee.jones@linaro.org>
 <20120406042054.C0C433E0C86@localhost> <4F83E041.7040108@linaro.org>
Message-ID: <20120511191205.9BD0E3E0791@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Apr 2012 08:24:49 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> On 06/04/12 05:20, Grant Likely wrote:
> > On Thu,  5 Apr 2012 10:55:45 +0100, Lee Jones<lee.jones@linaro.org>  wrote:
> >> Add required documentation for specific gpio-nomadik DT bindings.
> >>
> >> Signed-off-by: Lee Jones<lee.jones@linaro.org>
> >> ---
> >>   .../devicetree/bindings/gpio/gpio-nmk.txt          |   29 ++++++++++++++++++++
> >>   1 files changed, 29 insertions(+), 0 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-nmk.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
> >> new file mode 100644
> >> index 0000000..1555029
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
> >> @@ -0,0 +1,29 @@
> >> +Nomadik GPIO controller
> >> +
> >> +Required properties:
> >> +- compatible           : Should be "stmicroelectronics,nomadik-gpio".
> >
> > "stmicroelectronics," is a really long prefix.  You can use simply
> > "st," here since it has already been defined and documented in
> > Documentation/devicetree/bindings/vendor-prefixes.txt
> 
> Absolutely.
> 
> >> +- reg                  : Physical base address and length of the controller's registers.
> >> +- interrupts           : The interrupt outputs from the controller.
> >> +- #gpio-cells          : Should be two:
> >> +                           The first cell is the pin number.
> >> +                           The second cell is used to specify optional parameters:
> >> +                             - bits[3:0] trigger type and level flags:
> >> +                                 1 = low-to-high edge triggered.
> >> +                                 2 = high-to-low edge triggered.
> >> +                                 4 = active high level-sensitive.
> >> +                                 8 = active low level-sensitive.
> >
> > Those look like interrupt flags, not gpio flags.  If the gpio lines
> > can be used as generic irq input lines, then this node should also
> > declare itself as an interrupt controller.
> 
> They can and it will do in an up-coming patch.
> 
> >> +- gpio-controller      : Marks the device node as a GPIO controller.
> >> +- supports-sleepmode   : Specifies whether controller can sleep or not
> >
> > Typically, custom properites that are for a specific device should be
> > prefixed with the manufacturer name.  So, something like:
> > "st,has-sleepmode".
> 
> No problem.
> 
> >> +- gpio-bank            : Specifies which bank a controller owns.
> >
> > What is this for (how is it used)?  It shouldn't be needed to specify
> > a bank number.
> 
> Briefly, it is used like this:
> 
> of_property_read_u32(np, "gpio-bank", &bank);
> chip->base = bank * NMK_GPIO_PER_CHIP;
> nmk_chip->bank = bank;
> 
> Is that wrong? If so, is there a better way to do it?

(sorry for the late reply on this, I've been tied up with other stuff.
I know you've posted updated patches, but I haven't looked at them
yet.  This answer may be obsolete by now, but I'm sending it anyway
for background).

It's not strictly wrong, but it looks a lot like the "cell-index"
pattern which is appropriate sometimes, but always comes under
scrutiny first.  It makes me wonder what the driver needs it for.  ie.
Are the banks all part of a single GPIO device?  If they are really
independent, the the bank number should be irrelevant because the base
address identifies how to control the device.  Or, is there a shared
resource that needs the bank number to access correctly?

If they a single device then a better binding might be a single node
with #gpio-cells = <3> with the first cell specifying a bank and the
second specifying the gpio number.  Or if the GPIOs appear in a flat
number space, then you could use the exact same numbering as found in
the user-manual for the chip.

g.
