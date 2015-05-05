From: joe@perches.com (Joe Perches)
Date: Tue, 05 May 2015 13:44:21 -0700
Subject: [rtc-linux] [PATCH v3 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <20150505200010.GP4276@piout.net>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
 <20150505200010.GP4276@piout.net>
Message-ID: <1430858661.9365.20.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-05 at 22:00 +0200, Alexandre Belloni wrote:
> Hi,
> 
> This looks mostly good. Could you align the wrapped function parameters
> to the open parenthesis (use checkpatch --strict)?
> 
> On 28/04/2015 at 15:35:55 +0800, Eddie Huang wrote :
> > +static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> > +{
> > +	unsigned long timeout = jiffies + HZ;
> > +	int ret;
> > +	u32 data;
> > +
> > +	ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	do {
> > +		cpu_relax();
> > +		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
> > +				&data);
> > +		if (ret < 0)
> > +			goto exit;
> > +	} while ((data & RTC_BBPU_CBUSY) && time_after(timeout, jiffies));
> > +
> 
> Shouldn't you return -ETIMEDOUT if the loop breaks because of time_after?

Probably yes.

I believe as written the time_after test is too much
for my little brain.  I would have used time_before
and reversed the args.

I suggest moving the time_after() test into the loop,
use break; and remove the exit label too.

Maybe something like:

	while (1) {
		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
				  &data);
		if (ret < 0)
			break;
		if (!(data & RTC_BBPU_CBUSY))
			break;
		if (time_after(jiffies, timeout)) {
			ret = -ETIMEDOUT;
			break;
		}
		cpu_relax();
	}

	return ret;
}
