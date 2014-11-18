From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 18 Nov 2014 00:31:46 -0700
Subject: [PATCH v4/RFC 0/4] per-cpu PM QoS
Message-ID: <1416295910-40433-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM QoS constraints like the CPU_DMA_LATENCY, when set, apply to all cpus. The
QoS guarantees performance, at the expense of power. There is an opportunity to
save power on the cpus, if a subset of cpus need not participate in honoring
the QoS request.

The patches do the following - 

- Add "type" member to the QoS request data structure. Drivers requesting PM
  QoS, can qualify the type of the QoS request. Request could be either of
  all-cpus (default) or a cpumask or the cpus associated by smp-affinity to a
  device IRQ.

- QoS requests can supply an cpumask or an IRQ.

- Each constraint has a per-cpu target variable, to hold the QoS value for the
  constraint.

- When updating the QoS constraint target value, update the per-cpu target
  value of the constraint.

- Export the IRQ smp-affinity information from the IRQ framework.

- When the IRQ smp-affinity changes, notify PM QoS framework, which would update
  the target value for each of the constraint affected by the change in the
  smp-affinity of the IRQ.

TODO:

- Update the QoS constraint, when the IRQ is enabled/disabled.

- The IRQ affinity is an expected affinity, but the actual affinity is
  architecture dependent. Explore possibility of optimizations.

- Update cpuidle to use the per-cpu PM QoS to query the QoS value of the cpus
  interested.

Thanks,
Lina

Lina Iyer (4):
  QoS: Modify data structures and function arguments for scalability.
  QoS: Enhance PM QoS framework to support per-cpu QoS request
  irq: Add irq_get_affinity() api
  QoS: Enable PM QoS requests to apply only on smp_affinity of an IRQ

 Documentation/power/pm_qos_interface.txt |  18 +++
 drivers/base/power/qos.c                 |  14 +--
 include/linux/interrupt.h                |   8 ++
 include/linux/pm_qos.h                   |  22 +++-
 kernel/irq/manage.c                      |  21 ++++
 kernel/power/qos.c                       | 183 +++++++++++++++++++++++++++++--
 6 files changed, 249 insertions(+), 17 deletions(-)

-- 
2.1.0
