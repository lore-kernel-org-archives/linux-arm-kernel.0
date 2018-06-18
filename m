From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 18 Jun 2018 13:09:53 +0800
Subject: [PATCH v1 0/6] perf cs-etm: Fix tracing packet handling and minor
 refactoring
Message-ID: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due the current code is missing to handle cs-etm start tracing packet
and CS_ETM_TRACE_ON packet, we fail to generate branch sample for them.

This patch series is to fix cs-etm tracing packet handling:

Patch 0001 is to add invalid address macro for readable coding;

Patch 0002 is one minor fixing to return error code for instruction
sample failure;

Patches 0003~0006 are fixing patches for start tracing packet
and CS_ETM_TRACE_ON packet.

This patch series is applied on acme tree [1] on branch perf/core with
latest commit: e238cf2e3d2e ("perf intel-pt: Fix packet decoding of CYC
packets").  Also applied successfully this patch series on Linus tree
on 4.18-rc1.

This patch series has been verified on Hikey620 platform with below two
commands:
perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
perf script -F cpu,event,ip,addr,sym -k ./vmlinux

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git


Leo Yan (6):
  perf cs-etm: Introduce invalid address macro
  perf cs-etm: Bail out immediately for instruction sample failure
  perf cs-etm: Fix start tracing packet handling
  perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
  perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
    packet
  perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
 3 files changed, 68 insertions(+), 14 deletions(-)

-- 
2.7.4
