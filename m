From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  8 Jun 2015 17:16:57 +0100
Subject: [PATCH 0/2]  Add code to release secondary cores from holding pen.
Message-ID: <1433780219-1245-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This patchset adds in the necessary code to manage the holding pen for STi
platforms.

Due to all the STi upstream devs using JTAG to boot the STi boards, there
is currently a SMP bug when booting upstream kernels via u-boot where
only the primary core is brought up.

This hasn't been noticed until now because when booting via JTAG the
stlinux_arm_boot script sets the PC of the secondary cores directly.

I can't test this on a STiH418 platform, as I don't have one, but a similar
DT change will be required there as well. I'm not sure if u-boot uses
the same SBC DMEM offset by default or not.

With these patches applied booting via u-boot now works correctly.

[    0.045456] CPU: Testing write buffer coherency: ok
[    0.045597] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.045734] Setting up static identity map for 0x40209000 - 0x40209098
[    0.065047] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.065081] Brought up 2 CPUs
[    0.065089] SMP: Total of 2 processors activated (5983.43 BogoMIPS).
[    0.065092] CPU: All CPU(s) started in SVC mode.

IMHO these should be considered for the next -rc.

regards,

Peter.

Peter Griffin (2):
  ARM: STi: Add code to release secondary cores from holding pen.
  ARM: STi: DT: STiH407: Add cpu-release-addr dt property.

 arch/arm/boot/dts/stih407-family.dtsi |  4 +++
 arch/arm/mach-sti/headsmp.S           |  1 +
 arch/arm/mach-sti/platsmp.c           | 56 +++++++++++++++++++++++++++++++++--
 arch/arm/mach-sti/smp.h               |  2 ++
 4 files changed, 60 insertions(+), 3 deletions(-)

-- 
1.9.1
