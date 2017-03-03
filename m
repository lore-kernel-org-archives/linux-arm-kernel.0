From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri,  3 Mar 2017 13:48:11 -0800
Subject: [PATCH V5 0/6] PSCI: Support hierarchical PM domains
Message-ID: <1488577697-127445-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series adds support for hierarchical idle states in PSCI. Up until and
including PSCI v1.0, CPUs idle states could only be represented as flattened
model with CPU as part of the cpu-idle-states property in DT. For ex.,
	CPU0: cpu at 0 {
		device_type = "cpu";
		cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
	};

This patchset adds support to split CPU and cluster idle states and
present them in hierarchy. The documentation in patch 5 explains this difference.
 
In order to be backwards compatible, the cpuidle driver and the PSCI driver has
been updated to look for hierarchy first and if not present will revert to
initializing using the flattened model.

This patch uses CPU PM domains published earlier.

Changes since last submission -
- Support both hierarchical model and flattened model
- Documentation updates.
- Rebase on top of Rafael's linux-next

Thanks,
Lina

Lina Iyer (6):
  drivers: cpuidle: Read CPU's idle state from PM domain
  drivers: firmware: psci: Allow OS Initiated suspend mode
  drivers: firmware: psci: Support cluster idle states for OS-Initiated
  drivers: firmwware: psci: Support hierachical idle states
  dt/bindings: Update binding for hierarchical PSCI states
  ARM64: dts: Define CPU power domain for MSM8916

 Documentation/devicetree/bindings/arm/psci.txt | 156 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi          |  53 +++++++-
 drivers/cpuidle/dt_idle_states.c               |  38 +++++-
 drivers/firmware/psci.c                        | 167 +++++++++++++++++++++----
 include/uapi/linux/psci.h                      |   5 +
 5 files changed, 388 insertions(+), 31 deletions(-)

-- 
2.7.4
