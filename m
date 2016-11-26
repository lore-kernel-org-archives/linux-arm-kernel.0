From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 26 Nov 2016 16:00:42 +0800
Subject: [PATCH v4 0/6] arm64: arch_timer: Add workaround for hisilicon-161601
 erratum
Message-ID: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erratum Hisilicon-161601 says that the ARM generic timer counter "has the
potential to contain an erroneous value when the timer value changes".
Accesses to TVAL (both read and write) are also affected due to the implicit counter
read.  Accesses to CVAL are not affected.

The workaround is to reread the system count registers until the value of the second
read is larger than the first one by less than 32, the system counter can be guaranteed
not to return wrong value twice by back-to-back read and the error value is always larger
than the correct one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.

v2: Introducing a new generic erratum handling mechanism for fsl,a008585 and hisilicon,161601.
    Significant rework based on feedback, including seperate the fsl erratum a008585
    to another patch, update the erratum name and remove unwanted code.

v3: Introducing the erratum_workaround_set_sne generic function for fsl erratum a008585
    and make the #define __fsl_a008585_read_reg to be private to the .c file instead of
    being globally visible. After discussion with Marc and Will, a consensus decision was
    made to remove the commandline parameter for enabling fsl,erratum-a008585 erratum,
    and make some generic name more specific, export timer_unstable_counter_workaround
    for module access.
    
    Significant rework based on feedback, including fix some alignment problem, make the
    #define __hisi_161601_read_reg to be private to the .c file instead of being globally
    visible, add more accurate annotation and modify a bit of logical format to enable
    arch_timer_read_ool_enabled, remove the kernel commandline parameter
    clocksource.arm_arch_timer.hisilicon-161601.

    Introduce a generic aquick framework for erratum in ACPI mode.

v4: rename the quirk handler parameter to make it more generic, and
    avoid break loop when handling the quirk becasue it need to
    support multi quirks handler.

    update some data structures for acpi mode. 

Ding Tianhong (4):
  arm64: arch_timer: Add device tree binding for hisilicon-161601
    erratum
  arm64: arch_timer: Introduce a generic erratum handing mechanism for
    fsl-a008585
  arm64: arch_timer: Work around Erratum Hisilicon-161601
  arm64: arch timer: Add timer erratum property for Hip05-d02 and
    Hip06-d03

Hanjun Guo (2):
  arm64: arch_timer: apci: Introduce a generic aquirk framework for
    erratum
  arm64: arch_timer: acpi: add hisi timer errata data

 Documentation/arm64/silicon-errata.txt             |   1 +
 .../devicetree/bindings/arm/arch_timer.txt         |   8 +
 Documentation/kernel-parameters.txt                |   9 -
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   1 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |   1 +
 arch/arm64/include/asm/arch_timer.h                |  38 ++--
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/arm_arch_timer.c               | 197 +++++++++++++++++----
 8 files changed, 194 insertions(+), 70 deletions(-)

-- 
1.9.0
