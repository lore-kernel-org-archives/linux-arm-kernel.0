From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  2 Jan 2018 14:42:22 +0000
Subject: [PATCH v5 00/20] firmware: ARM System Control and Management
 Interface(SCMI) support
Message-ID: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

ARM System Control and Management Interface(SCMI) is more flexible and
easily extensible than any of the existing interfaces. Many vendors were
involved in the making of this formal specification and is now published[1].

There is a strong trend in the industry to provide micro-controllers in
systems to abstract various power, or other system management tasks.
These controllers usually have similar interfaces, both in terms of the
functions that are provided by them, and in terms of how requests are
communicated to them.

This specification is to standardise and avoid (any further)
fragmentation in the design of such interface by various vendors.

This patch set is intended to get feedback on the design and structure
of the code. This is not complete and not fully tested due to
non-availability of firmware with full feature set at this time.

It currently doesn't support notification, asynchronous/delayed response,
perf/power statistics region and sensor register region to name a few.
I have borrowed some of the ideas of message allocation/management from
TI SCI.

Changes:

v4[6]->v5:
	- Rebased to v4.15-rc6
	- Updated all the gathered Ack/Reviewed-by tags(which includes
	  all the drivers using SCMI protocol)

v3[5]->v4[6]:
	- Added SCMI protocol bus to enumerate supported protocols as
	  suggested by Arnd
	- Dropped the abstraction to mailbox as it may be optional

v2[4]->v3:
	- Addressed various comments recieved so far(clock, hwmon and
	  cpufreq drivers along with scmi drivers)
	- Hwmon driver now uses core layer to create and manage sysfs
	  attributes
	- Added a shim layer to abstract the mailbox interface to support
	  any custom adaptation required by the controller driver
	- Simple ARM MHU shim layer using newly added abstraction

v1[3]->v2[4]:
	- Additional support for polling based DVFS and per protocol
	  channels
	- Dependent drivers(clock, hwmon, cpufreq and power domains)
	- Various other review comments and issued found during testing
	  addressed
	- Explicit binding for method dropped as even SMC based method
	  are adviertised as mailbox

RFC[2]->v1[3]:
	- Add generic mailbox binding for shared memory(Rob H)
	- Dropped compatibles per protocol(Suggested by Matt S)
	- Dropped lot of unnecessary pointer casting(Arnd B)
	- Dropped packing of structures(Arnd B)
	- Few other changes/additions based initial testing with firmware
	  providing SCMI interface to OSPM

--
Regards,
Sudeep

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
[2] https://marc.info/?l=linux-kernel&m=149685193627620&w=2
[3] https://marc.info/?l=linux-arm-kernel&m=149849482623492&w=2
[4] https://marc.info/?l=devicetree&m=150185763105926&w=2
[5] https://marc.info/?l=devicetree&m=150660452015351&w=2
[6] https://marc.info/?l=devicetree&m=150972061408961&w=2

Sudeep Holla (20):
  dt-bindings: mailbox: add support for mailbox client shared memory
  dt-bindings: arm: add support for ARM System Control and Management
    Interface(SCMI) protocol
  firmware: arm_scmi: add basic driver infrastructure for SCMI
  firmware: arm_scmi: add common infrastructure and support for base
    protocol
  firmware: arm_scmi: add scmi protocol bus to enumerate protocol
    devices
  firmware: arm_scmi: add initial support for performance protocol
  firmware: arm_scmi: add initial support for clock protocol
  firmware: arm_scmi: add initial support for power protocol
  firmware: arm_scmi: add initial support for sensor protocol
  firmware: arm_scmi: probe and initialise all the supported protocols
  firmware: arm_scmi: add support for polling based SCMI transfers
  firmware: arm_scmi: add option for polling based performance domain
    operations
  firmware: arm_scmi: refactor in preparation to support per-protocol
    channels
  firmware: arm_scmi: add per-protocol channels support using idr
    objects
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
 drivers/clk/clk-scmi.c                             | 213 +++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/scmi-cpufreq.c                     | 285 +++++++
 drivers/firmware/Kconfig                           |  34 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   5 +
 drivers/firmware/arm_scmi/base.c                   | 293 +++++++
 drivers/firmware/arm_scmi/bus.c                    | 232 ++++++
 drivers/firmware/arm_scmi/clock.c                  | 353 ++++++++
 drivers/firmware/arm_scmi/common.h                 | 116 +++
 drivers/firmware/arm_scmi/driver.c                 | 895 +++++++++++++++++++++
 drivers/firmware/arm_scmi/perf.c                   | 530 ++++++++++++
 drivers/firmware/arm_scmi/power.c                  | 255 ++++++
 drivers/firmware/arm_scmi/scmi_pm_domain.c         | 140 ++++
 drivers/firmware/arm_scmi/sensors.c                | 302 +++++++
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scmi-hwmon.c                         | 233 ++++++
 include/linux/hwmon.h                              |   1 +
 include/linux/scmi_protocol.h                      | 272 +++++++
 26 files changed, 4409 insertions(+), 5 deletions(-)
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

-- 
2.7.4
