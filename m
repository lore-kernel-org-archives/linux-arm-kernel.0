From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  4 Aug 2017 15:31:26 +0100
Subject: [PATCH v2 00/18] firmware: ARM System Control and Management
 Interface(SCMI) support
Message-ID: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Let me begin admitting that we are introducing yet another protocol to
achieve same things as many existing protocols like ARM SCPI, TI SCI,
QCOM RPM, Nvidia Tegra BPMP, and so on.

All I can say is that this new ARM System Control and Management
Interface(SCMI) is more flexible and easily extensible than any of the
existing ones. Many vendors were involved in the making of this formal
specification and is now officially published[1].

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

I had previously posted RFC[2].


Changes:

v1->v2:
	- Additional support for polling based DVFS and per protocol
	  channels
	- Dependent drivers(clock, hwmon, cpufreq and power domains)
	- Various other review comments and issued found during testing
	  addressed
	- Explicit binding for method dropped as even SMC based method
	  are adviertised as mailbox

RFC->v1:
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

Sudeep Holla (18):
  dt-bindings: mailbox: add support for mailbox client shared memory
  dt-bindings: arm: add support for ARM System Control and Management
    Interface(SCMI) protocol
  firmware: arm_scmi: add basic driver infrastructure for SCMI
  firmware: arm_scmi: add common infrastructure and support for base
    protocol
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
  hwmon: add support for sensors exported via ARM SCMI
  cpufreq: add support for CPU DVFS based on SCMI message protocol
  cpufreq: scmi: add support for fast frequency switching

 Documentation/devicetree/bindings/arm/arm,scmi.txt | 174 ++++
 .../devicetree/bindings/mailbox/mailbox.txt        |  28 +
 drivers/clk/Kconfig                                |  10 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-scmi.c                             | 216 +++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/scmi-cpufreq.c                     | 284 ++++++
 drivers/firmware/Kconfig                           |  34 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   3 +
 drivers/firmware/arm_scmi/base.c                   | 293 ++++++
 drivers/firmware/arm_scmi/clock.c                  | 339 +++++++
 drivers/firmware/arm_scmi/common.h                 | 126 +++
 drivers/firmware/arm_scmi/driver.c                 | 992 +++++++++++++++++++++
 drivers/firmware/arm_scmi/perf.c                   | 514 +++++++++++
 drivers/firmware/arm_scmi/power.c                  | 242 +++++
 drivers/firmware/arm_scmi/scmi_pm_domain.c         | 134 +++
 drivers/firmware/arm_scmi/sensors.c                | 287 ++++++
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scmi-hwmon.c                         | 261 ++++++
 include/linux/scmi_protocol.h                      | 215 +++++
 23 files changed, 4179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt
 create mode 100644 drivers/clk/clk-scmi.c
 create mode 100644 drivers/cpufreq/scmi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scmi/Makefile
 create mode 100644 drivers/firmware/arm_scmi/base.c
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
