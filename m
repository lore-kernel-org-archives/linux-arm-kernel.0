From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Nov 2018 11:42:29 -0700
Subject: [PATCH 0/3] perf tools: Add support for ETMv3/PTM1.1 decoding 
Message-ID: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set adds support for ETMv3/PTM1.1 trace decoding.  The work has been
tested on TC2 and ST-Microelectronics' mp157c-ev1 board and applies cleanly
on 4.20-rc2 and Acme's perf/core branch [1].

*** Before this set ***

$ perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
Warning:
AUX data lost 2 times out of 2!

Error:
The perf.data file has no samples!

*** After this set ***

[...]

# Samples: 12K of event 'branches'
# Event count (approx.): 12049
#
# Children      Self  Command  Shared Object     Symbol                 
# ........  ........  .......  ................  .......................
#
    28.18%    28.18%  uname    libc-2.19.so      [.] strcmp
     9.13%     9.13%  uname    libc-2.19.so      [.] strcpy
     7.87%     7.87%  uname    libc-2.19.so      [.] strnlen
     5.58%     5.58%  uname    libc-2.19.so      [.] strlen
     2.24%     2.24%  uname    libc-2.19.so      [.] __rawmemchr
     1.91%     1.91%  uname    ld-2.19.so        [.] 0x000000000001156a
     1.49%     1.49%  uname    libc-2.19.so      [.] __argz_stringify
     1.46%     1.46%  uname    libc-2.19.so      [.] malloc
     0.96%     0.96%  uname    libc-2.19.so      [.] 0x0000000000054770
     0.91%     0.91%  uname    libc-2.19.so      [.] 0x000000000002430a
     0.85%     0.85%  uname    ld-2.19.so        [.] 0x0000000000007244
     0.83%     0.83%  uname    libc-2.19.so      [.] __stpcpy

[...]

Regards,
Mathieu

[1]. "6909b0a13389 perf stat: Use perf_evsel__is_clocki() for clock events"

Mathieu Poirier (3):
  perf tools: Add configuration for ETMv3 trace protocol
  perf tools: Add support for ETMv3 trace decoding
  perf tools: Add support for PTMv1.1 decoding

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 31 +++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  9 +++
 tools/perf/util/cs-etm.c                        | 73 ++++++++++++++++++++-----
 3 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.7.4
