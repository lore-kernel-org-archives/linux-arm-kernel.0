From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 23 Aug 2017 03:18:22 +0200
Subject: [RFC 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <3307d3ed-c8e0-a7b5-f0ee-d401f4b12a90@suse.de>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-3-afaerber@suse.de>
 <20170820083219.siez3rl2hbjgjgk5@piout.net>
 <3307d3ed-c8e0-a7b5-f0ee-d401f4b12a90@suse.de>
Message-ID: <20170823011822.adda7emuz3eig3yt@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/2017 at 23:10:16 +0200, Andreas F?rber wrote:
> > Is RTD_RTCDATE_HIGH latched when RTD_RTCDATE_LOW is read?
> 
> I do not have an answer to that.
> 
> > If this is not
> > the case, you probably want to handle a possible update between both
> > readl_relaxed.
> 
> Are you proposing to disable the RTC while reading the registers, or
> something related to my choice of _relaxed? (it follows an explanation
> by Marc Zyngier on the irq mux series) Inconsistencies might not be
> limited to the date.
> 

A simple way to be sure would be to read RTD_RTCSEC first, then the
other registers and check RTD_RTCSEC didn't change. This will ensure the
other registers have not be updated in the meantime (unless it takes
one minute but I doubt this is the case). if RTD_RTCSEC changed, then
you can start over.

> >> +	t = mktime64(data->base_year, 1, 1, 0, 0, 0);
> >> +	t += day * 24 * 60 * 60;
> >> +	rtc_time64_to_tm(t, tm);
> 
> BTW is there any more efficient way to get from year+days to
> day/month/year without going via seconds?
> 

Completely untested:

for (y = data->base_year; (day - (365 + is_leap_year(y))) > 0; y++)
	day -= (365 + is_leap_year(y));

for (m = 0; (day - rtc_month_days(m, y)) > 0; m++)
	day -= rtc_month_days(m, y);


> >> +
> >> +	rtd119x_rtc_set_enabled(dev, true);
> >> +
> > 
> > This is certainly not what you want. The RTC device is usually not
> > opened so enabling the RTC when open and disabling it when closed will
> > not work on most systems. This is probably true for the clock too. i.e
> > what you do here should be done in probe.
> 
> I did test the probe path to work, but I can change it again. The
> downstream code had it in probe, but looking at rtc_class_ops I saw
> those hooks and thought they'd serve a purpose - what are they for then?
> (Any chance you can improve the documentation comments to avoid such
> misunderstandings? :))
> 

They are (were) used only when the rtc character device (/dev/rtcx) is
opened/released but the cdev interface is one of many interfaces to the
RTC sod it doesn't make sense to do something only in that case
(especially requesting IRQs).

To solve your concern, this is what I'm going to apply after fixing the
two remaining uses of .release:

http://patchwork.ozlabs.org/patch/804707/


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
