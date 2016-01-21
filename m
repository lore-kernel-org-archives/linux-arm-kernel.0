From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 21 Jan 2016 18:53:46 +0800
Subject: [PATCH v2 RESEND 0/4] arm64: Hi6220: enable CPU idle states
Message-ID: <1453373630-4693-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is to enable CPU idle states for Hi6220.

Hi6220 uses PSCIv0.2 compliance interface, so directly use ARM's generic
CPUIdle driver. Patch 1 is to reserve memory regions so make sure MCU can
work well to handle power controlling; Patch 2/3 enable sp804 timer as
broadcast timer during idle states; Patch 4 registers CPU power down state
and cluster power down state.

Patch 1 "arm64: dts: Reserve memory regions for hi6220" reserves memory
regions by carve out from memory node; This follows up Mark Rutland's
suggestion to avoid risks, such like kernel's linear mapping for reserved
secure memory region may introduce speculative accesses triggering aborts
from trustzone controller (TZC) and potential cache alias problem.

Rob Herring expressed reservations for this method and says "regions should
be marked as reserved, it's not really worth holding up this platform
further", so appreciate Rob helped to make progress for this series.

The resend patch series have been rebased on mainline kernel, and tested on
Hikey board. During testing I found CPUIdle menu governor is broken, this
bug has been reported by Sudeep; Rafael J. Wysocki already has committed
patch [1] to fix this issue. Testing pass after applied Rafael's patch.

Changes from v1:
* According to Sudeep's review, fix binding for idle-states
* According to Rob's review, due timers share same clock source with apb
  clock, so just only pass one clock phandle

[1] http://article.gmane.org/gmane.linux.kernel.commits.head/573361


Leo Yan (4):
  arm64: dts: Reserve memory regions for hi6220
  arm64: Kconfig: select sp804 timer for ARCH_HISI
  arm64: dts: add sp804 timer node for Hi6220
  arm64: dts: enable idle states for Hi6220

 arch/arm64/Kconfig.platforms                   |  1 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 40 ++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 4 deletions(-)

-- 
1.9.1
