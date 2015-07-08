From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  8 Jul 2015 18:16:46 +0100
Subject: [PATCH v2 0/5] drivers: firmware: psci: add basic v1.0 support
Message-ID: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a v2 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347352.html

v1 -> v2:

- rebased against v4.2-rc1
- added version to 1.0 specific macros

The PSCI v1.0 specification[1] introduces a brand new set of features
(ie OS initiated mode and system suspend being the most notable ones)
and provides updates to the PSCI 0.2 specification, keeping backward
compatibility.

PSCI v1.0 applies minor changes to function return codes and function
behaviour (ie AFFINITY_INFO requirements, INVALID_ADDRESS return value)
and introduces a new power_state parameter format (extended stateid)
that is probeable with the newly introduced PSCI_FEATURES call.

This series upgrades the current kernel PSCI layer implementation with
a set of patches that make the kernel PSCI v1.0 compliant.

The series augments the PSCI firmware layer with a hook to retrieve
the features for a specific PSCI function (ie based on the PSCI_FEATURES
call) and uses it to detect the power_state parameter format, updating
the power_state parameter handling functions accordingly.

In order to prevent firmware interfaces mismatch, a new compatible
string is added to the DT bindings to characterize a 1.0 compliant
firmware interface.

The series is built on top of M.Rutland's patch series:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/353795.html

Tested on a Juno board.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf

Lorenzo Pieralisi (5):
  drivers: firmware: psci: add INVALID_ADDRESS return value
  drivers: firmware: psci: move power_state handling to generic code
  drivers: firmware: psci: add PSCI_FEATURES call
  drivers: firmware: psci: add extended stateid power_state support
  drivers: firmware: psci: add PSCI v1.0 DT bindings

 Documentation/devicetree/bindings/arm/psci.txt |  6 +++
 arch/arm64/kernel/psci.c                       | 14 -------
 drivers/firmware/psci.c                        | 53 ++++++++++++++++++++++++++
 include/linux/psci.h                           |  2 +
 include/uapi/linux/psci.h                      | 15 ++++++++
 5 files changed, 76 insertions(+), 14 deletions(-)

-- 
2.2.1
