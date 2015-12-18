From: fan.chen@mediatek.com (Fan Chen)
Date: Fri, 18 Dec 2015 10:42:27 +0800
Subject: [PATCH 0/4] mediatek: Add cpuidle cluster sleep support for MT8173
Message-ID: <1450406551-1741-1-git-send-email-fan.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is to enable cpuidle cluster sleep for MT8173, which is
based on Lorenzo Pieralisi's patch[1] to give different configuration
for each cluster in big.LITTLE architecture.

Power domain control flow is the same in both cpu and non-cpu domains,
and some of power domains(e.g. cpu clusters, mfg, mm in mt8173) need
to set bus protection bits before power off and vice versa on power on.
However, in PSCI framework, cpu power domain controlling is hidden in
ARM TF but non-cpu ones are controlled in kernel driver so that 
race condition on accessing bus protection register will happen between
cpu power domains and non-cpu ones in runtime once we enable cluster sleep
without any protection.

Therefore, we also introduce patches to create SIP call API based on
Jens Wiklander's patches[2][3] and modify scpsys driver to give an option
to put non-cpu power control into ARM TF via SIP call, which gives a way
to manage all power domains together in firmware.

[1] https://patchwork.kernel.org/patch/6226871/
[2] https://patchwork.kernel.org/patch/7517271/
[3] https://patchwork.kernel.org/patch/7517261/

Fan Chen (1):
  soc: Mediatek: Create Mediatek SIP call

Weiyi Lu (2):
  arm64: dts: mediatek: Add cluster sleep support on MT8173
  arm64: dts: mediatek: Improve cpuidle latency on MT8173

yt.lee (1):
  soc: mediatek: To move power control logic to ARM TF

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   41 ++++++++--
 drivers/soc/mediatek/Kconfig             |    8 ++
 drivers/soc/mediatek/Makefile            |    1 +
 drivers/soc/mediatek/mtk-scpsys.c        |  122 +++++++++++++++++++-----------
 drivers/soc/mediatek/mtk-sip.c           |   28 +++++++
 include/linux/soc/mediatek/mtk-sip.h     |   21 +++++
 6 files changed, 170 insertions(+), 51 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-sip.c
 create mode 100644 include/linux/soc/mediatek/mtk-sip.h

-- 
1.7.9.5
