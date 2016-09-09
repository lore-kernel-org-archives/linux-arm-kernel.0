From: oliver@schinagl.nl (Olliver Schinagl)
Date: Fri, 09 Sep 2016 11:01:08 +0200
Subject: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse
 before disable
In-Reply-To: <20160906195149.GJ9040@lukather>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather> <1473145976.731.20.camel@schinagl.nl>
 <20160906195149.GJ9040@lukather>
Message-ID: <1473411668.731.75.camel@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On di, 2016-09-06 at 21:51 +0200, Maxime Ripard wrote:
> On Tue, Sep 06, 2016 at 09:12:56AM +0200, Olliver Schinagl wrote:
> > 
> > Hi Maxime!,
> > 
> > On za, 2016-08-27 at 00:19 +0200, Maxime Ripard wrote:
> > > 
> > > On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> > > > 
> > > > 
> > > > When we inform the PWM block to stop toggeling the output, we
> > > > may
> > > > end up
> > > > in a state where the output is not what we would expect (e.g.
> > > > not
> > > > the
> > > > low-pulse) but whatever the output was at when the clock got
> > > > disabled.
> > > > 
> > > > To counter this we have to wait for maximally the time of one
> > > > whole
> > > > period to ensure the pwm hardware was able to finish. Since we
> > > > already
> > > > told the PWM hardware to disable it self, it will not continue
> > > > toggling
> > > > but merly finish its current pulse.
> > > > 
> > > > If a whole period is considered to much, it may be contemplated
> > > > to
> > > > use a
> > > > half period + a little bit to ensure we get passed the
> > > > transition.
> > > > 
> > > > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > > > ---
> > > > ?drivers/pwm/pwm-sun4i.c | 11 +++++++++++
> > > > ?1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > index 03a99a5..5e97c8a 100644
> > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > @@ -8,6 +8,7 @@
> > > > ?
> > > > ?#include <linux/bitops.h>
> > > > ?#include <linux/clk.h>
> > > > +#include <linux/delay.h>
> > > > ?#include <linux/err.h>
> > > > ?#include <linux/io.h>
> > > > ?#include <linux/module.h>
> > > > @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct
> > > > pwm_chip
> > > > *chip, struct pwm_device *pwm)
> > > > ?	spin_lock(&sun4i_pwm->ctrl_lock);
> > > > ?	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > > ?	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > +
> > > > +	/* Allow for the PWM hardware to finish its last
> > > > toggle.
> > > > The pulse
> > > > +	?* may have just started and thus we should wait a
> > > > full
> > > > period.
> > > > +	?*/
> > > > +	ndelay(pwm_get_period(pwm));
> > > 
> > > Can't that use the ready bit as well?
> > It depends whatever is cheaper. If we disable the pwm, we have to
> > commit that request to hardware first. Then we have to read back
> > the
> > has ready and in the strange situation it is not, wait for it to
> > become
> > ready?
> 
> If it works like you were suggesting, yes.
> 
> > 
> > Also, that would mean we would loop in a spin lock, or keep
> > setting/clearing an additional spinlock to read the ready bit.
> 
> You're using a spin_lock, so it's not that bad, but I was just
> suggesting replacing the ndelay.
If you say the spin_lock + wait for the ready is just as expensive as
the ndelay, or the ndelay is less preferred, then I gladly make the
change; but I think we need the ndelay for the else where we do not
have the ready flag (A10 or A13 iirc?)

Olliver

> 
> Maxime
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/7bea2d30/attachment.sig>
