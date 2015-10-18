From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 18 Oct 2015 14:20:17 +0200
Subject: [resend GIT PULL] ARM: mediatek: soc updates for v4.3
Message-ID: <CABuKBeJUgmaswptkh1MdFfLyL0Yir7Umf=KQ3kW3B2A_=SU+0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following patches.

I resend this pull request, because I forgot to add the arm mailing
list in the first place.

Thanks,
Matthias

---

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.3-next-soc

for you to fetch changes up to 0cda07001a9454f371b7a7edabad55d99ef91157:

  ARM: mediatek: add smp bringup code (2015-10-14 15:34:44 +0200)

----------------------------------------------------------------
Do the initial setting of the pmic wrap interrupt before requesting
the interrupt.
This fixes the corner-case where the pmic is initialized by the bootloader, but
not the pmic watchdog.

Add support for active wakeup to the scpsys. This allows to keep the power of
a scpsys domain  during suspend state.

With version v4.3 new subsystem clocks are added to the clock dirver. In late
init the kernel turns off all unused clocks. This can provoke a hang if
the kernel tries to access the venc and venc_lt power domain registers.
Add the necessary parent clocks for this power domains to
the scpsys so that no random hang happens.

The bootloader of mt6589, mt8135 and mt1827 does not turn on the arm-arch-timer.
As there is no opensource bootloader in the near future for this architectures
we enable the arch timer at kernel boot. We need the arch timer for SMP boot.

Add support for SMP on mt6589, mt8127 and mt8135.

----------------------------------------------------------------
Eddie Huang (1):
      soc: mediatek: add scpsys support active_wakeup

Henry Chen (1):
      soc: mediatek: Move the initial setting of pmic wrap interrupt
before requesting irq.

James Liao (1):
      soc: mediatek: Fix random hang up issue while kernel init

Matthias Brugger (1):
      ARM: mediatek: enable gpt6 on boot up to make arch timer working

Yingjoe Chen (1):
      ARM: mediatek: add smp bringup code

 arch/arm/mach-mediatek/Makefile      |   3 +
 arch/arm/mach-mediatek/mediatek.c    |  27 +++++++
 arch/arm/mach-mediatek/platsmp.c     | 141 +++++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pmic-wrap.c |  10 ++-
 drivers/soc/mediatek/mtk-scpsys.c    |  83 +++++++++++++++------
 5 files changed, 237 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/mach-mediatek/platsmp.c
