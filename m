From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 18 May 2016 18:30:24 -0500
Subject: [PATCH 0/2] cpufreq: Introduce TI CPUFreq/OPP Driver
Message-ID: <cover.1463609497.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This series introduces the ti-cpufreq driver which parses SoC data and
provides opp-supported-hw data to the OPP core in order to enable the
proper OPPs for the silicon in use. It still relies on the cpufreq-dt
driver to actually provide cpufreq and creates the "cpufreq-dt" platform
driver after it probes as the sti-cpufreq driver does.

This series will add support for am335x, am437x, dra7xx, and am57xx
platforms, otherwise other TI devices will rely on the recently introduced
cpufreq-dt-platdev code [1] to create the cpufreq-dt device. This means
that the aforementioned platforms do *not* need to be added to
cpufreq-dt-platdev. DTS patches for the above platforms are being sent in
a separate series right after this one. Even without merging the DTS series,
this series will not break backwards compatibility for those platforms above
that already have operating-points v1 tables as the ti-cpufreq driver
fails through and creates the cpufreq-dt platform device if no
operating-points-v2 table is found.

This series is based on linux-next next-20160517 tag, it depends on [2] which
drops the default creation of the cpufreq-dt device from omap platform code,
otherwise we'd end up with a duplicate because this driver creates it also.

Regards,
Dave

[1] http://permalink.gmane.org/gmane.linux.power-management.general/73887
[2] http://permalink.gmane.org/gmane.linux.power-management.general/75215

Dave Gerlach (2):
  Documentation: dt: add bindings for ti-cpufreq
  cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |  89 ++++++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/ti-cpufreq.c                       | 254 +++++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

-- 
2.7.3
