From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Fri, 18 Mar 2016 16:00:48 +0800
Subject: [RESEND PATCH v4 0/5] acpi,
 clocksource: add GTDT and ARM memory-mapped timer support
Message-ID: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Move some enums and marcos to header file for arm_arch_timer,
    improve the pr_* code by defining "pr_fmt(fmt)" in arm_arch_timer.c

    (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
    Parse all kinds of timer in GTDT table of ACPI:arch timer,
    memory-mapped timer and SBSA Generic Watchdog timer.
    This driver can help to simplify all the relevant timer drivers,
    and separate all the ACPI GTDT knowledge from them.

    (3)Simplify ACPI code for arch timer in arm_arch_timer.c

    (4)Add memory-mapped timer support in arm_arch_timer.c

RESEND:
   -- Corrected Cc list: added missing mailing lists

Changelog:
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

Fu Wei (5):
  clocksource: move some enums and marcos to header file for
    arm_arch_timer
  ACPI: add GTDT table parse driver into ACPI driver
  clocksource: simplify ACPI code in arm_arch_timer.c
  clocksource: a little improvment for printk in arm_arch_timer.c
  clocksource: add memory-mapped timer support in arm_arch_timer.c

 drivers/acpi/Kconfig                 |   9 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/gtdt.c                  | 376 +++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig          |   1 +
 drivers/clocksource/arm_arch_timer.c | 217 ++++++++++++++------
 include/clocksource/arm_arch_timer.h |  33 +++
 include/linux/acpi.h                 |  17 ++
 7 files changed, 595 insertions(+), 59 deletions(-)
 create mode 100644 drivers/acpi/gtdt.c

-- 
2.5.0
