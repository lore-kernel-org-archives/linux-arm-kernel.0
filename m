From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 16 Mar 2015 17:52:09 +0800
Subject: [rtc-linux] [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <20150313105742.GS24885@pengutronix.de>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
 <20150223135044.108ea32a65063a50aa36a309@linux-foundation.org>
 <1426242563.18291.19.camel@mtksdaap41>
 <20150313105742.GS24885@pengutronix.de>
Message-ID: <1426499529.15259.58.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, 2015-03-13 at 11:57 +0100, Sascha Hauer wrote:
> Hi Eddie,
> 
> On Fri, Mar 13, 2015 at 06:29:23PM +0800, Eddie Huang wrote:
> > > regmap_read() and regmap_write() can return errors.  There is no
> > > checking for this.
> > > 
> > 
> > I encounter some trouble when I add code to check return value of
> > regmap_read and regmap_write. Every RTC register access through regmap,
> > and there are many register read/write in this driver. If I check every
> > return value, the driver will become ugly. I try to make this driver
> > clean using following macro.
> > 
> > static int __rtc_read(struct mt6397_rtc *rtc, u32 offset, u32 *data)
> > {
> >         u32 addr = rtc->addr_base + offset;
> > 
> >         if (offset < rtc->addr_range)
> >                 return regmap_read(rtc->regmap, addr, data);
> > 
> >         return -EINVAL;
> > }
> > 
> > #define rtc_read(ret, rtc, offset, data)                \
> > ({                                                      \
> >         ret = __rtc_read(rtc, offset, data);            \
> >         if (ret < 0)                                    \
> >                 goto rtc_exit;                          \
> > })                                                      \
> 
> Hiding a goto (or return) in a macro is a very bad idea.
> 
> what you can do is
> 
> 	ret |= regmap_read(rtc->regmap, RTC_TC_SEC, &tm->tm_sec);
> 	ret |= regmap_read(rtc->regmap, RTC_TC_MIN, &tm->tm_min);
> 
> 	if (ret)
> 		return -EIO;
> 
> (Don't return ret in this case though as it might contain different
> error codes orred together)
> 

OK, I will drop macro, and check regmap_read, regmap_write return value
in each function.

> Another possibilty at least for contiguous registers would be
> regmap_bulk_read().
> 
> Sascha
> 

Contiguous registers access occurs in reading and writing time. I think
Matthias's suggestion is a good way: 

do {
	ret = __mtk_rtc_read_time(rtc, &tm, &sec);
	if (ret < 0)
		goto rtc_exit;
} while (sec < tm->tm_sec);

Eddie
