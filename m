From: simon@sequanux.org (Simon Guinot)
Date: Sun, 17 Oct 2010 15:40:21 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: DNS323 rev C1 fan support
In-Reply-To: <1286987650.9690.175.camel@groeck-laptop>
References: <1274525694.1931.142.camel@pasglop>
	<20101013115951.GA5649@kw.sim.vm.gnt>
	<1286987650.9690.175.camel@groeck-laptop>
Message-ID: <20101017154021.GB29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

Thanks for your comments.

On Wed, Oct 13, 2010 at 09:34:10AM -0700, Guenter Roeck wrote:
> On Wed, 2010-10-13 at 07:59 -0400, Simon Guinot wrote:
> > Hi Benjamin,
> > 
> > What is the status for the DNS323 fan support ?
> > Have this patch been merged yet ?
> > 
> The most recent version I found on the web (dated June 13) has problems
> with error detection and reporting, and fails to remove sysfs files in
> some error conditions. So I would be surprised if it was merged, unless
> there is a more recent version which I missed.
> 
> On a side note, there are several versions of the patch on the web, none
> indicating what has changed between versions. Would be great to have
> such data attached to the various patch versions.
> 
> > I am currently looking to add hwmon support for the GPIO fan found
> > on Network Space Max v2 boards. Obviously, some attributes are shared
> > with the DNS323 fan. Maybe there is some room for a generic GPIO fan
> > driver ?
> > 
> > Platform data could provide the board specific GPIO pinout and a speed
> > conversion array (rpm from/to GPIO value). Here is a proposal for this
> > platform data interface:
> > 
> > struct gpio_fan {
> >         const char      *name;
> >         unsigned        gpio;
> >         unsigned        active_low;
> > };
> > 
> > struct gpio_fan_speed {
> >         int value;
> >         int rpm;
> > };
> > 
> > struct gpio_fan_platform_data {
> >         struct gpio_fan         *alarm; /* fan alarm GPIO. */
> >         struct gpio_fan         *ctrl;  /* fan control GPIOs. */
> >         int                     num_ctrl;
> >         /*
> >          * Speed conversion array: rpm from/to GPIO bit field.
> >          * This array _must_ be sorted in ascending rpm order.
> >          */
> >         struct gpio_fan_speed   *speed;
> >         int                     num_speed;
> > };
> > 
> > Based on this informations the GPIO fan driver could perform the
> > speed conversions (pwm, rpm, GPIO value) and then provide a hwmon
> > interface.
> > 
> Sounds like a good idea to me.
> 
> Couple of comments.
> 
> Personally, I prefer to see num_XXX variables before the actual objects,
> but maybe that is just a personal preference. 

Ok.

> 
> I am not sure what one would do with "active_low". Would that be used
> for the alarm ?

Yes.

> 
> Adding a "fault" object might make sense.

Yes.

> 
> It seems that bit write order is missing. Since it is not always the
> same, as the proposed dns323 driver indicates, that might be a tricky
> problem to solve. You would have to come up with an at least somewhat
> generic solution for that.

Prevent from writing illegal GPIO values during some transitional states
is really a painful task. This workaround looks really due to a hardware
specific limitation. A different GPIO fan hardware could provide
different limitations. As an example, enabling a latch could be needed
to set the fan speed...

No one can predict all the possible hardware designs for a GPIO fan :)

So, rather than dealing with the specific issues within the driver, we
could simply allow board-setup code to override the "generic"
{get,set}_fan_control functions.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101017/505faae0/attachment.sig>
