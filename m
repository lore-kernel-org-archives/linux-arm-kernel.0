From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 17 Apr 2016 17:39:08 +0200
Subject: [PATCH v5 13/24] input: misc: max8997: explicitly apply PWM
 config extracted from pwm_args
In-Reply-To: <20160417124548.GE33215@dtor-ws>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
 <1460661464-11216-14-git-send-email-boris.brezillon@free-electrons.com>
 <20160417124548.GE33215@dtor-ws>
Message-ID: <20160417173908.3554ddda@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Sun, 17 Apr 2016 05:45:48 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Thu, Apr 14, 2016 at 09:17:33PM +0200, Boris Brezillon wrote:
> > Call pwm_apply_args() just after requesting the PWM device so that the
> > polarity and period are initialized according to the information provided
> > in pwm_args.
> > 
> > This is an intermediate state, and pwm_apply_args() should be dropped as
> > soon as the atomic PWM infrastructure is in place and the driver makes
> > use of it.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/input/misc/max8997_haptic.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
> > index a806ba3..bf17f65 100644
> > --- a/drivers/input/misc/max8997_haptic.c
> > +++ b/drivers/input/misc/max8997_haptic.c
> > @@ -304,6 +304,12 @@ static int max8997_haptic_probe(struct platform_device *pdev)
> >  				error);
> >  			goto err_free_mem;
> >  		}
> > +
> > +		/*
> > +		 * FIXME: pwm_apply_args() should be removed when switching to
> > +		 * the atomic PWM API.
> > +		 */
> > +		pwm_apply_args(chip->pwm);
> 
> I do not understand. We did not fetch/modify any args, what are we
> applying and why? Especially since we saying we want to remove this
> later.

This is part of the process to allow some PWM users to retrieve the
current PWM state instead of blindly applying a new config. This is
particularly useful when one want a smooth handover between the
bootloader and the kernel, and we have a real case here with a critical
regulator (controlling the DDR voltage) controlled by a PWM device:
the bootloader setup the PWM to 1.2V, and we want the kernel to
retrieve the current PWM config and adjust the duty_cycle according to
the PWM arguments provided by the DT definition.

So, now let's switch to the actual reason for calling pwm_apply_args()
directly from PWM users code. The operations done in pwm_apply_args()
were previously done by the core when the user was requesting the PWM.
Those operations consisted in initializing the PWM period and polarity
to the values specified in the DT or PWM lookup table (what we call
pwm_args).
This is working fine as long as we don't care about the initial PWM
state, but as explained above, that may no longer be the case. That's
why we want PWM users to explicitly state that they don't care about the
initial PWM state and want to apply the default state instead: 
period = pwm_args.period and polarity = pwm_args.polarity.

Once all PWM users have been patched to explicitly call
pwm_apply_args(), we'll be able to remove this call from the core
(patch 17), and let PWM drivers implement ->get_state() to provide
hardware readout (patch 20).

PWM users that are interested in adjusting existing PWM config to the
polarity and period specified in pwm_args will be able to do so instead
of calling pwm_apply_args(). And for those who just don't care about
initial state, they should just call pwm_apply_state() with the initial
state they expect instead of pwm_apply_args(), which is only partially
describing the PWM config (PWM args don't specify whether the PWM
should be disabled or enabled, and what duty_cycle to use).

Hope this clarifies a bit the situation.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
