From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 15 Nov 2018 12:55:45 +0000
Subject: [PATCH 0/4] arm64: Support perf event modifiers :G and :H
Message-ID: <1542286549-4501-1-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provides support for perf event modifiers :G and :H which
allows for filtering of PMU events between host and guests when used
with KVM.

As the underlying hardware cannot distinguish between guest and host
context, the performance counters must be stopped and started upon
entry/exit to the guest. This is performed at EL2 in a way that
minimizes overhead and improves accuracy of recording events that only
occur in the requested context.

This has been tested with VHE and non-VHE kernels with a KVM guest.

Andrew Murray (4):
  arm64: KVM: add accessors to track guest/host only counters
  arm64: arm_pmu: Add support for exclude_host/exclude_guest attributes
  arm64: arm_pmu: Exclude EL1,2 with :G :H perf attributes
  arm64: KVM: Enable support for :G/:H perf event modifiers

 arch/arm64/include/asm/kvm_host.h | 20 +++++++++++++++++
 arch/arm64/kernel/perf_event.c    | 45 +++++++++++++++++++++++++++++++++------
 arch/arm64/kvm/hyp/switch.c       | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 7 deletions(-)

-- 
2.7.4
