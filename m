From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Mar 2018 16:27:31 +0000
Subject: [GIT PULL] firmware: ARM SCMI support for v4.17
Message-ID: <20180301162731.GC1752@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please note that this PR is different from SCPI one and I have kept
this pull request separate intentionally since this new addition. Going
forward, I can merge both SCPI and SCMI changes together if required.

I think the tag description is pretty elaborate, so I don't have
anything much to add.

Please pull !

Regards,
Sudeep

--

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-updates-4.17

for you to fetch changes up to 02f208c5c60549039445402505dea284e15f0f4f:

  cpufreq: scmi: add support for fast frequency switching (2018-02-28 16:37:57 +0000)

----------------------------------------------------------------
ARM SCMI support for v4.17

ARM System Control and Management Interface(SCMI)[1] is more flexible and
easily extensible than any of the existing interfaces.

Few existing as well as future ARM platforms provide micro-controllers
to abstract various power and other system management tasks which have
similar interfaces, both in terms of the functions that are provided by
them, and in terms of how requests are communicated to them.

There are quite a few protocols like ARM SCPI, TI SCI, QCOM RPM, Nvidia Tegra
BPMP, and so on already. This specification is to standardize and avoid any
further fragmentation in the design of such interface by various vendors.

The current SCMI driver implementation is very basic and initial support.
It lacks support for notifications, asynchronous/delayed response, perf/power
statistics region and sensor register region.

Mailbox is the only form of transport supported currently in the driver.
SCMI supports interrupt based mailbox communication, where, on completion
of the processing of a message, the caller receives an interrupt as well as
polling for completion.

SCMI is designed to minimize the dependency on the mailbox/transport
hardware. So in terms of SCMI, each channel in the mailbox includes
memory area, doorbell and completion interrupt.

However the doorbell and completion interrupt is highly mailbox dependent
which was bit of controversial as part of SCMI/mailbox discussions.

Arnd and me discussed about the few aspects of SCMI and the mailbox framework:

1. Use of mailbox framework for doorbell type mailbox controller:
   - Such hardware may not require any data to be sent to signal the remote
     about the presence of a message. The channel will have in-built
     information on how to trigger the signal to the remote.
     There are few mailbox controller drivers which are purely doorbell based.
     e.g.QCOM IPC, STM, Tegra, ACPI PCC,..etc

2. Supporting other mailbox controller:
   - SCMI just needs a mechanism to signal the remote firmware. Such
     controller may need fixed message to be sent to trigger a doorbell.
     In such case we may need to get that data from DT and pass the same
     to the controller. It's not covered in the current DT binding, but
     can be extended as optional property in future.

     However handling notifications may be interesting on such mailbox, but
     again there is no way to interpret what the data field(remote message)
     means, it could be a bit mask or a number or don't-care.

Arnd mentioned that he doesn't like the way the mailbox binding deals
with doorbell-type hardware, but we do have quite a few precedent drivers
already and changing the binding to add a data field would not make it any
better, but could cause other problems. So he is happy with the status quo
of SCMI implementation.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0056a/index.html

----------------------------------------------------------------
Sudeep Holla (20):
      dt-bindings: mailbox: add support for mailbox client shared memory
      dt-bindings: arm: add support for ARM System Control and Management Interface(SCMI) protocol
      firmware: arm_scmi: add basic driver infrastructure for SCMI
      firmware: arm_scmi: add common infrastructure and support for base protocol
      firmware: arm_scmi: add scmi protocol bus to enumerate protocol devices
      firmware: arm_scmi: add initial support for performance protocol
      firmware: arm_scmi: add initial support for clock protocol
      firmware: arm_scmi: add initial support for power protocol
      firmware: arm_scmi: add initial support for sensor protocol
      firmware: arm_scmi: probe and initialise all the supported protocols
      firmware: arm_scmi: add support for polling based SCMI transfers
      firmware: arm_scmi: add option for polling based performance domain operations
      firmware: arm_scmi: refactor in preparation to support per-protocol channels
      firmware: arm_scmi: add per-protocol channels support using idr objects
      firmware: arm_scmi: add device power domain support using genpd
      clk: add support for clocks provided by SCMI
      hwmon: (core) Add hwmon_max to hwmon_sensor_types enumeration
      hwmon: add support for sensors exported via ARM SCMI
      cpufreq: add support for CPU DVFS based on SCMI message protocol
      cpufreq: scmi: add support for fast frequency switching

 Documentation/devicetree/bindings/arm/arm,scmi.txt | 179 +++++
 .../devicetree/bindings/mailbox/mailbox.txt        |  28 +
 MAINTAINERS                                        |  11 +-
 drivers/clk/Kconfig                                |  10 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-scmi.c                             | 202 +++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/scmi-cpufreq.c                     | 264 +++++++
 drivers/firmware/Kconfig                           |  34 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   5 +
 drivers/firmware/arm_scmi/base.c                   | 253 ++++++
 drivers/firmware/arm_scmi/bus.c                    | 221 ++++++
 drivers/firmware/arm_scmi/clock.c                  | 342 ++++++++
 drivers/firmware/arm_scmi/common.h                 | 105 +++
 drivers/firmware/arm_scmi/driver.c                 | 871 +++++++++++++++++++++
 drivers/firmware/arm_scmi/perf.c                   | 481 ++++++++++++
 drivers/firmware/arm_scmi/power.c                  | 221 ++++++
 drivers/firmware/arm_scmi/scmi_pm_domain.c         | 129 +++
 drivers/firmware/arm_scmi/sensors.c                | 291 +++++++
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scmi-hwmon.c                         | 225 ++++++
 include/linux/hwmon.h                              |   1 +
 include/linux/scmi_protocol.h                      | 277 +++++++
 26 files changed, 4172 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt
 create mode 100644 drivers/clk/clk-scmi.c
 create mode 100644 drivers/cpufreq/scmi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scmi/Makefile
 create mode 100644 drivers/firmware/arm_scmi/base.c
 create mode 100644 drivers/firmware/arm_scmi/bus.c
 create mode 100644 drivers/firmware/arm_scmi/clock.c
 create mode 100644 drivers/firmware/arm_scmi/common.h
 create mode 100644 drivers/firmware/arm_scmi/driver.c
 create mode 100644 drivers/firmware/arm_scmi/perf.c
 create mode 100644 drivers/firmware/arm_scmi/power.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_pm_domain.c
 create mode 100644 drivers/firmware/arm_scmi/sensors.c
 create mode 100644 drivers/hwmon/scmi-hwmon.c
 create mode 100644 include/linux/scmi_protocol.h
