From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Apr 2015 11:38:57 +0100
Subject: [GIT PULL] ACPI for arm64
Message-ID: <20150423103857.GC1652@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

ACPI for arm64 has been in development for a while now and hardware has
been available that can boot with either FDT or ACPI tables. This has
been made possible by both changes to the ACPI spec to cater for
ARM-based machines (known as "hardware-reduced" in ACPI parlance) but
also a Linaro-driven effort to get this supported on top of the Linux
kernel. This pull request is the result of that work.

These changes allow us to initialise the CPUs, interrupt controller, and
timers via ACPI tables, with memory information and cmdline coming from
EFI. We don't support a hybrid ACPI/FDT scheme. Of course, there is
still plenty of work to do (a serial console would be nice!) but I
expect that to happen on a per-driver basis after this core series has
been merged.

Anyway, the diff stat here is fairly horrible, but splitting this up and
merging it via all the different subsystems would have been extremely
painful. Instead, we've got all the relevant Acks in place and I've not
seen anything other than trivial (Kconfig) conflicts in -next (for
completeness, I've included my resolution below). Nearly half of the
insertions fall under Documentation/.

So, we'll see how this goes. Right now, it all depends on EXPERT and I
fully expect people to use FDT by default for the immediate future.

Please pull.

Thanks,

Will

--->8

diff --cc arch/arm64/Kconfig
index b8d96f1554af,0659db374731..baf212797d0e
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -1,7 -1,9 +1,9 @@@
  config ARM64
  	def_bool y
+ 	select ACPI_GENERIC_GSI if ACPI
+ 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 -	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 +	select ARCH_HAS_ELF_RANDOMIZE
  	select ARCH_HAS_GCOV_PROFILE_ALL
  	select ARCH_HAS_SG_CHAIN
  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --cc drivers/xen/Kconfig
index a270004c9605,a31cd29b68a8..7cd226da15fe
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@@ -270,10 -253,8 +270,14 @@@ config XEN_EF
  	def_bool y
  	depends on X86_64 && EFI
  
 +config XEN_AUTO_XLATE
 +	def_bool y
 +	depends on ARM || ARM64 || XEN_PVHVM
 +	help
 +	  Support for auto-translated physmap guests.
 +
+ config XEN_ACPI
+ 	def_bool y
+ 	depends on X86 && ACPI
+ 
  endmenu

--->8

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 7676fa70feb2f3bcdd4b854a553a57d8ef8505aa:

  ARM64 / ACPI: make acpi_map_gic_cpu_interface() as void function (2015-03-31 16:31:00 +0100)

----------------------------------------------------------------
Initial ACPI support for arm64:

This series introduces preliminary ACPI 5.1 support to the arm64 kernel
using the "hardware reduced" profile. We don't support any peripherals
yet, so it's fairly limited in scope:

- Memory init (UEFI)
- ACPI discovery (RSDP via UEFI)
- CPU init (FADT)
- GIC init (MADT)
- SMP boot (MADT + PSCI)
- ACPI Kconfig options (dependent on EXPERT)

----------------------------------------------------------------
Al Stone (4):
      ARM64 / ACPI: Get RSDP and ACPI boot-time tables
      ARM64 / ACPI: Introduce early_param "acpi=" to enable/disable ACPI
      ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64
      ARM64 / ACPI: additions of ACPI documentation for arm64

Catalin Marinas (1):
      ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID

Graeme Gregory (6):
      ACPI: add arm64 to the platforms that use ioremap
      ACPI / sleep: Introduce CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
      ARM64 / ACPI: If we chose to boot from acpi then disable FDT
      ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
      ARM64 / ACPI: Enable ARM64 in Kconfig
      Documentation: ACPI for ARM64

Hanjun Guo (11):
      ACPI / table: Use pr_debug() instead of pr_info() for MADT table scanning
      ARM64 / ACPI: Introduce PCI stub functions for ACPI
      ACPI / table: Print GIC information when MADT is parsed
      ARM64 / ACPI: Parse MADT for SMP initialization
      ACPI / processor: Make it possible to get CPU hardware ID via GICC
      ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and register device's gsi
      clocksource / arch_timer: Parse GTDT to initialize arch timer
      XEN / ACPI: Make XEN ACPI depend on X86
      ARM64 / ACPI: Don't unflatten device tree if acpi=force is passed
      ARM64 / ACPI: Ignore the return error value of acpi_map_gic_cpu_interface()
      ARM64 / ACPI: make acpi_map_gic_cpu_interface() as void function

Lorenzo Pieralisi (5):
      ACPI: move arm64 GSI IRQ model to generic GSI IRQ layer
      ARM64: kernel: psci: factor out probe function
      ARM64: kernel: psci: let ACPI probe PSCI version
      ARM64: kernel: acpi: refactor ACPI tables init and checks
      ARM64: kernel: acpi: honour acpi=force command line parameter

Mark Salter (2):
      ARM64: allow late use of early_ioremap
      ACPI: fix acpi_os_ioremap for arm64

Tomasz Nowicki (1):
      irqchip: Add GICv2 specific ACPI boot support

Will Deacon (1):
      ARM64 / ACPI: fix usage of acpi_map_gic_cpu_interface

 Documentation/arm64/acpi_object_usage.txt | 593 ++++++++++++++++++++++++++++++
 Documentation/arm64/arm-acpi.txt          | 505 +++++++++++++++++++++++++
 Documentation/kernel-parameters.txt       |   3 +-
 arch/arm64/Kconfig                        |   4 +
 arch/arm64/include/asm/acenv.h            |  18 +
 arch/arm64/include/asm/acpi.h             |  96 +++++
 arch/arm64/include/asm/cpu_ops.h          |   1 +
 arch/arm64/include/asm/fixmap.h           |   3 +
 arch/arm64/include/asm/irq.h              |  13 +
 arch/arm64/include/asm/pci.h              |   6 +
 arch/arm64/include/asm/psci.h             |   3 +-
 arch/arm64/include/asm/smp.h              |   5 +-
 arch/arm64/kernel/Makefile                |   1 +
 arch/arm64/kernel/acpi.c                  | 345 +++++++++++++++++
 arch/arm64/kernel/cpu_ops.c               |   2 +-
 arch/arm64/kernel/pci.c                   |  25 ++
 arch/arm64/kernel/psci.c                  | 112 ++++--
 arch/arm64/kernel/setup.c                 |  21 +-
 arch/arm64/kernel/smp.c                   |   2 +-
 arch/arm64/kernel/time.c                  |   7 +
 arch/ia64/Kconfig                         |   1 +
 arch/ia64/kernel/acpi.c                   |   2 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/kernel/acpi/boot.c               |   2 +-
 drivers/acpi/Kconfig                      |  10 +-
 drivers/acpi/Makefile                     |   3 +-
 drivers/acpi/acpi_processor.c             |   7 +-
 drivers/acpi/bus.c                        |   3 +
 drivers/acpi/gsi.c                        | 105 ++++++
 drivers/acpi/internal.h                   |   4 +
 drivers/acpi/osl.c                        |   6 +-
 drivers/acpi/processor_core.c             |  60 ++-
 drivers/acpi/tables.c                     |  52 ++-
 drivers/clocksource/arm_arch_timer.c      | 132 +++++--
 drivers/irqchip/irq-gic.c                 | 104 ++++++
 drivers/irqchip/irqchip.c                 |   3 +
 drivers/xen/Kconfig                       |   4 +
 drivers/xen/Makefile                      |   2 +-
 include/acpi/acpi_io.h                    |   4 +
 include/acpi/processor.h                  |   6 +-
 include/linux/acpi.h                      |   8 +-
 include/linux/acpi_irq.h                  |  10 +
 include/linux/clocksource.h               |   6 +
 include/linux/irqchip/arm-gic-acpi.h      |  31 ++
 44 files changed, 2216 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/arm64/acpi_object_usage.txt
 create mode 100644 Documentation/arm64/arm-acpi.txt
 create mode 100644 arch/arm64/include/asm/acenv.h
 create mode 100644 arch/arm64/include/asm/acpi.h
 create mode 100644 arch/arm64/kernel/acpi.c
 create mode 100644 drivers/acpi/gsi.c
 create mode 100644 include/linux/acpi_irq.h
 create mode 100644 include/linux/irqchip/arm-gic-acpi.h
