From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 20 Feb 2015 14:22:20 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <CAKohpokmCof2P8Un+i5eOS3BQhH_pMNATH4xkbbhw5TqJFEy9Q@mail.gmail.com>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
 <20150220093659.GA23469@gmail.com>
 <20150220113753.GP5029@twins.programming.kicks-ass.net>
 <20150220114136.GA27483@gmail.com>
 <CAKohpokmCof2P8Un+i5eOS3BQhH_pMNATH4xkbbhw5TqJFEy9Q@mail.gmail.com>
Message-ID: <20150220132220.GB28882@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 20 February 2015 at 17:11, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> >> Maybe we should break that enum into two; one for devices
> >> and one for the core interface and avoid the problem that
> >> way.
> >
> > Yeah, that would do the trick.
> 
> Thanks for your suggestions. Just to confirm (before I spam lists with
> patches), is
> this somewhat similar to what you are looking for ?
> 
> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
> index 59af26b54d15..80b669cb836d 100644
> --- a/include/linux/clockchips.h
> +++ b/include/linux/clockchips.h
> @@ -32,17 +32,24 @@ enum clock_event_nofitiers {
>  struct clock_event_device;
>  struct module;
> 
> -/* Clock event mode commands */
> +/* Clock event mode commands for legacy ->set_mode(): OBSOLETE */
>  enum clock_event_mode {
>         CLOCK_EVT_MODE_UNUSED = 0,
>         CLOCK_EVT_MODE_SHUTDOWN,
>         CLOCK_EVT_MODE_PERIODIC,
>         CLOCK_EVT_MODE_ONESHOT,
>         CLOCK_EVT_MODE_RESUME,
> -
> -       /* Legacy ->set_mode() callback doesn't support below modes */
>  };
> 
> +/* Clock event modes, only for core's internal use */
> +enum clock_event_dev_mode {
> +       CLOCK_EVT_DEV_MODE_UNUSED = 0,

What is 'unused' - not initialized yet?

> +       CLOCK_EVT_DEV_MODE_SHUTDOWN,
> +       CLOCK_EVT_DEV_MODE_PERIODIC,
> +       CLOCK_EVT_DEV_MODE_ONESHOT,
> +       CLOCK_EVT_DEV_MODE_RESUME,

What is 'resume' mode?

> +       CLOCK_EVT_DEV_MODE_ONESHOT_STOPPED,  /* This would be the new
> mode which I will add later */

What does this mode express?

So for state machines it's important to document the states 
and the transitions between them very clearly - please 
start with that.

> +};

Also, this should not be in a generic header, it should be 
somewhere internal in kernel/time/.

> Ofcourse, we also need to replace 'clock_event_mode' with 
> 'clock_event_dev_mode' and 'CLOCK_EVT_MODE_*' with 
> 'CLOCK_EVT_DEV_MODE_*' in all core code..

Yes.

Thanks,

	Ingo
