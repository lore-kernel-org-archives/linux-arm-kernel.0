From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 Apr 2015 17:10:16 +0100
Subject: [RFC PATCH v2 0/1] ARM: cpuidle: heterogeneous systems extension
Message-ID: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a v2 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328192.html

v1 -> v2:

- Rebased against 4.0
- Removed DT affinity probe interface
- Improved and optimized idle states comparison and cpumask creation
- Merged DT idle states vetting code in the ARM CPUidle driver

This patch aims at enabling the generic CPUidle driver on ARM systems
with heterogeneous idle states. In the CPUidle context the kernel
considers cpus equal (and group them together through a CPUidle driver)
if they share the same set of idle states.
Since the idle states represent the differentiation point when it comes
to creating CPUidle drivers (their states and related cpu logical mask),
the idle states can be used as a means to create logical masks of cpus
for which the CPUidle driver applies.

This patch sets the maximum number of static CPUidle drivers allowed to
two, since it is hard to foresee systems with more than two sets of CPUs
having different idle states; it is meant to keep allocation simple
while keeping functionality.

The code carrying out idle states comparison is completely generic
and borrowed from OF unit tests; it overrides the OF API entirely
though to carry out properties (ie phandles list) comparison in the
fastest possible way. If deemed worthwhile it can be moved to generic OF
layer.

Tested through several dts idle states permutations on Juno board with
CPUidle and related idle states enabled.

Cc: Howard Chen <howard.chen@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>

Lorenzo Pieralisi (1):
  drivers: cpuidle: cpuidle-arm: heterogeneous systems extension

 drivers/cpuidle/Kconfig.arm   |   1 +
 drivers/cpuidle/cpuidle-arm.c | 176 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 152 insertions(+), 25 deletions(-)

-- 
2.2.1
