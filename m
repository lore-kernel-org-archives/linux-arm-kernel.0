From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 13 Mar 2015 18:29:23 +0800
Subject: [rtc-linux] [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <20150223135044.108ea32a65063a50aa36a309@linux-foundation.org>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
 <20150223135044.108ea32a65063a50aa36a309@linux-foundation.org>
Message-ID: <1426242563.18291.19.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2015-02-23 at 13:50 -0800, Andrew Morton wrote:
> On Wed, 28 Jan 2015 17:27:56 +0800 Eddie Huang <eddie.huang@mediatek.com> wrote:
> 
> > From: Tianping Fang <tianping.fang@mediatek.com>
> > 
> > Add Mediatek MT63xx RTC driver
> 
> There are a couple of checkpatch warnings which should be addressed,
> please:
> 
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #150: 
> new file mode 100644
> 
> WARNING: DT compatible string "mediatek,mt6397-rtc" appears un-documented -- check ./Documentation/devicetree/bindings/
> #488: FILE: drivers/rtc/rtc-mt6397.c:334:
> +	{ .compatible = "mediatek,mt6397-rtc", },
> 
> 
> 
> 
> >
> > ...
> >
> > +static u16 rtc_read(struct mt6397_rtc *rtc, u32 offset)
> > +{
> > +	u32 rdata = 0;
> > +	u32 addr = rtc->addr_base + offset;
> > +
> > +	if (offset < rtc->addr_range)
> > +		regmap_read(rtc->regmap, addr, &rdata);
> > +
> > +	return (u16)rdata;
> > +}
> > +
> > +static void rtc_write(struct mt6397_rtc *rtc, u32 offset, u32 data)
> > +{
> > +	u32 addr;
> > +
> > +	addr = rtc->addr_base + offset;
> > +
> > +	if (offset < rtc->addr_range)
> > +		regmap_write(rtc->regmap, addr, data);
> > +}
> 
> regmap_read() and regmap_write() can return errors.  There is no
> checking for this.
> 

I encounter some trouble when I add code to check return value of
regmap_read and regmap_write. Every RTC register access through regmap,
and there are many register read/write in this driver. If I check every
return value, the driver will become ugly. I try to make this driver
clean using following macro.

static int __rtc_read(struct mt6397_rtc *rtc, u32 offset, u32 *data)
{
        u32 addr = rtc->addr_base + offset;

        if (offset < rtc->addr_range)
                return regmap_read(rtc->regmap, addr, data);

        return -EINVAL;
}

#define rtc_read(ret, rtc, offset, data)                \
({                                                      \
        ret = __rtc_read(rtc, offset, data);            \
        if (ret < 0)                                    \
                goto rtc_exit;                          \
})                                                      \


And function call rtc_read, rtc_write looks like:

static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
{
        unsigned long time;
        struct mt6397_rtc *rtc = dev_get_drvdata(dev);
        int ret = 0;
        u32 sec;

        mutex_lock(&rtc->lock);
        do {
                rtc_read(ret, rtc, RTC_TC_SEC, &tm->tm_sec);
                rtc_read(ret, rtc, RTC_TC_MIN, &tm->tm_min);
                rtc_read(ret, rtc, RTC_TC_HOU, &tm->tm_hour);
                rtc_read(ret, rtc, RTC_TC_DOM, &tm->tm_mday);
                rtc_read(ret, rtc, RTC_TC_MTH, &tm->tm_mon);
                rtc_read(ret, rtc, RTC_TC_YEA, &tm->tm_year);
                rtc_read(ret, rtc, RTC_TC_SEC, &sec);
        } while (sec < tm->tm_sec);
        mutex_unlock(&rtc->lock);

        tm->tm_year += RTC_MIN_YEAR_OFFSET;
        tm->tm_mon--;
        rtc_tm_to_time(tm, &time);

        tm->tm_wday = (time / 86400 + 4) % 7;

        return 0;

rtc_exit:
        mutex_unlock(&rtc->lock);
        return ret;
}

It's a little tricky, does anyone have good suggestion ?

Eddie
