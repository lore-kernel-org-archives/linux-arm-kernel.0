From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 20 Jul 2016 14:16:05 -0600
Subject: [PATCH V3 0/3] perf tools: coresight PMU recording capabilities 
Message-ID: <1469045768-17549-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third revision of this set and has been rebased to [1].

It is aimed at supporting trace acquisition and decoding using the ARM
CoreSight drivers. The library is now out and accessible by anyone[2],
branch "opencsd-0v002" is stable and the one we advise to use.

Part of that branch is a "HOWTO.md" that describes how to perform on-target
trace acquisition, along with how to setup the library and perf tools for
off system trace decoding.

Here are a couple of pastebins demonstrating the solution: 

$ perf report --stdio -D [3]
$ perf report --stdio [4]

And a snippet of the output from the "cs-etm-disasem.py" script that
will be upstreamed in an upcoming patchset. 

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

[1]. git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
[2]. https://github.com/Linaro/OpenCSD/
[3]. http://pastebin.com/u9tgdwjF
[4]. http://pastebin.com/V9N3bnEq

Changes for V3:
- Rebased to [1]. 

Changes for V2:
- Rebased on perf tree tip.
- Fixed file list in MAINTAINERS's file.
- Added Adrian Hunter's Acked-by.
- Reworked ifndef/endif in config/Makefile to avoid duplication.
- Patch 1/3, mandatory to make things compile.

Mathieu Poirier (3):
  tools: Copy the header file needed by perf tools
  perf tools: making coresight PMU listable
  perf tools: adding coresight etm PMU record capabilities

 MAINTAINERS                         |   5 +
 tools/perf/MANIFEST                 |   1 +
 tools/perf/Makefile.perf            |   3 +
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
 13 files changed, 768 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/auxtrace.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.h
 create mode 100644 tools/perf/arch/arm/util/pmu.c
 create mode 100644 tools/perf/util/cs-etm.h

-- 
2.7.4
