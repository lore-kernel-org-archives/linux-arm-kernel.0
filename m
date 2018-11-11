From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 11 Nov 2018 13:07:54 +0800
Subject: [PATCH v2 0/2] perf cs-etm: Add support for sample flags
Message-ID: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch seris adds support for sample flags so can facilitate perf
to print sample flags for branch instruction.

The patch 0001 is to set branch instruction flags in packet, this
patch has the core code in this series to set flags according to the
decoding element type, and also based on the elements including
instruction type, subtype and condition flag to help making decision
to set flags value.

The patch 0002 is to support sample flags by copying the flags value
from packet structure to sample structure, and it includes three fixing
up for TRACE_ON/TRACE_OFF and exception packets.

The patch series is based on OpenCSD v0.10.0 and Rob's patch 'perf:
Support for Arm A32/T32 instruction sets in CoreSight trace' also is
prerequisite to support A32/T32 ISAs.

This patch series is applied on the acme's perf core branch [1] with the
latest commit f1d23afaf677 ("perf bpf: Reduce the hardcoded .max_entries
for pid_maps") and has two prerequisites:
1) It's dependent on Rob's patch 'perf: Support for Arm A32/T32
   instruction sets in CoreSight trace' [2];
2) It's dependent on another patch series 'perf cs-etm: Correct packets
   handling' [3].

After applying the dependency patches and this patch series, we can
verify sample flags with below command:

  # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v1:
* Moved exception packets handling patches into patch series 'perf
  cs-etm: Correct packets handling'.
* Added sample flags fixing up for TRACE_OFF packet.
* Created a new function which is used to maintain flags fixing up.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
[2] http://archive.armlinux.org.uk/lurker/message/20181109.091126.9d69489d.en.html
[3] http://archive.armlinux.org.uk/lurker/message/20181111.045938.782b378b.en.html


Leo Yan (2):
  perf cs-etm: Set branch instruction flags in packet
  perf cs-etm: Add support sample flags

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 168 ++++++++++++++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   1 +
 tools/perf/util/cs-etm.c                        |  43 +++++-
 3 files changed, 210 insertions(+), 2 deletions(-)

-- 
2.7.4
