From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 13 Oct 2017 12:26:43 +0100
Subject: [RESEND PATCH 0/2] Distinguish percpu irq and percpu_devid irq
Message-ID: <1507894005-53778-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resending with cover letter + better commit message for patch 1]

Hi,

Looking at the arm_pmu driver, it seems we are using irq_is_percpu when we
want to know if an irq must be configured individually on each cpu. But
this is not what irq_is_percpu does. The arm_pmu marking all its irqs as
PERCPU, driver attempts to enable the irq on each CPU even when it is not
needed.

This has not caused issue so far because enable_percpu_irq returns
immediatly if the provided irq is not PERCPU_DEVID.

* Patch 1 adds the function to identify PERCPU_DEVID irqs.
* Patch 2 replaces the irq_is_percpu calls with the new function

Cheers,

Julien

Julien Thierry (2):
  irqdesc: Add function to identify percpu_devid irqs
  arm/arm64: pmu: Distinguish percpu irq and percpu_devid irq

 drivers/perf/arm_pmu.c          | 10 +++++-----
 drivers/perf/arm_pmu_platform.c |  4 ++--
 include/linux/irqdesc.h         |  8 ++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

--
1.9.1
