From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 15 Apr 2010 09:44:16 +0530
Subject: Query on direction_output fn of PL061 GPIO driver.
In-Reply-To: <20100414052900.GC2212@tarshish>
References: <4BC44C7E.20306@st.com> <20100413113237.GA2212@tarshish>
	<4BC45839.1080902@st.com> <20100413115321.GB2212@tarshish>
	<20100413185746.GA6289@n2100.arm.linux.org.uk>
	<20100414052900.GC2212@tarshish>
Message-ID: <4BC69298.8030407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/14/2010 10:59 AM, Baruch Siach wrote:
>> > GPIO: Fix PL061 GPIO direction_output to set output level
>> > 
>> > PL061 hardware does not allow setting the output level prior to
>> > changing the direction to output; we have to set the level after
>> > changing the direction.
>> > 
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > 
>> > diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
>> > index aa8e7cb..cac9c0c 100644
>> > --- a/drivers/gpio/pl061.c
>> > +++ b/drivers/gpio/pl061.c
>> > @@ -90,6 +90,7 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
>> >  	gpiodir = readb(chip->base + GPIODIR);
>> >  	gpiodir |= 1 << offset;
>> >  	writeb(gpiodir, chip->base + GPIODIR);
>> > +	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
> IMO we should add a comment here explaining this strange duplicated writeb() 
> call. A copy of the commit log above should be enough, I guess.

I feel duplicating writeb() for setting GPIO value is not required. The
first writeb() called before setting direction, doesn't have any affect.
(As we can't write to data register when GPIO is in IN mode). So we may need
only one writeb() for changing value.

Is my understanding correct??

viresh.
