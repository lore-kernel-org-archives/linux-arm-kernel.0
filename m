From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Jan 2013 21:55:14 +0100
Subject: [PATCH] RFC: leds-pwm: don't disable pwm when setting brightness
 to 0
In-Reply-To: <20130103090117.GA1845@avionic-0098.adnet.avionic-design.de>
References: <20121024095603.GH639@pengutronix.de>
 <1351086766-5837-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20121025080346.GB9921@S2101-09.ap.freescale.net>
 <20130103090117.GA1845@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130103205514.GG14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Thu, Jan 03, 2013 at 10:01:18AM +0100, Thierry Reding wrote:
> On Thu, Oct 25, 2012 at 04:03:49PM +0800, Shawn Guo wrote:
> > On Wed, Oct 24, 2012 at 03:52:46PM +0200, Uwe Kleine-K?nig wrote:
> > > This fixes disabling the LED on i.MX28. The PWM hardware delays using
> > > the newly set pwm-config until the beginning of a new period.  It's very
> > > likely that pwm_disable is called before the current period ends. In
> > > case the LED was on brightness=max before the LED stays on because in
> > > the disabled PWM block the period never ends.
> > > 
> > > It's unclear if the mxs-pwm driver doesn't implement the API as expected
> > > (i.e. it should block until the newly set config is effective) or if the
> > > leds-pwm driver makes wrong assumptions. This patch assumes the latter.
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > I'm not sure this is correct, but this is the workaround I'm using until
> > > I get some feed back.
> > 
> > I'm fine with it, since it fixes a real problem.  Let's see what
> > Thierry says.
> 
> I lost track of this thread somehow, so sorry for not getting back to
> you earlier. The root cause of this problem seems to be that it isn't
> very well defined (actually not at all) what is supposed to happen in
> the case when a PWM is disabled.
> 
> There really are only two ways forward: a) we need to write down what
> the PWM subsystem expects to happen when a PWM is disabled or b) keep
> the currently undefined behaviour. With the latter I expect this kind
> of issue to keep popping up every once in a while with all sorts of
> ad-hoc solutions being implemented to solve the problem.
> 
> I think the best option would be to have some definition about what the
> PWM signal should look like after a call to pwm_disable(). However this
> doesn't turn out to be as trivial as it sounds. For instance, the most
> straightforward definition in my opinion would be to specify that a PWM
> signal should be constantly low after the call to pwm_disable(). It is
> what I think most people would assume is the natural disable state of a
> PWM.
> 
> However, one case where a similar problem was encountered involved a
> hardware design that used an external inverter to change the polarity of
> a PWM signal that was used to drive a backlight. In such a case, if the
> controller were programmed to keep the output low when disabling, the
> display would in fact be fully lit. This is further complicated by the
> fact that the controller allows the output level of the disabled PWM
> signal to be configured. This is nice because it means that pretty much
> any scenario is covered, but it also doesn't make it any easier to put
> this into a generic framework.
> 
> Having said that, I'm tempted to go with a simple definition like the
> above anyway and handle obscure cases with board-specific quirks. I
I don't understand what you mean with "the above" here. I guess it's
"PWM signal should be constantly low after the call to pwm_disable".

To cover this we could add a function pwm_disable_blurb() that accepts a
parameter specifying the desired signal state: "high", "low" or (maybe)
"don't care". pwm_disable would then (probably) mean
pwm_disable_blurb("don't care"). But maybe this already contradicts your
idea about being simple and clean?!

Also note that I had another/alternative issue with the API, i.e. when
the pwm routines should return.

> don't see any other alternative that would allow the PWM framework to
> stay relatively simple and clean.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
