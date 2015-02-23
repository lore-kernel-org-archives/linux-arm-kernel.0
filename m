From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 23 Feb 2015 11:03:26 +0530
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <20150220140432.GA31928@gmail.com>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
 <20150220093659.GA23469@gmail.com>
 <20150220113753.GP5029@twins.programming.kicks-ass.net>
 <20150220114136.GA27483@gmail.com>
 <CAKohpokmCof2P8Un+i5eOS3BQhH_pMNATH4xkbbhw5TqJFEy9Q@mail.gmail.com>
 <20150220132220.GB28882@gmail.com>
 <CAKohpokEV7EatQROgzQBWPRPFEn8OsMo5EHa+q1FMwBESwiU3w@mail.gmail.com>
 <20150220140432.GA31928@gmail.com>
Message-ID: <CAKohponv=aR7Ae_z7zbnDDeJ-mCFwdxB3wR-O4boBeMKYdUJLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2015 at 19:34, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> Unused. Initially all clockevent devices are supposed to
>> be in this mode but later if another device replaces an
>> existing one, the existing one is put into this mode.
>
> I'd suggest to rename it to MODE_INIT - at first glance it
> gave me the impression that it's some sort of API
> placeholder - i.e. an unused flag or so.

Sorry, if I wasn't able to clarify this earlier. The impression you got
at first glance is correct. And it should be UNUSED only instead of
INIT. Its not about if the the device is initialized or not, but if it is used
or not. And that's why there is no callback for this in the new per-mode
callbacks.

> Also, I'd suggest to rename all 'modes' to true state
> machine naming: STATE_INITIALIZED, STATE_SHUT_DOWN,
> STATE_PERIODIC, STATE_RESUMED, etc.: if these are enums for

I thought so initially and it looked like the diff will be huge as all the
variables for the enum, i.e. 'mode', need to be renamed to 'state'..

But, if you are okay with it then I would be happy to do that..

> states and not state transition names, see my later
> questions:
>
>> >> +       CLOCK_EVT_DEV_MODE_SHUTDOWN,
>> >> +       CLOCK_EVT_DEV_MODE_PERIODIC,
>> >> +       CLOCK_EVT_DEV_MODE_ONESHOT,
>> >> +       CLOCK_EVT_DEV_MODE_RESUME,
>> >
>> > What is 'resume' mode?
>>
>> Introduced with: 18de5bc4c1f1 ("clockevents: fix resume
>> logic") and is only called during system resume to resume
>> the clockevent devices before resuming the tick. Only few
>> implementations do meaningful stuff here.
>
> So is it a state that a clockevents device reaches, or a
> state transition? The two purposes seem to be mixed up in
> the nomenclature.

Where all other modes are states, 'resume' probably represents
transition. It is immediately followed by a transition to ONESHOT or
PERIODIC mode and so it is just a preliminary step before moving to
final states during resume. We *may* not need to keep this in the
states enum..

>> Its only important for NOHZ_FULL (IDLE ? Maybe). When we
>> decide that the tick (LOWRES) or hrtimer interrupt
>> (HIGHRES) isn't required for indefinite period of time
>> (i.e. no timers/hrtimers are present to serve), we skip
>> reprogramming the clockevent device. But its already
>> reprogrammed from the tick-handler and so will fire
>> atleast once again.
>
> So this new 'mode' appears to be a true state of the
> device?

Yes.
