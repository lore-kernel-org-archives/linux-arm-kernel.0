From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 26 Feb 2015 10:31:28 +0100
Subject: [PATCH 4/8] pwm: atmel-hlcdc: fix struct clk pointer comparing
In-Reply-To: <54EEE5EA.6000902@atmel.com>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-5-git-send-email-shawn.guo@linaro.org>
 <54EEE5EA.6000902@atmel.com>
Message-ID: <20150226103128.0b120742@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas, Shawn,

On Thu, 26 Feb 2015 10:22:50 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Le 25/02/2015 15:53, Shawn Guo a ?crit :
> > Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> > instances"), clk API users can no longer check if two struct clk
> > pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> > simply comparing two pointers.  That's because with the per-user clk
> > change, a brand new struct clk is created whenever clients try to look
> > up the clock by calling clk_get() or sister functions like clk_get_sys()
> > and of_clk_get().  This changes the original behavior where the struct
> > clk is only created for once when clock driver registers the clock to
> > CCF in the first place.  The net change here is before commit
> > 035a61c314eb the struct clk pointer is unique for given hardware
> > clock, while after the commit the pointers returned by clk lookup calls
> > become different for the same hardware clock.
> > 
> > That said, the struct clk pointer comparing in the code doesn't work any
> > more.  Call helper function clk_is_match() instead to fix the problem.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I agree with the fix whichever name is chosen for the function in an
> future version of this series. So you can add my:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Maybe Boris can double check...

Looks good to me.
Thanks for fixing that.

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> 
> > ---
> >  drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> > index 522f7075bb1a..36475949b829 100644
> > --- a/drivers/pwm/pwm-atmel-hlcdc.c
> > +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> > @@ -97,7 +97,7 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
> >  
> >  	pwmcfg = ATMEL_HLCDC_PWMPS(pres);
> >  
> > -	if (new_clk != chip->cur_clk) {
> > +	if (!clk_is_match(new_clk, chip->cur_clk)) {
> >  		u32 gencfg = 0;
> >  		int ret;
> >  
> > 
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
