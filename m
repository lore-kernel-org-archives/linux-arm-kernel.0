From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Aug 2015 14:56:52 -0500
Subject: [PATCH-next 0/4] arm: am437x: use TWD/Global timers
Message-ID: <1439409416-32673-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

with these patches AM437x devices can use TWD/global timers.

At least TWD is now used as sched_clock() which gives better latency as seen
below. Keep in mind that while I ran cyclictest to have a feel for avg latency
this test was not against an RT kernel, so results should be taken with a
grain of salt.

Also, I'm not 100% sure clock rate is correct. According to TRM, this timer
should run as MPU_CLK/2 which would be 1GHz / 2 = 500MHz, but even though
I'm using dpll_mpu_m2_ck clock, it still shows as 1000MHz.

Are there any other tests I could/should run ? BTW, I boot-tested on AM4372
with and without 'nosmp' on cmdline.

pre-patch:
T: 0 (  245) P:95 I:1000 C:   9995 Min:     24 Act:   31 Avg:   36 Max:     596

post-patch:
T: 0 (  253) P:95 I:1000 C:   9995 Min:     10 Act:   12 Avg:   14 Max:      68


Changes since v1:
	- Rebased on top of today's linux-next (c1a0c66f231d Add linux-next
	  specific files for 20150812)

Felipe Balbi (4):
  Revert "ARM: 7655/1: smp_twd: make twd_local_timer_of_register() no-op
    for nosmp"
  arm: boot: dts: am4372: add ARM timers and SCU nodes
  arm: omap2: Kconfig: select TWD and global timer on AM43xx devices
  arm: omap2: board-generic: use omap4_local_timer_init for AM437x

 arch/arm/boot/dts/am4372.dtsi       | 21 +++++++++++++++++++++
 arch/arm/kernel/smp_twd.c           |  4 ----
 arch/arm/mach-omap2/Kconfig         |  3 +++
 arch/arm/mach-omap2/board-generic.c |  2 +-
 4 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.5.0
