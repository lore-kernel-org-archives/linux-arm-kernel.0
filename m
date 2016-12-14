From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Dec 2016 15:15:53 +0100
Subject: [PATCH linux v1 0/4] Seven segment display support
In-Reply-To: <ac324946-41da-c090-a0ca-78155611bb7e@baylibre.com>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
 <20161214125641.GA5379@kroah.com>
 <ac324946-41da-c090-a0ca-78155611bb7e@baylibre.com>
Message-ID: <2512681.Wh85HyB8FH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 14, 2016 2:12:41 PM CET Neil Armstrong wrote:
> On 12/14/2016 01:56 PM, Greg KH wrote:
> > On Wed, Dec 14, 2016 at 01:45:30PM +0100, Thomas Petazzoni wrote:
> >> Hello,
> >>
> >> On Tue, 13 Dec 2016 23:55:00 -0800, Jaghathiswari Rankappagounder
> >> Natarajan wrote:
> >>
> >>> Documentation for the binding which provides an interface for adding clock,
> >>> data and clear signal GPIO lines to control seven segment display.
> >>>
> >>> The platform device driver provides an API for displaying on two 7-segment
> >>> displays, and implements the required bit-banging. The hardware assumed is
> >>> 74HC164 wired to two 7-segment displays.
> >>>
> >>> The character device driver implements the user-space API for letting a user
> >>> write to two 7-segment displays including any conversion methods necessary
> >>> to map the user input to two 7-segment displays.
> >>>
> >>> Adding clock, data and clear signal GPIO lines in the devicetree to control
> >>> seven segment display on zaius platform.
> >>>
> >>> The platform driver matches on the device tree node; the platform driver also
> >>> initializes the character device.
> >>>
> >>> Tested that the seven segment display works properly by writing to the
> >>> character device file on a EVB AST2500 board which also has 74HC164 wired
> >>> to two 7-segment displays.
> >>
> >> FWIW, I proposed a driver for seven segment displays back in 2013:
> >>
> >>    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/139986.html
> >>
> >> And the feedback from Greg KH was: we don't need a driver for that, do
> >> it from userspace. See:
> >>
> >>    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/139992.html
> >>
> >> So: good luck 
> > 
> > Did anyone ever write a library for this type of thing?
> > 
> > Again, I don't want to see one-off drivers for random devices like this
> > that should be able to all be controlled from userspace in a common
> > manner.  Much like we did for fingerprint readers a long long time
> > ago...
> > 

> Actually, it's more than a random interface, a lot of SoCs and boards actually have such displays
> and it's a pity to use UIO, sysfs gpio bitbanging and all sort of ugly stuff to only print a few
> characters a simple and clean driver could achieve.
> Some very well known SoCs even have integrated registers to lower the BOM and bypass the need for
> a 74HC164 like component and avoid gpio bit banging.
> 
> My personal concern is that you could also need to drive more segments, thus 7-segments
> is too restrictive.
> 
> But this driver is well structured, the gpio-bitbanging sub-driver is welcome.

Maybe we can find a way to fit this into the existing drivers/leds/ subsystem?

That already supports blinking, brightness and colour attributes of LEDs,
so could this be extended to support (one of) digit, number, character
or string with a common sysfs attribute and a way to hook up a led driver
to that?

	Arnd
