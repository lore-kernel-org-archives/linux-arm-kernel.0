From: ladis@linux-mips.org (Ladislav Michl)
Date: Mon, 22 Jan 2018 10:59:50 +0100
Subject: [PATCH 1/3] clocksource: timer-dm: Check prescaler value
In-Reply-To: <4688ef73-99ac-1295-2e3b-ed79e8670262@microchip.com>
References: <20180117214629.GA11952@lenoch> <20180117214714.GB11952@lenoch>
 <4688ef73-99ac-1295-2e3b-ed79e8670262@microchip.com>
Message-ID: <20180122095950.GA19401@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 11:00:15AM +0200, Claudiu Beznea wrote:
> 
> 
> On 17.01.2018 23:47, Ladislav Michl wrote:
> > Invalid value silently disables use of the prescaler.
> > Use -1 explicitely for that purpose and error out on
> > invalid value.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  drivers/clocksource/timer-dm.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> > index 60db1734ea3b..324ec93d3dd2 100644
> > --- a/drivers/clocksource/timer-dm.c
> > +++ b/drivers/clocksource/timer-dm.c
> > @@ -663,13 +663,13 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
> >  {
> >  	u32 l;
> >  
> > -	if (unlikely(!timer))
> > +	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
> You are checking the prescaller here to be in [0, 7] interval.

You mean [-1, 7] I suppose.

> >  		return -EINVAL;
> >  
> >  	omap_dm_timer_enable(timer);
> >  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> >  	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
> > -	if (prescaler >= 0x00 && prescaler <= 0x07) {
> > +	if (prescaler >= 0) {
> Is this check still necessary?

Yes, as we need also some way to disable prescaler, see commit message.

> >  		l |= OMAP_TIMER_CTRL_PRE;
> >  		l |= prescaler << 2;
> >  	}

Best regards,
	ladis
