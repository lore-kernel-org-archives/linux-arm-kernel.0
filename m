From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 9 Jul 2018 13:21:03 -0600
Subject: [PATCH v2 0/7] perf: Add ioctl for PMU driver configuration
In-Reply-To: <20180706183844.9de52f1d45e1775b51790e8e@arm.com>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
 <20180706183844.9de52f1d45e1775b51790e8e@arm.com>
Message-ID: <CANLsYkxJHhZE8VpS_S7ep2KnTNY725DPLKbZFfC_ZDdzaVkoZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jul 2018 at 17:38, Kim Phillips <kim.phillips@arm.com> wrote:
>
> On Thu,  5 Jul 2018 16:13:40 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> > This set adds the capability to communiate event specific configuration
> > to the PMU kernel driver using an ioctl().  The functionatlity is made
> > generic enough for anyone to use but is targeted at the identification
> > of CoreSight sinks when operating in CPU-wide trace scenarios.
>
> With this series, a --per-thread -less invocation looks like it
> succeeds (instead of giving a "failed to mmap with 12 (Cannot allocate
> memory)" error):
>
> # perf record -e /cs_etm/@20010000.etf/ sleep 1
> [ perf record: Woken up 3 times to write data ]
> Warning:
> AUX data lost 2 times out of 3!
>
> [ perf record: Captured and wrote 0.182 MB perf.data ]
> #
>
> but now perf report - built with libopencsd - is unable to process the
> perf.data file:
>
> # perf report --stdio
> 0x3a0 [0x60]: failed to process type: 1
> Error:
> failed to process sample
> # To display the perf.data header info, please use --header/--header-only options.
> #

Right, that's expected since the perf tools patches for CPU-wide trace
scenarios haven't been merged yet.  The real problem is, as you
pointed above, that this patchset should still report an error as full
functionality isn't merged yet.  I will fix that.

>
> Also, a "record -a" invocation also acts like it's working, but Juno
> has a hardware limitation where it can't record all cpus concurrently,
> right?  So, shouldn't record commands that exceed the h/w's
> capabilities error out instead?

To be clear there is no hardware limitation preventing "record -a" to
work properly, just SW.  This patchset is the first step in addressing
the situation.

Thanks,
Mathieu

>
> Thanks,
>
> Kim
