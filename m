From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:19:14 +0800
Subject: [PATCH v3 0/9] ARM: PRIMA2: bringup new CSR SiRFmarco SMP SoC
Message-ID: <1358857154-9915-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change list:
-v3:
handle feedbacks from Mark Rutland, thanks, Mark!
1. cleanup marco.dtsi and marco-evb.dts according to Mark Rutland's feedback
  - "sirf,marco-cb" come before "sirf,marco"; both compatible strings were
    documented
  - change lcd0 at N to lcd0_N -- ePAPR says the unit-address should match the
    reg property, and if there's no reg property the unit-address must be
    omitted.
  - and so on
2. used designated initializers and delete magic number in l2x0.c
3. Runaway commit message for "enable AUTO_ZRELADDR for SIRF in Kconfig"
4. use arm_dt_init_cpu_maps to get cpu mapping instead of reading scu
5. delete some repeated codes for timer0 and timer1 of marco

-v2:
1. cleanup marco.dtsi according to Mark Rutland's feedback
2. use of_device_id::data to handle the difference of l2x0 aux setting
   according to Mark Rutland's feedback
3. rebase to the newest timer/cleanup branch, removing sys_timer

-v1:
1. Marco has different OS timer hardware with Prima2, so add a new timer-marco
2. add platsmp.c, headsmp.S and hotplug.c for MPcore support
3. some hardwares have changed, like rstc, so use of_compatible to branch Prima2
   and Marco
4. add initial .dtsi for Marco SoC and initial .dts for the EVB
5. use GIC for Marco instead of Prima2's IRQ controller
6. add DEBUG_LL uart ports for Prima2 and Marco debug ports

Barry Song (9):
  ARM: PRIMA2: add CSR SiRFmarco device tree .dts
  ARM: PRIMA2: enable AUTO_ZRELADDR for SIRF in Kconfig
  ARM: PRIMA2: initialize l2x0 according to mach from DT
  ARM: PRIMA2: mv timer to timer-prima2 as we will add timer-marco
  ARM: PRIMA2: rstc: enable the support for Marco
  ARM: PRIMA2: rtciobg: it is also compatible with marco
  ARM: PRIMA2: irq: make prima2 irq can work even we enable GIC for
    Marco
  ARM: PRIMA2: add new SiRFmarco SMP SoC infrastructures
  ARM: PRIMA2: provide two DEBUG_LL ports for prima2 and marco

 Documentation/devicetree/bindings/arm/sirf.txt   |   10 +-
 arch/arm/Kconfig                                 |    1 +
 arch/arm/Kconfig.debug                           |   14 +
 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/marco-evb.dts                  |   54 ++
 arch/arm/boot/dts/marco.dtsi                     |  756 ++++++++++++++++++++++
 arch/arm/configs/prima2_defconfig                |    3 +
 arch/arm/mach-prima2/Kconfig                     |   10 +
 arch/arm/mach-prima2/Makefile                    |    5 +-
 arch/arm/mach-prima2/common.c                    |   45 ++-
 arch/arm/mach-prima2/common.h                    |   15 +-
 arch/arm/mach-prima2/headsmp.S                   |   79 +++
 arch/arm/mach-prima2/hotplug.c                   |   41 ++
 arch/arm/mach-prima2/include/mach/irqs.h         |    4 +-
 arch/arm/mach-prima2/include/mach/uart.h         |    6 +
 arch/arm/mach-prima2/include/mach/uncompress.h   |    3 +
 arch/arm/mach-prima2/irq.c                       |   16 +-
 arch/arm/mach-prima2/l2x0.c                      |   29 +-
 arch/arm/mach-prima2/platsmp.c                   |  163 +++++
 arch/arm/mach-prima2/rstc.c                      |   45 +-
 arch/arm/mach-prima2/rtciobrg.c                  |    1 +
 arch/arm/mach-prima2/timer-marco.c               |  316 +++++++++
 arch/arm/mach-prima2/{timer.c => timer-prima2.c} |    6 +-
 23 files changed, 1588 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/boot/dts/marco-evb.dts
 create mode 100644 arch/arm/boot/dts/marco.dtsi
 create mode 100644 arch/arm/mach-prima2/headsmp.S
 create mode 100644 arch/arm/mach-prima2/hotplug.c
 create mode 100644 arch/arm/mach-prima2/platsmp.c
 create mode 100644 arch/arm/mach-prima2/timer-marco.c
 rename arch/arm/mach-prima2/{timer.c => timer-prima2.c} (98%)

-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
