From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 1 Dec 2016 01:51:59 +0100
Subject: [rtc-linux] Re: [RFC PATCH 2/3] rtc: Add Amlogic Virtual Wake RTC
In-Reply-To: <20161103153647.GD25852@remoulade>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <1478183365-23708-3-git-send-email-narmstrong@baylibre.com>
 <20161103153647.GD25852@remoulade>
Message-ID: <20161201005159.l54yo4kspgrb75ev@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2016 at 15:36:48 +0000, Mark Rutland wrote :
> > In order to be able to reuse the RTC wakealarm feature, this
> > driver implements a fake RTC device which uses the system time
> > to deduce a suspend delay.
> 
> This sounds like an always-on oneshot timer device, not an RTC.
> 
> > +static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	unsigned long local_time;
> > +	struct timeval time;
> > +
> > +	do_gettimeofday(&time);
> > +	local_time = time.tv_sec - (sys_tz.tz_minuteswest * 60);
> > +	rtc_time_to_tm(local_time, tm);
> > +
> > +	return 0;
> > +}
> 
> ... if this were a timer, you wouldn't need this hack.
> 

The main issue I think is that the clockevents are not able to wakeup a
platform so it doesn't really fit as a timer inside the kernel.

I think it may be fine to handle that in the RTC subsystem for now.

The same issue can be seen with the flextimer on LS1021A:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/365597.html

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
