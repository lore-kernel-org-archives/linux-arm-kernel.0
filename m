From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 17 Apr 2010 21:20:03 +0300
Subject: Query on direction_output fn of PL061 GPIO driver.
In-Reply-To: <4BC69298.8030407@st.com>
References: <4BC44C7E.20306@st.com> <20100413113237.GA2212@tarshish>
	<4BC45839.1080902@st.com> <20100413115321.GB2212@tarshish>
	<20100413185746.GA6289@n2100.arm.linux.org.uk>
	<20100414052900.GC2212@tarshish> <4BC69298.8030407@st.com>
Message-ID: <20100417182001.GB17637@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Thu, Apr 15, 2010 at 09:44:16AM +0530, Viresh KUMAR wrote:
> On 4/14/2010 10:59 AM, Baruch Siach wrote:
> >> > GPIO: Fix PL061 GPIO direction_output to set output level
> >> > 
> >> > PL061 hardware does not allow setting the output level prior to
> >> > changing the direction to output; we have to set the level after
> >> > changing the direction.
> >> > 
> >> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >> > 
> >> > diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
> >> > index aa8e7cb..cac9c0c 100644
> >> > --- a/drivers/gpio/pl061.c
> >> > +++ b/drivers/gpio/pl061.c
> >> > @@ -90,6 +90,7 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
> >> >  	gpiodir = readb(chip->base + GPIODIR);
> >> >  	gpiodir |= 1 << offset;
> >> >  	writeb(gpiodir, chip->base + GPIODIR);
> >> > +	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
> > IMO we should add a comment here explaining this strange duplicated writeb() 
> > call. A copy of the commit log above should be enough, I guess.
> 
> I feel duplicating writeb() for setting GPIO value is not required. The
> first writeb() called before setting direction, doesn't have any affect.
> (As we can't write to data register when GPIO is in IN mode). So we may need
> only one writeb() for changing value.
> 
> Is my understanding correct??

Given the present situation you are probably right. However, since this 
behaviour is not documented in the PL061 documentation is may get fixed in 
future implementations. To take advantage of this we need the double writeb().

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
