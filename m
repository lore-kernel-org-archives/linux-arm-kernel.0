From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 11 Nov 2018 12:59:38 +0800
Subject: [PATCH v1 0/5] perf cs-etm: Correct packets handling
Message-ID: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

perf cs-etm module converts decoder elements to packets and then we have
more context crossing packets to generate synthenize samples, finally
perf tool can faciliate samples for statistics and report the results.

This patch series is to address several issues found related with
packets handling and samples generation when worked firstly on branch
sample flags support for Arm CoreSight trace data,  so this patch series
also is dependency for another patch series for sample flags.

The first two patches are mainly to fix issues in cs_etm__flush():
Patch 0001 corrects packets swapping in cs_etm__flush() and this can fix
the wrong branch sample caused by the missed packets swapping; patch
0002 is to fix the wrong samples generation with stale packets at the
end of every trace buffer.

Patch 0003 is used to support NO_SYNC packet, otherwise the trace
decoding cannot reflect the tracing discontinuity caused by NO_SYNC
packet.

Patch 0004/0005 has been published in the patch series 'perf cs-etm: Add
support for sample flags' before but at this time I move them into this
patch series due these two patches are more relative with packets
handling.  Patch 0004 is used to generate branch sample for exception
packets; and patch 0005 is to track the exception number.

This patch series is applied on the acme's perf core branch [1] with the
latest commit f1d23afaf677 ("perf bpf: Reduce the hardcoded .max_entries
for pid_maps") and has one prerequisite from Rob's patch 'perf: Support
for Arm A32/T32 instruction sets in CoreSight trace' [2].

With applying the dependency patch, this patch series has been tested
for branch samples dumping with below command on Juno board:

  # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
[2] http://archive.armlinux.org.uk/lurker/message/20181109.091126.9d69489d.en.html


Leo Yan (5):
  perf cs-etm: Correct packets swapping in cs_etm__flush()
  perf cs-etm: Avoid stale branch samples when flush packet
  perf cs-etm: Support for NO_SYNC packet
  perf cs-etm: Generate branch sample for exception packet
  perf cs-etm: Track exception number

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 91 ++++++++++++++++++++++---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 11 +--
 tools/perf/util/cs-etm.c                        | 65 +++++++++++++++---
 3 files changed, 146 insertions(+), 21 deletions(-)

-- 
2.7.4
