From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Jun 2017 10:56:00 +0100
Subject: [PATCH 0/8] mailbox: arm/arm64: introduce smc triggered mailbox
Message-ID: <20170630095608.24943-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The traditional Linux mailbox mechanism uses some kind of dedicated hardware
IP to signal a condition to some other processing unit, typically a dedicated
management processor.
This mailbox feature is used for instance by the SCPI protocol to signal a
request for some action to be taken by the management processor.
And while it seems useful to have a dedicated management core to provide
those services offered via the SCPI protocol, a separate and independent
execution unit is not always required, for instance for just setting up
a clock or enabling a device power supply. Those services could be as well
provided by firmware code running on the very same application processor
cores as the OS, using the ARM TrustZone mechanism to protect and abstract
those services. And while the existing SCPI implementation uses a rather
flexible shared memory region to communicate commands and their parameters,
it still requires a mailbox to actually trigger the action.

This patch series provides a Linux mailbox compatible service which uses
smc calls to invoke firmware code, for instance taking care of SCPI requests.
The actual requests are still communicated using the standard SCPI way of
shared memory regions, but a dedicated mailbox hardware IP can be replaced via
this new driver, which not only serves as a trigger for the request, but also
transfers execution to the firmware code in a safe and architected way.

This simple driver uses the architected SMC calling convention to trigger
firmware services, also allows for using "HVC" calls to call into hypervisors
or firmware layers running in the EL2 exception level.

Patch 1 introduces the actual mailbox driver, patch 2 contains the respective
device tree binding documentation, patch 3 enabled the driver in Kconfig.

The remaining patches demonstrate usage of this feature to drive SCPI services
implemented as part of the ARM Trusted Firmware implementation used for
AArch64 based Allwinner SoCs, the Allwinner A64 in this example.
It allows to provide DVFS services, sensors support, device power domains
and potentially other services like clocks or regulators.
This allows to abstract those features in firmware, without the need to
implement explicit Linux support for each variant of some SoC design.
Those DT changes are not necessarily meant to be merged at this point.
I started implementing the firmware side of those services and put a WIP
branch on my ATF Github repo [1]. With this branch and these patches here
you get DVFS and temperature sensor support for the A64, just with this
driver and the generic SCPI support.

Please note that this driver just provides a generic mailbox mechanism,
though this is synchronous and one-way only (triggered by the OS only,
without providing an asynchronous way of triggering request from the
firmware).
And while providing SCPI services was the reason for this exercise, this
driver is in no way bound to this use case, but can be used generically
where the OS wants to signal a mailbox condition to firmware or a
hypervisor.

Please have a look and comment whether this sounds like a useful addition
to the kernel.

Cheers,
Andre.

[1] https://github.com/apritzel/arm-trusted-firmware/commits/allwinner-scpi-wip

Andre Przywara (8):
  mailbox: introduce ARM SMC based mailbox
  dt-bindings: mailbox: add binding doc for the ARM SMC mailbox
  mailbox: Kconfig: enable ARM SMC mailbox on 64-bit Allwinner SoCs
  arm64: dts: allwinner: a64: add SCPI support
  arm64: dts: allwinner: a64: add SCPI DVFS nodes
  arm64: dts: allwinner: a64: add SCPI sensors support
  arm64: dts: allwinner: a64: add SCPI power domain support
  arm64: dts: allwinner: a64: add (unused) MMC clock node

 .../devicetree/bindings/mailbox/arm-smc.txt        |  61 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  63 ++++++++
 drivers/mailbox/Kconfig                            |   9 ++
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 172 +++++++++++++++++++++
 5 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c

-- 
2.9.0
