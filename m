From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 6 Jul 2018 18:38:44 -0500
Subject: [PATCH v2 0/7] perf: Add ioctl for PMU driver configuration
In-Reply-To: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180706183844.9de52f1d45e1775b51790e8e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  5 Jul 2018 16:13:40 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> This set adds the capability to communiate event specific configuration
> to the PMU kernel driver using an ioctl().  The functionatlity is made
> generic enough for anyone to use but is targeted at the identification
> of CoreSight sinks when operating in CPU-wide trace scenarios.

With this series, a --per-thread -less invocation looks like it
succeeds (instead of giving a "failed to mmap with 12 (Cannot allocate
memory)" error):

# perf record -e /cs_etm/@20010000.etf/ sleep 1
[ perf record: Woken up 3 times to write data ]
Warning:
AUX data lost 2 times out of 3!

[ perf record: Captured and wrote 0.182 MB perf.data ]
# 

but now perf report - built with libopencsd - is unable to process the
perf.data file:

# perf report --stdio 
0x3a0 [0x60]: failed to process type: 1
Error:
failed to process sample
# To display the perf.data header info, please use --header/--header-only options.
#

Also, a "record -a" invocation also acts like it's working, but Juno
has a hardware limitation where it can't record all cpus concurrently,
right?  So, shouldn't record commands that exceed the h/w's
capabilities error out instead?

Thanks,

Kim
