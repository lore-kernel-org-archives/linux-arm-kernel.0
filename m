From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 21 Apr 2010 13:42:06 +0530
Subject: [PATCH] PL061 GPIO: Changing *_irq_chip_data with *_irq_data
	for real irqs.
In-Reply-To: <20100421080242.GB6345@jasper.tkos.co.il>
References: <1271833201-4482-1-git-send-email-viresh.kumar@st.com>
	<20100421073728.GA6345@jasper.tkos.co.il> <4BCEACF3.3060101@st.com>
	<20100421080242.GB6345@jasper.tkos.co.il>
Message-ID: <4BCEB356.1010708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2010 1:32 PM, Baruch Siach wrote:
>>>> > >> diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
>>>> > >> index 3ad1eeb..0a30124 100644
>>>> > >> --- a/drivers/gpio/pl061.c
>>>> > >> +++ b/drivers/gpio/pl061.c
>>>> > >> @@ -86,10 +86,10 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
>>>> > >>  		return -EINVAL;
>>>> > >>  
>>>> > >>  	spin_lock_irqsave(&chip->lock, flags);
>>>> > >> -	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
>>> > > 
>>> > > I'm still for keeping this line.
>> > 
>> > I will do that, but i am still not sure why should we keep it.
>> > Changing value before changing direction will have no effect.
>> > And if in future releases of pl061 IP, this bug is resolved then also the
>> > changing value after direction will be fine.
> Wrong. Changing the value after direction may cause the GPIO line to output 
> the wrong value for a short period of time (between the first writeb() and the 
> second). Preventing this is the whole point of having the value parameter in 
> the .direction_output method, instead of calling gpio_direction_output() and 
> then gpio_set_value().

Thanks for clarifying.

regards,
viresh.
