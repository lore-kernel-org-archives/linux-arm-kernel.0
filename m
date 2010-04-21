From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 21 Apr 2010 11:02:44 +0300
Subject: [PATCH] PL061 GPIO: Changing *_irq_chip_data with *_irq_data
	for real irqs.
In-Reply-To: <4BCEACF3.3060101@st.com>
References: <1271833201-4482-1-git-send-email-viresh.kumar@st.com>
	<20100421073728.GA6345@jasper.tkos.co.il> <4BCEACF3.3060101@st.com>
Message-ID: <20100421080242.GB6345@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Wed, Apr 21, 2010 at 01:14:51PM +0530, Viresh KUMAR wrote:
> On 4/21/2010 1:07 PM, Baruch Siach wrote:
> > Hi Viresh,
> > 
> > On Wed, Apr 21, 2010 at 12:30:01PM +0530, Viresh KUMAR wrote:
> >> PL061 driver is using set_irq_chip_data and get_irq_chip_data for real irq
> >> lines. It must be using *_irq_data functions instead. As chip_data is used by
> >> interrupt controllers also, which makes vic write at incorrect addresses.
> >>
> >> Also, pl061_direction_output doesn't set value of gpio to value passed to 
> >> it.  Adding code to set value of GPIO pin to requrested value.
> > 
> > Please split this patch into two separate patches. The two fixes are unrelated 
> > to each other.
> 
> OK.
> 
> > 
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> >> ---
> >>  drivers/gpio/pl061.c |    8 ++++----
> >>  1 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
> >> index 3ad1eeb..0a30124 100644
> >> --- a/drivers/gpio/pl061.c
> >> +++ b/drivers/gpio/pl061.c
> >> @@ -86,10 +86,10 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
> >>  		return -EINVAL;
> >>  
> >>  	spin_lock_irqsave(&chip->lock, flags);
> >> -	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
> > 
> > I'm still for keeping this line.
> 
> I will do that, but i am still not sure why should we keep it.
> Changing value before changing direction will have no effect.
> And if in future releases of pl061 IP, this bug is resolved then also the
> changing value after direction will be fine.

Wrong. Changing the value after direction may cause the GPIO line to output 
the wrong value for a short period of time (between the first writeb() and the 
second). Preventing this is the whole point of having the value parameter in 
the .direction_output method, instead of calling gpio_direction_output() and 
then gpio_set_value().

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
