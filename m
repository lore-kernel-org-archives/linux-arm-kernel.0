From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Apr 2014 00:03:35 +0100
Subject: [PATCH v3 2/2] dt: platform driver: Fill the resources before
 probe and defer if needed
In-Reply-To: <20140418215848.GD21823@atomide.com>
References: <20140320161118.B7075C4067A@trevor.secretlab.ca>
 <1395413185-29763-1-git-send-email-jjhiblot@traphandler.com>
 <1395413185-29763-3-git-send-email-jjhiblot@traphandler.com>
 <CAL_Jsq+aU+rs28gV=Gesb_-Dy6Ht7zuKrRA6_hmqp94Uun23Yg@mail.gmail.com>
 <20140418205213.GA21823@atomide.com>
 <CAL_JsqJvVvo6R-qNXxur7wiZERKbi52xyKoWnmzJTfKS2iKK7A@mail.gmail.com>
 <20140418215848.GD21823@atomide.com>
Message-ID: <20140418230335.GI24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 02:58:48PM -0700, Tony Lindgren wrote:
> Oh come on, let's stop pretending it's not broken. And it's way worse with
> device tree as there's nothing making sure the resources for a driver
> are set up before the driver probes. And we've been unable to fix just
> this issue alone for about six months now. It's also broken beyond that.
> It's called of_platform_bus yet it won't even pass the platform_data
> as auxdata to the devices on a sub-bus instantatiated like I2C.

Isn't there a much simpler solution to the platform device IRQ problem?

Rather than trying to fix it at the point where the resources are
created, why not just *not* have DT create the IRQ resources in the
first place, and instead have platform_get_irq() (which is the function
which should be used to get an IRQ) be the actor to do whatever is
necessary to return the IRQ(s) ?

Yes, I know we have some drivers which use platform_get_resources() with
IORESOURCE_IRQ, but they should really use the right accessor.  And those
who just dereference the resource array directly... get what's coming
(though of course they have to be fixed.)

It has the benefit that you're in a path where you /can/ return
-EPROBE_DEFER too and not have to mess around with notifiers or other
silly stuff like that.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
