From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Fri, 16 Nov 2012 06:13:37 +0000
Subject: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-3-git-send-email-anilkumar@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC04226@DBDE01.ent.ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA6D1A1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 15:17:48, AnilKumar, Chimata wrote:
> On Tue, Nov 06, 2012 at 11:15:34, Bedia, Vaibhav wrote:
> > On Mon, Nov 05, 2012 at 15:12:27, AnilKumar, Chimata wrote:
> > [...]
> > >  
> > > +#define SHUTDOWN_TIME_SEC		2
> > > +#define SECS_IN_MIN			60
> > > +#define WAIT_AFTER			(SECS_IN_MIN - SHUTDOWN_TIME_SEC)
> > > +#define WAIT_TIME_MS			(SHUTDOWN_TIME_SEC * 1000)
> > > +
> > >  static void __iomem	*rtc_base;
> > >  
> > [...]
> > > +
> > > +	/* Wait few seconds instead of rollover */
> > > +	do {
> > > +		omap_rtc_read_time(NULL, &tm);
> > > +		if (WAIT_AFTER <= tm.tm_sec)
> > > +			mdelay(WAIT_TIME_MS);
> > > +	} while (WAIT_AFTER <= tm.tm_sec);
> > 
> > This hardcoded wait for rollover doesn't look good. I see some
> > helper functions in rtc-lib.c which probably could be used for
> > converting the current time to elapsed seconds, add the delay and
> > then convert it back to the time to be programmed in RTC without
> > worrying about rollover. Why not use that?
> 
> I am not aware of those APIs, can you point some?

I have gone through rtc-lib.c, these are the API's I am seeing
in the library

1. rtc_time_to_tm: Convert seconds since 01-01-1970 00:00:00 to
Gregorian date
2. rtc_tm_to_time: Convert Gregorian date to seconds since
01-01-1970 00:00:00

Steps I followed:-
================
1: unsigned long time;
2: omap_rtc_read_time(NULL, &tm);
3: rtc_tm_to_time(tm, &time);
4: pr_info("Time 1 %lu\n", time);
5: time += 2; /* (2sec) */
6: rtc_time_to_tm(time, tm);
7: rtc_tm_to_time(tm, &time); /* Only for printing time value */
8: pr_info("Time 2 %lu\n", time); 

With the above steps I am seeing completely two different time
values at step4 and step8

Thanks
AnilKumar
