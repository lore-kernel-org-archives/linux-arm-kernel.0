From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Mar 2015 09:59:43 +0100
Subject: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
In-Reply-To: <20150325120039.GA16310@ulmo.nvidia.com>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150325101428.GB32677@pengutronix.de>
 <20150325120039.GA16310@ulmo.nvidia.com>
Message-ID: <20150327085942.GA10906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

On Wed, Mar 25, 2015 at 01:00:40PM +0100, Thierry Reding wrote:
> On Wed, Mar 25, 2015 at 11:14:28AM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K?nig wrote:
> > > on arm/i.MX28 the leds connected to a pwm are still broken and it's more
> > > than three years ago that I came up with these patches. I still consider
> > > them to do the right thing and they fix a real bug.
> > I'm really frustrated here. I want to fix a real bug, made several
> > suggestions (with patches) how to fix it and still have to include my
> > local patches in each project that uses leds on i.MX28's pwm output.
> > 
> > Thierry, how can we get this resolved?
> 
> We have a couple of other drivers already solving similar issues. Look
> for example at the pwm-bcm-kona driver. It explicitly sets the duty
> cycle to 0 on ->disable() and then waits for some time before actually
> disabling the clock (specifically to avoid a similar than you seem to
> have on i.MX). See also the notes near the top of the driver source
> file.
> 
> Another example is pwm-samsung. It also has code specifically aimed at
> making sure the signal doesn't unexpectedly stay high after calling
> pwm_disable(). See also the commit message of:
> 
> 	6da89312a39b pwm: samsung: Fix output race on disabling
> 
> Both of these examples sound very similar to what you're describing, so
> I think it'd be best to follow these examples and fix the i.MX driver to
> behave as expected.
Seeing that more hardware behaves like the mxs pwm makes me still more
convinced that the pwm core should be aware of things like double
buffering and different behaviour for disabling. Adding code to fulfil
the API/user expectation to all three (and maybe more?) drivers seems
wrong, don't you think?

There are IMHO two possibilities to define the outcome of
pwm_config(duty=0) + pwm_disable():

 a) the output must be 0
 b) the output is undefined

For a) there are two further cases:

 a1) each driver has to assert a) on its own
 a2) the pwm framework knows about a few common behaviours and can
     handle them.

Currently we are at a1) (which is undocumented in Documentation/pwm.txt
btw). IMHO a1) is the worst of the three alternatives!

BTW, what is the (expected but also undocumented) outcome of

	pwm_set_polarity(polarity=PWM_POLARITY_INVERSED);
	pwm_config(duty=0)
	pwm_disable()

?

> Irrespective of the behaviour of current drivers, the assumptions are
> already codified in the user drivers and they all assume that calling
> pwm_disable() means the PWM is off.
Well, if you call pwm_disable for the mxs pwm, it is disabled
instantly. Disabling just doesn't imply that the output goes to 0.

The problem at hand is updating the configuration doesn't end the
current period. And then stopping the clock lets the output keep the
last driven value.

Considering

	$ git grep \\\<pwm_disable | wc -l
	34

going through all callers and fixing them up for changed semantics
doesn't seem too hard. Still more as there are several false hits
(approx 50%).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
