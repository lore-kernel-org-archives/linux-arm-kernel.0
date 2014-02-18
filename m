From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Feb 2014 09:15:30 -0500
Subject: [PATCH] rtc: mv: reset date if after year 2038
In-Reply-To: <20140218140429.GE17984@lunn.ch>
References: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218140429.GE17984@lunn.ch>
Message-ID: <20140218141530.GP7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:04:29PM +0100, Andrew Lunn wrote:
> On Tue, Feb 18, 2014 at 02:26:06PM +0100, Thomas Petazzoni wrote:
> > Dates after January, 19th 2038 are badly handled by userspace due to
> > the time being stored on 32 bits. This causes issues on some Marvell
> > platform on which the RTC is initialized by default to a date that's
> > beyond 2038, causing a really weird behavior of the RTC.
> > 
> > In order to avoid that, reset the date to a sane value if the RTC is
> > beyond 2038.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  drivers/rtc/rtc-mv.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> > index d536c59..f124dc6 100644
> > --- a/drivers/rtc/rtc-mv.c
> > +++ b/drivers/rtc/rtc-mv.c
> > @@ -222,6 +222,7 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	struct rtc_plat_data *pdata;
> >  	u32 rtc_time;
> > +	u32 rtc_date;
> >  	int ret = 0;
> >  
> >  	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> > @@ -257,6 +258,17 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * A date after January 19th, 2038 does not fit on 32 bits and
> > +	 * will confuse the kernel and userspace. Reset to a sane date
> > +	 * (January 1st, 2013) if we're after 2038.
> > +	 */
> 
> Hi Thomas
> 
> Would it be better to reset back to 01/01/1970? When we do reach 32
> bit rollover, and assuming the world continues to exist, it has a
> better chance of being right than 01/01/2013.

The real issue here is that you don't want the clock to go *backwards*
when ntpdate/ntpd starts up.  That causes all kinds of badness (for
dhcp and friends).

So, by definition, any date _before_ the correct time is better than
being in the future.  Since the code can't be executed before it's
written, any date between 1/1/1970 and now is acceptable.

Not all ntpd configurations allow a large initial offset (jump to $now)
before disciplining the clock.  So the closer we can be to the user's
$now, the better.  In this case, the date chosen in the patch is a lot
better than 1/1/1970.

thx,

Jason.
