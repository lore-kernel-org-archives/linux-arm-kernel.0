From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue,  2 Feb 2016 04:26:52 +0800
Subject: [PATCH v3 0/6] acpi, clocksource,
 kvm: add GTDT and ARM memory-mapped timer support
Message-ID: <1454358418-5157-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
    Parse all kinds of timer in GTDT table of ACPI:arch timer,
    memory-mapped timer and SBSA Generic Watchdog timer.
    This driver can help to simplify all the relevant timer drivers,
    and separate all the ACPI GTDT knowledge from them.

    (2)Simplify ACPI code for arch timer in arm_arch_timer.c

    (3)Add memory-mapped timer support in arm_arch_timer.c

    (4)Add arm_arch_timer get ppi from DT and GTDT support for kvm
    in virt/kvm/arm/arch_timer.c

Changelog:
v3: Improve GTDT driver code:
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

Fu Wei (5):
  ACPI: add GTDT table parse driver into ACPI driver
  clocksource: simplify ACPI code in arm_arch_timer.c
  clocksource: add memory-mapped timer support in arm_arch_timer.c
  clocksource: move some enums to arm_arch_timer.h
  kvm: arm64: Add ACPI support for virt arch timer

Wei Huang (1):
  kvm: arm64: wrapping DT support for virt arch timer

 drivers/acpi/Kconfig                 |   9 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/gtdt.c                  | 375 +++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig          |   1 +
 drivers/clocksource/arm_arch_timer.c | 191 +++++++++++++-----
 include/clocksource/arm_arch_timer.h |  33 +++
 include/linux/acpi.h                 |  17 ++
 virt/kvm/arm/arch_timer.c            |  57 ++++--
 8 files changed, 620 insertions(+), 64 deletions(-)
 create mode 100644 drivers/acpi/gtdt.c

-- 
2.5.0
