From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 4 Jan 2013 17:26:58 -0600
Subject: [PATCH] RFC: leds-pwm: don't disable pwm when setting brightness
 to 0
In-Reply-To: <20130104115551.GA1906@pengutronix.de>
References: <20121024095603.GH639@pengutronix.de>
 <1351086766-5837-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20121025080346.GB9921@S2101-09.ap.freescale.net>
 <20130103090117.GA1845@avionic-0098.adnet.avionic-design.de>
 <20130104115551.GA1906@pengutronix.de>
Message-ID: <CAKGA1bkLbUWj-WX9PaAuHLxG75mX4T5nN0tXZSUtWPNw6wAAvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 4, 2013 at 5:55 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Thu, Jan 03, 2013 at 10:01:18AM +0100, Thierry Reding wrote:
> > On Thu, Oct 25, 2012 at 04:03:49PM +0800, Shawn Guo wrote:
> > > On Wed, Oct 24, 2012 at 03:52:46PM +0200, Uwe Kleine-K?nig wrote:
> > > > This fixes disabling the LED on i.MX28. The PWM hardware delays using
> > > > the newly set pwm-config until the beginning of a new period.  It's
> very
> > > > likely that pwm_disable is called before the current period ends. In
> > > > case the LED was on brightness=max before the LED stays on because in
> > > > the disabled PWM block the period never ends.
> > > >
> > > > It's unclear if the mxs-pwm driver doesn't implement the API as
> expected
> > > > (i.e. it should block until the newly set config is effective) or if
> the
> > > > leds-pwm driver makes wrong assumptions. This patch assumes the
> latter.
> > > >
> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > > Hello,
> > > >
> > > > I'm not sure this is correct, but this is the workaround I'm using
> until
> > > > I get some feed back.
> > >
> > > I'm fine with it, since it fixes a real problem.  Let's see what
> > > Thierry says.
> >
> > I lost track of this thread somehow, so sorry for not getting back to
> > you earlier. The root cause of this problem seems to be that it isn't
> > very well defined (actually not at all) what is supposed to happen in
> > the case when a PWM is disabled.
> >
> > There really are only two ways forward: a) we need to write down what
> > the PWM subsystem expects to happen when a PWM is disabled or b) keep
> > the currently undefined behaviour. With the latter I expect this kind
> > of issue to keep popping up every once in a while with all sorts of
> > ad-hoc solutions being implemented to solve the problem.
> >
> > I think the best option would be to have some definition about what the
> > PWM signal should look like after a call to pwm_disable(). However this
> > doesn't turn out to be as trivial as it sounds. For instance, the most
> > straightforward definition in my opinion would be to specify that a PWM
> > signal should be constantly low after the call to pwm_disable(). It is
> > what I think most people would assume is the natural disable state of a
> > PWM.
> >
> > However, one case where a similar problem was encountered involved a
> > hardware design that used an external inverter to change the polarity of
> > a PWM signal that was used to drive a backlight. In such a case, if the
> > controller were programmed to keep the output low when disabling, the
> > display would in fact be fully lit. This is further complicated by the
> > fact that the controller allows the output level of the disabled PWM
> > signal to be configured. This is nice because it means that pretty much
> > any scenario is covered, but it also doesn't make it any easier to put
> > this into a generic framework.
> >
> > Having said that, I'm tempted to go with a simple definition like the
> > above anyway and handle obscure cases with board-specific quirks. I
> > don't see any other alternative that would allow the PWM framework to
> > stay relatively simple and clean.
> >
> > Now I only have access to a limited amount of hardware and use-cases, so
> > any comments and suggestions as well as requirements on other platforms
> > are very welcome.
>
> How about keeping the current behaviour, so:
>
> duty cycle 0    -> output constant low
> duty cycle 100% -> output constant high
> pwm disabled    -> output unspecified
>
> This would allow the pwm drivers to implement whatever powersaving is
> possible for 0/100%, or, if that's not possible, use pwm_disable for
> powersaving. A pwm client driver wouldn't have to call pwm_en|disable at
> all anymore during runtime (only pwm_enable during probe)
>
> Background is that some board here needs 100% duty cycle to set the
> backlight dark. This inversion can be easily archieved in software, but
> on this board we would expect the pwm_disable output state to be high
> whereas on most other boards we would expect the pwm_disable output
> state to be low. The inversion could also be made in the pwm hardware
> (possible on i.MX for example), I currently don't know what this means
> for the pwm_disable output state.
>
> Overall I think with this a client driver would have full control over
> the output and we would avoid confusion with the pwm_en|disable calls.
>
> Sascha
>


Ack, I prefer the old method too, but the other way around for reasoning;

It could be that pwm_disable actually turns off LCDs as well, but that "0"
brightness is still usable.

pwm_config with whatever brightness is "0" the driver (pwm_bl for example)
should be just configuring the pwm to the lowest permissible duty cycle
(since some panels require the pwm never runs below a certain duty cycle).

That doesn't mean you want to turn the backlight off, and in fact having
the pwm turned off but other logic still turned on is against some panel
datasheets (for instance there may be a backlight enable gpio which also
needs to be turned off if the PWM duty cycle is below the abovementioned
lowest permissible value, and in this case this would be handled by the
abovementioned power management and explicitly pwm_disable somehow).

In this case, pwm_disable should still disable the unit (i.e. toggle some
PWM controller enable bit inside the SoC or peripheral chip), but this is
handled by power management - most likely framebuffer or DRM DPMS activity.

We see however that leds-pwm is an island unto itself and has no clue about
other subsystems, so it has no way of knowing that power management is
required by some other subsystem like display or so.

~

What's really needed for a real fix here is a framebuffer-or-other aware
backlight driver which is a subclass of leds-pwm that actually receives fb
notifier events and can be informed of display power management (dpms or
other) such that it can do the right thing. I think using leds-pwm.c
directly - unless you can guarantee it is under some other control - is
probably a terrible idea for most real-life panel backlights even if it is
a fantastic solution for the big glowing Apple/Sony/Dell logo on the back
of the lid the panel lives on - or the systems where it was intended to run
where display is either off or the backlight is set to a lovely constant
value.

I have about 4 panel reference docs to hand, and I mean real laptop panels
not just developer board RGB ones with low resolutions or 1990's PDA
panels, with some pretty strict requirements and leds-pwm does not cut it.
drivers/video/backlight/pwm_bl.c is DT capable and does this properly as
described above.

So the real fix for i.MX28 is use the correct driver, isn't it?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130104/ae15273c/attachment-0001.html>
