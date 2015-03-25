From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Mar 2015 13:00:40 +0100
Subject: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
In-Reply-To: <20150325101428.GB32677@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150325101428.GB32677@pengutronix.de>
Message-ID: <20150325120039.GA16310@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 11:14:28AM +0100, Uwe Kleine-K?nig wrote:
> [Cc: += akpm]
> 
> On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K?nig wrote:
> > on arm/i.MX28 the leds connected to a pwm are still broken and it's more
> > than three years ago that I came up with these patches. I still consider
> > them to do the right thing and they fix a real bug.
> I'm really frustrated here. I want to fix a real bug, made several
> suggestions (with patches) how to fix it and still have to include my
> local patches in each project that uses leds on i.MX28's pwm output.
> 
> Thierry, how can we get this resolved?

We have a couple of other drivers already solving similar issues. Look
for example at the pwm-bcm-kona driver. It explicitly sets the duty
cycle to 0 on ->disable() and then waits for some time before actually
disabling the clock (specifically to avoid a similar than you seem to
have on i.MX). See also the notes near the top of the driver source
file.

Another example is pwm-samsung. It also has code specifically aimed at
making sure the signal doesn't unexpectedly stay high after calling
pwm_disable(). See also the commit message of:

	6da89312a39b pwm: samsung: Fix output race on disabling

Both of these examples sound very similar to what you're describing, so
I think it'd be best to follow these examples and fix the i.MX driver to
behave as expected.

Irrespective of the behaviour of current drivers, the assumptions are
already codified in the user drivers and they all assume that calling
pwm_disable() means the PWM is off.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/a0804a90/attachment.sig>
