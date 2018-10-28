From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 28 Oct 2018 20:34:51 +0800
Subject: [PATCH v1 0/4] perf cs-etm: Add support for sample flags
Message-ID: <1540730095-6732-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch seris adds support for sample flags so can facilitate perf
to print sample flags for branch instruction.

The branch instructions also include exception taken and return
related instructions, so the first patch is used to generate branch
sample for exception packets; and the second patch is to track the
exception number.

The patch 0003 is to set branch instruction flags in packet, this
patch has the core code in this series to set flags according to the
decoding element type, and also based on the elements including
instruction type, subtype and condition flag to help making decision
to set flags value.

The patch 0004 is to support sample flags by copying the flags value
from packet structure to sample structure, and it includes two fixing
up for TRACE_ON and exception packets.

The patch series is based on OpenCSD v0.10.0 and Rob's patch 'perf:
Support for Arm A32/T32 instruction sets in CoreSight trace' also is
prerequisite to support A32/T32 ISAs.

The patches can be applied on the acme core branch [1] and tested on
Juno board with below commands for A64 and A32/T32 building:

  # perf script -F,-time,+flags,+ip,+sym,+addr -k vmlinux


Leo Yan (4):
  perf cs-etm: Generate branch sample for exception packet
  perf cs-etm: Track exception number
  perf cs-etm: Set branch instruction flags in packet
  perf cs-etm: Add support sample flags

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 237 +++++++++++++++++++++++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  11 +-
 tools/perf/util/cs-etm.c                        |  44 ++++-
 3 files changed, 277 insertions(+), 15 deletions(-)

-- 
2.7.4
