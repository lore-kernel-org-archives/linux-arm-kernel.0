From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 31 May 2016 11:10:31 -0600
Subject: [PATCH 0/2] perf tools: coresight PMU recording capabilities 
Message-ID: <1464714633-16697-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good day Arnaldo,

If you recal we had a discussion about the code submitted in this set back in
February[1].  At the time we agreed it would be better to wait until the 
decoding library is available, allowing people to test the solution.  

That library is now out and accessible by anyone[2] - branch "opencsd-0v002"
is stable and the one we advise to use.  Part of that branch is a "HOWTO.md"
that describes how to perform on-target trace acquisition, along with how to
setup the library and perf tools for off system trace decoding. 

The patches in this set can also be found on gitHub[2], branch
"perf-opencsd-4.7-rc1".  Available there are many more patches that will be
submitted for review incrementally.

Everything works on mainline v4.7-rc1.  I will be happy to change the baseline
should this prove to be easier for your to review.  Note that 2/2 has already
been acked by Adrian Hunter but submitted here without the usual mention since
the code has change a little.

To conclude, here are a couple of pastebins for you to look at if you don't want
to go through the whole process of setting up the solution:

$ perf report --stdio -D [3]
$ perf report --stdio [4] 

And a snippet of the output from the "cs-etm-disasem.py" script, also included
on branch "perf-opencsd-4.7-rc1":

FILE: /lib/aarch64-linux-gnu/ld-2.21.so CPU: 3
          7fab57fd80:   910003e0        mov     x0, sp
          7fab57fd84:   94000d53        bl      7fab5832d0 <free@plt+0x3790>
FILE: /lib/aarch64-linux-gnu/ld-2.21.so CPU: 3
          7fab5832d0:   d11203ff        sub     sp, sp, #0x480
FILE: /lib/aarch64-linux-gnu/ld-2.21.so CPU: 3
          7fab5832d4:   a9ba7bfd        stp     x29, x30, [sp,#-96]!
          7fab5832d8:   910003fd        mov     x29, sp
          7fab5832dc:   a90363f7        stp     x23, x24, [sp,#48]
          7fab5832e0:   9101e3b7        add     x23, x29, #0x78
          7fab5832e4:   a90573fb        stp     x27, x28, [sp,#80]
          7fab5832e8:   a90153f3        stp     x19, x20, [sp,#16]
          7fab5832ec:   aa0003fb        mov     x27, x0
          7fab5832f0:   910a82e1        add     x1, x23, #0x2a0
          7fab5832f4:   a9025bf5        stp     x21, x22, [sp,#32]
          7fab5832f8:   a9046bf9        stp     x25, x26, [sp,#64]
          7fab5832fc:   910102e0        add     x0, x23, #0x40
          7fab583300:   f800841f        str     xzr, [x0],#8
          7fab583304:   eb01001f        cmp     x0, x1
          7fab583308:   54ffffc1        b.ne    7fab583300 <free@plt+0x37c0>
FILE: /lib/aarch64-linux-gnu/ld-2.21.so CPU: 3
          7fab583300:   f800841f        str     xzr, [x0],#8
          7fab583304:   eb01001f        cmp     x0, x1
          7fab583308:   54ffffc1        b.ne    7fab583300 <free@plt+0x37c0>
FILE: /lib/aarch64-linux-gnu/ld-2.21.so CPU: 3
          7fab583300:   f800841f        str     xzr, [x0],#8
          7fab583304:   eb01001f        cmp     x0, x1
          7fab583308:   54ffffc1        b.ne    7fab583300 <free@plt+0x37c0>
...
...

Regards,
Mathieu

[1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/404232.html
[2]. https://github.com/Linaro/OpenCSD/ 
[3]. http://pastebin.com/u9tgdwjF
[4]. http://pastebin.com/V9N3bnEq

Mathieu Poirier (2):
  perf tools: making coresight PMU listable
  perf tools: adding coresight etm PMU record capabilities

 MAINTAINERS                         |   4 +
 tools/perf/MANIFEST                 |   1 +
 tools/perf/arch/arm/util/Build      |   2 +
 tools/perf/arch/arm/util/auxtrace.c |  54 ++++
 tools/perf/arch/arm/util/cs-etm.c   | 559 ++++++++++++++++++++++++++++++++++++
 tools/perf/arch/arm/util/cs-etm.h   |  23 ++
 tools/perf/arch/arm/util/pmu.c      |  34 +++
 tools/perf/arch/arm64/util/Build    |   4 +
 tools/perf/config/Makefile          |  11 +-
 tools/perf/util/auxtrace.c          |   1 +
 tools/perf/util/auxtrace.h          |   1 +
 tools/perf/util/cs-etm.h            |  74 +++++
 12 files changed, 765 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/auxtrace.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.h
 create mode 100644 tools/perf/arch/arm/util/pmu.c
 create mode 100644 tools/perf/util/cs-etm.h

-- 
2.5.0
