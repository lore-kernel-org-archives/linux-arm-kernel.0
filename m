From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 22 Nov 2014 22:08:44 +0100
Subject: [GIT PULL] temporarily disable rk3288-smp
Message-ID: <13624879.qYkvC9sWa4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

it looks like not all bootloaders like the recently introduced
rk3288-smp-support. Uninitialized CNTVOFF registers of the
architected timer produce rcu stalls on some boards.

Both Olof and Kevin were affected by this. On Kevin's board
we could simply upgrade u-boot to a version behaving correctly
while Olof's board uses coreboot where no fix for this exists
currently. Also as far as I know Olof's board is the only one
in circulation using coreboot, but it would still be nice to keep
the boot tests working for the time being.

There exist an alternative approach for solving issues like this
consisting of
- clocksource: arch_timer: Fix code to use physical timers when requested [0]
- clocksource: arch_timer: Allow the device tree to specify uninitialized timer registers [1]


So to keep Olof's boottests working, disable the rk3288-smp until this
gets sorted. Interested parties with a working bootloader can of course
always simply re-insert the enable-method to have working smp.


[0] https://patchwork.kernel.org/patch/5051901/
[1] https://patchwork.kernel.org/patch/5051881/


The following changes since commit efb66e93d13da5a7b11b3a8dbb24a6fb29141752:

  ARM: dts: rockchip: enable PWM on Radxa Rock (2014-11-15 21:16:30 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-dts3

for you to fetch changes up to b77d43943ea83997c6c37b8831d1561981d499c5:

  ARM: dts: rockchip: temporarily disable smp on rk3288 (2014-11-22 16:23:28 +0100)

----------------------------------------------------------------
Disable smp again on rk3288 temporarily to make Olof's boottest
run again, until the patches for using the physical architected
timers got accepted.

----------------------------------------------------------------
Heiko Stuebner (1):
      ARM: dts: rockchip: temporarily disable smp on rk3288

 arch/arm/boot/dts/rk3288.dtsi | 1 -
 1 file changed, 1 deletion(-)
