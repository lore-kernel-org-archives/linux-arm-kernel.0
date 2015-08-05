From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Aug 2015 10:32:36 -0600
Subject: [PATCH RFC 00/10] qcom: 8084: Cluster idle support
In-Reply-To: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add support to power down the L2 and the PM domain for the CPU
subsystem on Qualcomm's APQ8084. Only 8084 is supported at this time, because
the firmware for chipsets prior to 8084 (8074, 8064) will allow the domain to
be powered off only when running as a single core system. That is, all
secondary cores must be hotplugged off. With 8084, a new feature in the
firmware allows any core to be the last core to enter power down state. The
state of the L2 power controller will be carried as an argument by the last
CPU, when entering SCM.

This patchset extensively uses the changes to GenPD and the CPU PM domain
introduced by [1]. Also under discussion on the mailing list, is the hwspinlock
changes that are part of this series.

I have tested this on 8084. But invalidating cache causes a system hang and is
under investigation. This patchset at this time is only provided as a proof of
concept for using CPU PM domains.

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg437091.html

Lina Iyer (10):
  drivers: qcom: spm: Support cache SPMs
  drivers: qcom: spm: Add 8084 L2 SPM register data
  drivers: qcom: spm: Enable runtime suspend/resume of CPU PM domain
  arm: dts: Add L2 power-controller device bindings for APQ8084
  arm: dts: Add power domain device bindings for APQ8084
  drivers: qcom: Enable genpd on selecting QCOM_PM
  hwspinlock: Introduce raw capability for hwspinlocks
  hwspinlock: qcom: Lock #7 is special lock, uses dynamic proc_id
  drivers: qcom: spm: Use hwspinlock to serialize entry into SCM
  arm: dts: qcom: Add TCSR mutex device bindings for APQ8084

 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |   1 +
 Documentation/hwspinlock.txt                       |  16 +++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  21 +++-
 drivers/hwspinlock/hwspinlock_core.c               |  75 +++++++-----
 drivers/hwspinlock/hwspinlock_internal.h           |   6 +
 drivers/hwspinlock/qcom_hwspinlock.c               |  22 +++-
 drivers/soc/qcom/Kconfig                           |   5 +
 drivers/soc/qcom/spm.c                             | 130 ++++++++++++++++++---
 include/linux/hwspinlock.h                         |  41 +++++++
 9 files changed, 264 insertions(+), 53 deletions(-)

-- 
2.1.4
