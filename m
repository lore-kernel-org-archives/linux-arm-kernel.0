From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue, 24 May 2016 21:30:27 +0800
Subject: [PATCH v5 0/6] acpi,
 clocksource: add GTDT driver and GTDT support in arm_arch_timer
Message-ID: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Preparation for adding GTDT support in arm_arch_timer
        1. Move some enums and marcos to header file
        2. Add a new enum for spi type.
        3. Improve printk relevant code

    (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
    Parse all kinds of timer in GTDT table of ACPI:arch timer,
    memory-mapped timer and SBSA Generic Watchdog timer.
    This driver can help to simplify all the relevant timer drivers,
    and separate all the ACPI GTDT knowledge from them.

    (3)Simplify ACPI code for arm_arch_timer

    (4)Add GTDT support for ARM memory-mapped timer

This patchset has been tested on the following platforms:
    (1)ARM Foundation v8 model

Changelog:
v5: Sorting out all patches, simplify the API of GTDT driver:
    GTDT driver just fills the data struct for arm_arch_timer driver.

v4: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006667.html
    Delete the kvm relevant patches
    Separate two patches for sorting out the code for arm_arch_timer.
    Improve irq info export code to allow missing irq info in GTDT table.

v3: https://lkml.org/lkml/2016/2/1/658
    Improve GTDT driver code:
      (1)improve pr_* by defining pr_fmt(fmt)
      (2)simplify gtdt_sbsa_gwdt_init
      (3)improve gtdt_arch_timer_data_init, if table is NULL, it will try
      to get GTDT table.
    Move enum ppi_nr to arm_arch_timer.h, and add enum spi_nr.
    Add arm_arch_timer get ppi from DT and GTDT support for kvm.

v2: https://lkml.org/lkml/2015/12/2/10
    Rebase to latest kernel version(4.4-rc3).
    Fix the bug about the config problem,
    use CONFIG_ACPI_GTDT instead of CONFIG_ACPI in arm_arch_timer.c

v1: The first upstreaming version: https://lkml.org/lkml/2015/10/28/553


Fu Wei (6):
  clocksource/drivers/arm_arch_timer: Move enums and defines to header
    file
  clocksource/drivers/arm_arch_timer: Add a new enum for spi type
  clocksource/drivers/arm_arch_timer: Improve printk relevant code
  acpi: Add GTDT table parse driver into ACPI driver
  clocksource/drivers/arm_arch_timer: Simplify ACPI support code.
  clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped
    timer

 drivers/acpi/Kconfig                 |   9 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/acpi_gtdt.c             | 309 +++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig          |   1 +
 drivers/clocksource/arm_arch_timer.c | 233 ++++++++++++++++++--------
 include/clocksource/arm_arch_timer.h |  33 ++++
 include/linux/acpi.h                 |   6 +
 7 files changed, 522 insertions(+), 70 deletions(-)
 create mode 100644 drivers/acpi/acpi_gtdt.c

-- 
2.5.5
