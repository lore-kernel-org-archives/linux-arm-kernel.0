From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  9 Jun 2015 14:33:41 +0100
Subject: [PATCH v2 0/3] Add code to release secondary cores from holding pen.
Message-ID: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, Patrice, Srini, Kevin, Olof & Arnd,

This patchset adds in the necessary code to manage the holding pen for STi
platforms.

Due to all the STi upstream devs using JTAG to boot the STi boards, there
is currently a SMP bug when booting upstream kernels via u-boot where
only the primary core is brought up.

This hasn't been noticed until now because when booting via JTAG the
stlinux_arm_boot script sets the PC of the secondary cores directly.

With these patches applied booting via u-boot now works correctly.

[    0.045456] CPU: Testing write buffer coherency: ok
[    0.045597] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.045734] Setting up static identity map for 0x40209000 - 0x40209098
[    0.065047] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.065081] Brought up 2 CPUs
[    0.065089] SMP: Total of 2 processors activated (5983.43 BogoMIPS).
[    0.065092] CPU: All CPU(s) started in SVC mode.

Kevin / Olof / Arnd - Can you put this fix into the next ARM SoC fixes pull
request (if there is one)?

regards,

Peter.

Changes since v1:
 - Add STiH418 cpu-release-addr property (Max)
 - Remove trailing '\n' (Max)
 - Add Maximes Acks (Max)

Peter Griffin (3):
  ARM: STi: Add code to release secondary cores from holding pen.
  ARM: STi: DT: STiH407: Add cpu-release-addr dt property.
  ARM: STi: DT: STiH418: Add cpu-release-addr dt property.

 arch/arm/boot/dts/stih407-family.dtsi |  4 +++
 arch/arm/boot/dts/stih418.dtsi        |  4 +++
 arch/arm/mach-sti/headsmp.S           |  1 +
 arch/arm/mach-sti/platsmp.c           | 55 +++++++++++++++++++++++++++++++++--
 arch/arm/mach-sti/smp.h               |  2 ++
 5 files changed, 63 insertions(+), 3 deletions(-)

-- 
1.9.1
