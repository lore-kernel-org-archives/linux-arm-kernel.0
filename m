From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2011 10:35:53 +0100
Subject: [PATCH 0/4] ARM: pmu: improve PMU type identification
In-Reply-To: <4DEFA5E1.9010600@gmail.com>
References: <4DEFA5E1.9010600@gmail.com>
Message-ID: <1307957757-23001-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

I've Addded Jamie on Cc here as he was interested in the possibility of
adding platform_device_id tables. Hopefully it'll be easy to discuss
{of,platform}_id_tables in one thread.

As Jamie pointed out to me the existence of platform_device_id tables,
I took a look around and noticed that of_device_id tables also seem to
provide support for driver-specific parameters (I saw an example of
usage in arch/sparc/kernel/pci_schizo.c).

I've had a go at getting {of,platform}_device_id tables to provide the
PMU type, so they can be used similarly (the macros make entries look
identical apart from the {plat,of} prefix).

I don't have any entries currently for the platform_device_id table,
but it'd be useful for system pmus, if we were to add an L2 Cache
controller PMU driver, it might have a binding like:

> PLAT_MATCH("arm,pl310-pmu", ARM_PMU_TYPE_L2CC),

How does the following series look to you? The first 2 patches are the
ones I mentioned before, unchanged (apart from additional acks).

Mark.


Mark Rutland (4):
  ARM: pmu: refactor reservation
  ARM: pmu: reject duplicate PMU registrations
  ARM: pmu: add OF probing support
  ARM: pmu: add platform_device_id table support

 Documentation/devicetree/bindings/arm/pmu.txt |   22 ++++++
 arch/arm/include/asm/pmu.h                    |    2 +-
 arch/arm/kernel/perf_event.c                  |    4 +-
 arch/arm/kernel/pmu.c                         |   91 ++++++++++++++++++++-----
 4 files changed, 99 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
