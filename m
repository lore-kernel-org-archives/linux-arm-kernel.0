From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 11 Jul 2018 15:45:39 +0800
Subject: [PATCH v2 0/6] perf cs-etm: Fix tracing packet handling and minor
 refactoring
Message-ID: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
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

This patch series is applied to Linus tree on 4.18-rc4 with latest
commit: 1e09177acae3 ("Merge tag 'mips_fixes_4.18_3' of
git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux").

This patch series has been verified on Hikey620 platform with below two
commands:
perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
perf script -F cpu,event,ip,addr,sym -k ./vmlinux

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Changes from v1:
* Rebased on Linus mainline kernel 4.18-rc4;
* Added Mathieu 'reviewed' tags in patches.


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
