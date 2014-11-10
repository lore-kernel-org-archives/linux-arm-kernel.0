From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 10 Nov 2014 14:52:44 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
Message-ID: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the review of the Qualcomm SMD RPM regulators [1], I got (offline)
feedback that my implementation did not handle "sleep states". As the problem
is shared between all families of Qualcomm platforms I use [2] (family A) to
propose a solution (as I hope to get that merged sooner).

The "sleep states" comment boils down to certain regulators (or rpm resources
in general) are used by the currently clocked/running CPU(s) and can not be
disabled while we're still running. Further more, these resources are shared
with peripherals in the system; e.g. LDO12 on PM8941 is used to clock the CPU
and WiFi/BT PLLs as well as providing power to the display in our devices. So
the suspend functionality in the regulator framework doesn't cut it.


The downstream solution to this is to expose 3 regulators per regulator
resource, each specified to control the active mode, sleep mode or both modes
respectively. Peripherals are directed to use the "both" regulator while the
CPUs are directed to the "active only" regulator.

After reviewing this solution and looking at what it's actually achieving I
here propose flagging these regulators to have "deferred disable";
* we consider the specific regulators as always-on _while running_
* hence, disable and enable affect only the sleep state
* we update both active and sleep state with all other properties

This gives us a single regulator exposed for the resource, that will be kept on
with parameters as specified by the clients if it's referenced and upon loosing
the last reference (disabling all consumers) it will be turned off when the
CPU(s) are sleeping.


As far as I can see this should give the same behaviour as we have downstream,
without the need for playing tricks with how we expose the regulators. However
there's plenty of details hidden in that code, so I hope to get some feedback
from the Qualcomm engineers on this.


The first patch in the series applies on top of [2], it should be squashed with
1 & 2 of [2] and is only included for completeness.

[1] https://lkml.org/lkml/2014/9/29/747
[2] https://lkml.org/lkml/2014/9/22/731

Bjorn Andersson (2):
  mfd: qcom-rpm: Expose sleep state resources to clients
  regulator: qcom-rpm: Implement RPM assisted disable

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |   28 ++++++++
 drivers/mfd/qcom_rpm.c                             |    9 +--
 drivers/regulator/qcom_rpm-regulator.c             |   67 +++++++++++++++-----
 include/linux/mfd/qcom_rpm.h                       |    5 +-
 4 files changed, 88 insertions(+), 21 deletions(-)

-- 
1.7.9.5
