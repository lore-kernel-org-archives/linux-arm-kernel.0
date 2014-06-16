From: dianders@chromium.org (Doug Anderson)
Date: Mon, 16 Jun 2014 09:35:04 -0700
Subject: [PATCH 1/3] clocksource: exynos_mct: Fix ftrace
In-Reply-To: <539EB03C.5080100@linaro.org>
References: <1401903034-20074-1-git-send-email-dianders@chromium.org>
 <539E0D8E.9080706@linaro.org>
 <CAD=FV=XA09XawT-fxAm2tTMw4kZ=7RHceXuww2y6q+zMV71pew@mail.gmail.com>
 <539EB03C.5080100@linaro.org>
Message-ID: <CAD=FV=Vmcg_VwPO09OSFCxmqktNg2czc_qtYpaCh1ex5O1nUdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Mon, Jun 16, 2014 at 1:52 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Hi Dough,
>
> thanks for the explanation. I still don't get why it is important to keep
> others users of mct traceable because it is quite slow ? May be it is what
> you explained here, but I miss the connection between 'the other users' <->
> 'traceable' <-> 'because slow'.

It stems from the fact that one use of trace is to figure out why
things are slow.  In that case you want to make sure that the slow
things are traceable.

I can run the following:

cd /sys/kernel/debug/tracing
echo nop > current_tracer
echo 0 > options/sleep-time
echo 0 > options/graph-time
echo 1 > function_profile_enabled
~/gettimeofday 100000
echo 0 > function_profile_enabled

Then I can see this:

  Function                               Hit    Time            Avg
         s^2
  --------                               ---    ----            ---
         ---
 __getnstimeofday                    100005    258267.8 us     2.582
us        447196.9 us
  do_gettimeofday                     100004    252395.6 us     2.523
us        462549.6 us
  SyS_gettimeofday                    100004    249353.6 us     2.493
us        1223308 us
  getnstimeofday                      100005    246217.2 us     2.462
us        369149.8 us
  exynos4_frc_read                    101096    181620.0 us     1.796
us        157413.8 us

...if I mark exynos4_frc_read() as notrace then it doesn't show up in
the profile, which is unfortunate.

NOTE: the above profile is a bit misleading in terms of actual time
taken my belief is that we end up with some confusing numbers since
profiling uses the MCT itself (I think) to record how long a function
took to execute.  Despite this it's still awfully nice that
exynos4_frc_read() actually shows up in the trace...
