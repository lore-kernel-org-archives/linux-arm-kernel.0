From: simon@sequanux.org (Simon Guinot)
Date: Tue, 19 Oct 2010 19:30:43 +0000
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <20101019151512.GB13908@ericsson.com>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101019065221.GA12406@ericsson.com>
	<20101019083656.GE29120@kw.sim.vm.gnt>
	<20101019151512.GB13908@ericsson.com>
Message-ID: <20101019193043.GH29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Tue, Oct 19, 2010 at 08:15:12AM -0700, Guenter Roeck wrote:
> Hi Simon,
> 
> On Tue, Oct 19, 2010 at 04:36:56AM -0400, Simon Guinot wrote:
> 
> [ ... ]
> 
> > /* Designed for fan 40x40x16: ADDA AD0412LB-D50 6000rpm at 12v */
> > static struct gpio_fan_speed netspace_max_v2_fan_speed[] = {
> >         {    0,  0 },
> >         { 1500, 15 },
> >         { 1700, 14 },
> >         { 1800, 13 },
> >         { 2100, 12 },
> >         { 3100, 11 },
> >         { 3300, 10 },
> >         { 4300,  9 },
> >         { 5500,  8 },
> > };
> > 
> > The function rpm_speed(index) is really not linear. I am not sure about
> > the resulting behaviour when this will be used by a userland fan control
> > process...
> > 
> > If the pwm interface must be exported, I think we have to respect the
> > fan speed array. But as you said, maybe the work is rather on the
> > fancontrol script side.
> > 
> Not sure if there is an expectation that the mapping pwm->speed has
> to be linear. One might as well argue that steps should be equally
> far apart to ensure that results are better predictable.
> 
> > As a first step, we could keep the heavy pwm interface. Once the
> > fancontrol script (or something else) will be able to handle the rpm
> > attributes, we will drop the pwm compatibility.
> > Simply remove the gpio-fan pwm interface seems a good option too...
> > 
> I think we should keep the pwm interface after all. Changing fancontrol
> is a possibility, but the change would take a while to make it upstream.

Yes, I understand. I will probably look soon into fancontrol.
Some of the cheapest LaCie board have a fan and no temperature sensors.
The embedded system get a more or less accurate temperature from the
hard drive sensor via SMART commands :)
I'd like to have some userspace fan support for this boards too.

> 
> As for the actual code, I would prefer the simpler implementation, but I am willing 
> to go with the complex one if you feel wtrongly about it. Only thing I would ask you
> to do is to add an explanation of what is done and why.

Looking at the pwm_to_rpm() and rpm_to_pwm() functions, I can't feel
strongly a such implementation (but maybe wrongly).
So... I have changed my mind. The simpler implementation make sense:
the pwm value will simply map the speed index.
Moreover it appear to be very usable from a userspace point.

> 
> Reminds me - you'll also have to provide Documentation/hwmon/gpio-fan.

Ok.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/ebed0881/attachment.sig>
