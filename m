From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 15:10:11 +0000
Subject: [PATCH v2 1/7] timekeeping: introduce __current_kernel_time64
In-Reply-To: <4372800.FdTygmcuyo@wuerfel>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <4372800.FdTygmcuyo@wuerfel>
Message-ID: <alpine.DEB.2.02.1511101507540.5676@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Nov 2015, Arnd Bergmann wrote:
> On Tuesday 10 November 2015 11:57:49 Stefano Stabellini wrote:
> > __current_kernel_time64 returns a struct timespec64, without taking the
> > xtime lock. Mirrors __current_kernel_time/current_kernel_time.
> > 
> 
> Actually it doesn't mirror __current_kernel_time/current_kernel_time
> 
> > diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> > index ec89d84..b5802bf 100644
> > --- a/include/linux/timekeeping.h
> > +++ b/include/linux/timekeeping.h
> > @@ -19,7 +19,8 @@ extern int do_sys_settimeofday(const struct timespec *tv,
> >   */
> >  unsigned long get_seconds(void);
> >  struct timespec64 current_kernel_time64(void);
> > -/* does not take xtime_lock */
> > +/* do not take xtime_lock */
> > +struct timespec64 __current_kernel_time64(void);
> >  struct timespec __current_kernel_time(void);
> 
> Please change __current_kernel_time into a static inline function
> while you are introducing the new one, to match the patch description ;-)

The implementation is:

	struct timekeeper *tk = &tk_core.timekeeper;

	return timespec64_to_timespec(tk_xtime(tk));

which cannot be easily made into a static inline, unless we start
exporting tk_core.
