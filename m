From: v1ron@mail.ru (Roman Volkov)
Date: Tue, 5 Jan 2016 12:42:42 +0300
Subject: [PATCH v3 1/3] clocksource/vt8500: Increase the minimum delta
In-Reply-To: <568B8653.2010301@linaro.org>
References: <1451654683-2401-1-git-send-email-v1ron@mail.ru>
 <1451654683-2401-2-git-send-email-v1ron@mail.ru>
 <568B8653.2010301@linaro.org>
Message-ID: <20160105124242.17bbe09d@v1ron-s7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? Tue, 5 Jan 2016 10:01:07 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> ?????:

> On 01/01/2016 02:24 PM, Roman Volkov wrote:
> > From: Roman Volkov <rvolkov@v1ros.org>
> >
> > The vt8500 clocksource driver declares itself as capable to handle
> > the minimum delay of 4 cycles by passing the value into
> > clockevents_config_and_register(). The vt8500_timer_set_next_event()
> > requires the passed cycles value to be at least 16. The impact is
> > that userspace hangs in nanosleep() calls with small delay
> > intervals.
> >
> > This problem is reproducible in Linux 4.2 starting from:
> > c6eb3f70d448 ('hrtimer: Get rid of hrtimer softirq')
> >
> > Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
> > Acked-by: Alexey Charkov <alchark@gmail.com>  
> 
> Hi Roman,
> 
> I looked at the email thread, and IIUC if set_next_event fails, the 
> system freeze. Your patch fixes the issue for your driver but not the 
> real issue because if set_next_event fails, at least a warning should 
> appear in the log or better nanosleep should fail gracefully.

Hi Daniel,

I agree, but if nanosleep will return immediately, this can lead to
undefined behavior in the software. Maybe the system can go busyloop
to somehow recover from this state and print a message to the log? At
the driver level it seems to be enough to fail the function without
printing logs.
 
> BTW why min delta is MIN_OSCR_DELTA * 2 in
> clockevents_config_and_register ?

All this just to be consistent with PXA. Maybe PXA works with lesser
values, e.g., 8. For vt8500, accessing the registers is more complex,
and this should consume more time. IIUC, if the driver does not support
too small delays, the system will handle it with busyloop?

Why multiply by two? Good question. Maybe there is a reserve for
stability. The value passed by the system to the set_next_event() should
be not lesser than this value, and theoretically, we should not
multiply MIN_OSCR_DELTA by two. As I can see, in many drivers there is
no such minimal values at all.

Added Robert

Regards,
Roman
