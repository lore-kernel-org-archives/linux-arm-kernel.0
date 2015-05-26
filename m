From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 26 May 2015 10:53:09 +0100
Subject: [PATCH 0/7] ARM CCI PMU updates for 4.2
Message-ID: <1432633996-7229-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Hi,

Here is the series which adds support for the CCI-500
PMU. Could you please apply this for 4.2 ?

Please let me know if you need a pull request, I could ask Will to
setup one.

---
This series adds the support for CCI-500 PMU,  by
reusing and rearranging the CCI-400 PMU driver code.

CCI-500 (the new Cache Coherent Interconnect IP) has
a PMU with 8 independent event counters and supports
profiling events related to master/slave interfaces
along with the global events(cci internal events).

The series also adds aliases for events for all the
supported CCI PMUs(CCI_400{r0,r1}, CCI_500).

Patches 1/7 is a fix posted by Mark Salter, which has
been posted to arm at kernel.org already. I have included
it in this series, as this series applies on top of it.

Patches 2-5 - Creates an abstraction of a CCI PMU and
makes the CCI-400 driver code to make use of the abstraction.
Patch 6 - Adds the CCI-500 PMU driver support
Patch 7 - Adds the aliases for CCI PMU events (specific to chipsets).

With the series, one can use named events for the CCI pmus.

e.g, CCI-400

 # perf list | grep CCI
  CCI_400/cycles/                                    [Kernel PMU event]
  CCI_400/mi_retry_speculative_fetch,source=?/       [Kernel PMU event]

e.g, CCI-500

 # perf list |grep CCI
  CCI_500/cci_rq_stall_address_hazard/               [Kernel PMU event]
  CCI_500/cci_snoop_access_filter_bank_0_1/          [Kernel PMU event]

Testing was performed on a fast model, with perf fuzzer and functional
tests for the CCI-500 PMU.
---
Changes since V1:  https://lkml.org/lkml/2015/5/5/323

The series remains functionaly pretty much the same, except for a minor
fix in the Kconfig default for CCI-500.
  - Pulled in a CCI-400 config fix posted separately,
    as Patch 1/7.
	https://patchwork.kernel.org/patch/6387121/
  - Add the similar Kconfig changes for CCI-500 as fixed in
    the patch above.
  - Dropped Mark Salter's fix for CCI, which is now queued.

Suzuki K. Poulose (7):
  arm-cci: Do not enable CCI-400 PMU by default
  arm-cci: Cleanup PMU driver code
  arm-cci: Abstract out the PMU counter details
  arm-cci: Abstract handling for CCI events
  arm-cci: Sanitise CCI400 PMU driver specific code
  arm-cci: Add CCI-500 PMU support
  arm-cci: Add aliases for PMU events

 Documentation/devicetree/bindings/arm/cci.txt |    4 +-
 drivers/bus/Kconfig                           |   31 +-
 drivers/bus/arm-cci.c                         |  905 ++++++++++++++++++++-----
 3 files changed, 763 insertions(+), 177 deletions(-)

-- 
1.7.9.5
