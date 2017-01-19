From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 19 Jan 2017 19:46:42 +0800
Subject: [PATCH RESEND v8 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
Message-ID: <1484826406-16348-1-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erratum Hisilicon-161010101 says that the ARM generic timer counter "has the
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

v5: Adapt the new kernel-parameters.txt for latest kernel version.
    Set the retries of reread system counter to 50, because it is possible 
    that some interrupts may lead to more than twice read errors and break the loop,
    it will trigger the warning, so we set the number of retries far beyond the number of
    iterations the loop has been observed to take.

v6: The last 2 patches in the previous version about the ACPI mode will conflict witch Fuwei's
    GTDT patches, so remove the ACPI part and only support the DT base code for this patch set.

    We have trigger a bug when select the CONFIG_FUNCTION_GRAPH_TRACER and enable function_graph
    to /sys/kernel/debug/tracing/current_tracer, the system will stall into an endless loop, it looks
    like that the ftrace_graph_caller will be related to xxx.read_cntvct_el0 and read the system counter
    again, so mark the xxx.read_cntvct_el0 with notrace to fix the problem.

v7: Introduce a new general config symbol named CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND to enable the workaround
    for any chips which has similar arch timer erratum just like "fsl,erratum_a008585" and "hisilicon,erratum_161601",
    modify the struct arch_timer_erratum_workaround to be compatible different chip erratum more easily, and
    reconstruction some code base on the new config symbol and struct, thanks to Marc's suggestion. 

v8: The original erratum ID could not cover all modules, which only specified <Errata-Prefix><SerialNum>, so after
    discussion with the soc team, we decide to use the new ID "161010101" for this timer erratum which consist of
    <Errata-Prefix><SeriesFlag><ModuleID><SerialNum> and also update the hisilicon erratum official documents.

Ding Tianhong (4):
  arm64: arch_timer: Add device tree binding for hisilicon-161010101
    erratum
  arm64: arch_timer: Introduce a generic erratum handing mechanism for
    fsl-a008585
  arm64: arch_timer: Work around Erratum Hisilicon-161010101
  arm64: arch timer: Add timer erratum property for Hip05-d02 and
    Hip06-d03

 Documentation/admin-guide/kernel-parameters.txt    |   9 --
 Documentation/arm64/silicon-errata.txt             |  43 +++---
 .../devicetree/bindings/arm/arch_timer.txt         |   8 ++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   1 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |   1 +
 arch/arm64/include/asm/arch_timer.h                |  38 ++----
 drivers/clocksource/Kconfig                        |  18 +++
 drivers/clocksource/arm_arch_timer.c               | 150 +++++++++++++++------
 8 files changed, 173 insertions(+), 95 deletions(-)

-- 
1.9.0
