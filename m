From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 29 May 2015 18:37:09 -0700
Subject: [PATCH v2 3/6] dt-bindings: brcmstb-gpio: document properties
 for wakeup
In-Reply-To: <CADtm3G43-EBUOwAxcT2B-0syzDtpjdyfPmOHmmDsNN8+FgoZAA@mail.gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-4-git-send-email-gregory.0xf0@gmail.com>
 <20150530003613.GW27753@ld-irv-0074>
 <CADtm3G43-EBUOwAxcT2B-0syzDtpjdyfPmOHmmDsNN8+FgoZAA@mail.gmail.com>
Message-ID: <20150530013709.GY27753@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 05:57:50PM -0700, Gregory Fong wrote:
> On Fri, May 29, 2015 at 5:36 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> > On Thu, May 28, 2015 at 07:14:07PM -0700, Gregory Fong wrote:
> >> --- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> >> +++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> >> @@ -33,6 +33,12 @@ Optional properties:
...
> >>  - #interrupt-cells:
> >>      Should be <2>.  The first cell is the GPIO number, the second should specify
> >>      flags.  The following subset of flags is supported:
> >> @@ -48,7 +54,10 @@ Optional properties:
> >>      Marks the device node as an interrupt controller
> >>
> >>  - interrupt-names:
> >> -    The name of the IRQ resource used by this controller
> >> +    The names of the IRQ resources used by this controller
> >
> > If you're specifying names, you should list them here.
> 
> I was wondering about that.  Some bindings have them listed, some
> don't.  In this case I know what names currently exist but there could
> certainly be different ones in the future.  How does that work?  Or am
> I misunderstanding what this field is used for?  Where are the
> documented rules for this?

The only documentation I see is:
Documentation/devicetree/bindings/resource-names.txt

That documents the basics of the *-names properties, not their expected
usage.

In practice, they're only useful if you have enough optional resources
that fixed indexing isn't sufficient, and you need to use
platform_get_resource_byname().

So IMO, their purposes seems to be one of these:
(1) functional (e.g., for get_resource_byname(), when you have more than
    one optional resource)
(2) self-documentation (which might run counter to #1, as you begin
    generating too many unique names)
(3) no purpose

So IMO, if you ever want (1), they shouldn't have instance-specific
naming, but should use something generic to the device class. Otherwise,
they are just self-documentation, and aren't functionally useful. So
IMO, these sorts of names:

	interrupt-names = "upg_gio_aon", "upg_gio_aon_wakeup";

work better as functional descriptions:

	interrupt-names = "gio", "wakeup";

But in the end, I wouldn't foresee you needing to do (1), so you're left
with (2) or (3), at which point I'm not sure if you should even mention
the property.

Just my 2 cents (and those cents may not even be worth face value),
Brian
