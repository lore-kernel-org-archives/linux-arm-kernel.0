From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Apr 2014 13:28:23 +0200
Subject: [PATCH 09/16] avr32/at32ap: switch to the generic PWM framework
In-Reply-To: <20140319141820.GA20872@samfundet.no>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-10-git-send-email-alexandre.belloni@free-electrons.com>
 <20140319141820.GA20872@samfundet.no>
Message-ID: <20140407112821.GC26985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 03:18:20PM +0100, Hans-Christian Egtvedt wrote:
> Around Wed 19 Mar 2014 14:03:22 +0100 or thereabout, Alexandre Belloni wrote:
> > Switch to the pwm/pwm-atmel driver instead of misc/atmel_pwm
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> 
> > ---
> >  arch/avr32/mach-at32ap/at32ap700x.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> > index a1f4d1e91b52..db85b5ec3351 100644
> > --- a/arch/avr32/mach-at32ap/at32ap700x.c
> > +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> > @@ -1553,7 +1553,7 @@ static struct resource atmel_pwm0_resource[] __initdata = {
> >  	IRQ(24),
> >  };
> >  static struct clk atmel_pwm0_mck = {
> > -	.name		= "pwm_clk",
> > +	.name		= "at91sam9rl-pwm",
> 
> I found this a tiny bit weird, but found the matching instance in
> drivers/pwm/pwm-atmel.c
> 
> IMHO it would initially have been better to call it atpwm_v1 or something
> similar, more generic. But I guess that is too late to change at this point.

Generally when you call clk_get(dev, NULL), you'll pass in the consumer
device as "dev". Now the avr32 clock implementation compares that to the
device associated with the clock, which for the case of the PWM pwm0_mck
is the PWM controller (at32_add_device_pwm() for reference). So it seems
to be set up properly (the PWM controller is the consumer).

Also since the consumer ID isn't specified to the clk_get() call, the
name of the clock (what's being changed in the above hunk) shouldn't
matter because it won't match anyway.

Now that I look at it more closely, I wonder how clk_get(dev, NULL) can
even work on avr32, since there's no check for id == NULL and therefore
NULL will be blindly passed into strcmp() and then crash.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/9c14c4d0/attachment.sig>
