From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Wed, 20 Jan 2016 20:29:25 +0600
Subject: [PATCH v6 0/2] Add AMBA bus probing support to ACPI
Message-ID: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discussed when Shannon Zhao sent a patch to add platform_device support
to pl061 driver. Russell and other maintainers prefered that ACPI learned
how to create AMBA devices rather than converting/adding platform_device
support to AMBA drivers.

http://comments.gmane.org/gmane.linux.ports.arm.kernel/431364

This patchset

1) Adds basic AMBA device probing support to ACPI, it uses a whitelist of
device IDs as the number of AMBA devices is limited. Currently the only id
present is of the GPIO device that is used in QEMU for arm64.

2) Adds the plumbing into ACPI probe sequence.

3) Factors out the code that finds the first physical node of an ACPI device.

v6:
- Fix style issues (Andy Shevchenko)
- Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

v5:
https://lkml.kernel.org/g/1452518790-27053-1-git-send-email-aleksey.makarov at linaro.org
- Introduce a new function acpi_get_first_physical_node() in a separate patch
  (Andy Shevchenko)
- Combine the patch "ACPI: amba bus probing support" with the one line patch
  "ACPI: scan add in amba probing"
- Drop patch "serial: amba-pl011: add ACPI support to AMBA probe" until maintainers
  decide on the further directions (see [1, 2])
- Don't initialize dev->dev.parent and set the device's name with amba_device_alloc()
  (Russell King)
- Fix minor bugs and style issues (Andy Shevchenko)

[1] https://lkml.kernel.org/g/20160106100700.GA19062 at n2100.arm.linux.org.uk
[2] https://lkml.kernel.org/g/20160106110350.GB3599 at xora-haswell.xora.org.uk

v4:
https://lkml.kernel.org/g/1450880383-29560-1-git-send-email-aleksey.makarov at linaro.org
- A memory leak has been fixed (Vladimir Zapolskiy)
- ACPI_COMPANION() -> has_acpi_companion() (Andy Shevchenko)
- pr_err() -> dev_err() (Andy Shevchenko)
- The call to amba_register_dummy_clk() has been moved to to acpi_amba_init()
  (Vladimir Zapolskiy)
- Return value has been fixed (Vladimir Zapolskiy)

v3:
https://lkml.kernel.org/g/1450716100-13688-1-git-send-email-aleksey.makarov at linaro.org
- Compilation without CONFIG_ARM_AMBA has been fixed

v2:
https://lkml.kernel.org/g/1450709399-7246-1-git-send-email-aleksey.makarov at linaro.org
- A new ACPI scan handler for AMBA devices has been implemented
- The order of `if` branches in amba-pl011.c has been changed
- A couple of `static`s have been added
- The compilation of the acpi_amba.c unit has made conditional
- A comment on SBSA UART has been added

v1:
https://lkml.kernel.org/g/1443609530-21524-1-git-send-email-graeme.gregory at linaro.org

Aleksey Makarov (1):
  ACPI: introduce a function to find the first physical device

Graeme Gregory (1):
  ACPI: amba bus probing support

 drivers/acpi/Makefile        |   1 +
 drivers/acpi/acpi_amba.c     | 122 +++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpi_platform.c |  19 +------
 drivers/acpi/bus.c           |  33 ++++++++----
 drivers/acpi/internal.h      |   6 +++
 drivers/acpi/scan.c          |   1 +
 6 files changed, 154 insertions(+), 28 deletions(-)
 create mode 100644 drivers/acpi/acpi_amba.c

-- 
2.7.0
