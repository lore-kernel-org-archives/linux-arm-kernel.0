From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 31 Mar 2015 20:37:32 -0700
Subject: Build regression in next-20150331
In-Reply-To: <2720045.6sPXjyyvfF@vostro.rjw.lan>
References: <CANMBJr68RVNgVpkDohyOeH=wd=UgKBCFeuveqiUyNcQ_7vendQ@mail.gmail.com>
 <1489627.zlEOcOu4fx@vostro.rjw.lan>
 <2720045.6sPXjyyvfF@vostro.rjw.lan>
Message-ID: <CANMBJr76ap0qL+yxrwe5ECWRgFRgbtdKNBGoSd8SOzrhzDjTrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 31 March 2015 at 16:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, April 01, 2015 01:03:52 AM Rafael J. Wysocki wrote:
>> On Tuesday, March 31, 2015 11:39:37 AM Tyler Baker wrote:
>> > Hi Thomas, Rafael,
>> >
>> > I was notified this morning by the kernelci.org system that a new
>> > build error has been detected in next-20150331[0][1][2]. It seems that
>> > "clockevents: Remove CONFIG_GENERIC_CLOCKEVENTS_BUILD"
>> > c9439b1d6eb4ada5c2faf3970ac0d2bc4bd20e14 is the culprit.
>> >
>> > Initially, I reported these failures to John Stultz and his response is below.
>> >
>> > *snip*
>> >
>> > I suspect we either need to enable GENERIC_CLOCKEVENTS on those three
>> > hardware types, or if that's not possible, rework the definitions.
>> >
>> > Or something like (copy-paste whitespace corruption below.. only for
>> > reference, don't apply):
>> >
>> > diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
>> > index 2a1563a..6da40c0 100644
>> > --- a/kernel/time/tick-internal.h
>> > +++ b/kernel/time/tick-internal.h
>> > @@ -107,12 +107,13 @@ static inline void tick_resume_broadcast(void) { }
>> >  static inline bool tick_resume_check_broadcast(void) { return false; }
>> >  static inline void tick_broadcast_init(void) { }
>> >  static inline int tick_broadcast_update_freq(struct
>> > clock_event_device *dev, u32 freq) { return -ENODEV; }
>> > -
>> > +#ifdef CONFIG_GENERIC_CLOCKEVENTS
>> >  /* Set the periodic handler in non broadcast mode */
>> >  static inline void tick_set_periodic_handler(struct
>> > clock_event_device *dev, int broadcast)
>> >  {
>> >         dev->event_handler = tick_handle_periodic;
>> >  }
>> > +#endif
>> >  #endif /* !BROADCAST */
>> >
>> > *snip*
>> >
>> > Any chance either of you can reproduce this issue on your end?
>>
>> Can you please tell me if the appended patch helps?
>
> Scratch that, wrong patch.
>
> Please try the one below instead.
>
> Rafael
>
>
> ---
>  kernel/time/tick-internal.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> Index: linux-pm/kernel/time/tick-internal.h
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-internal.h
> +++ linux-pm/kernel/time/tick-internal.h
> @@ -110,7 +110,9 @@ static inline int tick_broadcast_update_
>  /* Set the periodic handler in non broadcast mode */
>  static inline void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast)
>  {
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
>         dev->event_handler = tick_handle_periodic;
> +#endif
>  }
>  #endif /* !BROADCAST */

Thanks for the quick response. I've applied this patch on top of
next-20150331 and I can confirm this fixes the build error reported in
this thread. The test results can be found here[0].

>
>

Cheers,

Tyler

[0] http://kernelci.org/build/tbaker/kernel/v4.0-rc6-7993-gb448f49+gcc-linaro-4.9-2015.02/
