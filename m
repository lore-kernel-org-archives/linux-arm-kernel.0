From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 14:59:44 -0500
Subject: [GIT PULL 2/4] ARM: mvebu: boards for v3.9
Message-ID: <20130216195944.GI23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c7064904895f69b2e33117b450a05746f75abf3a:

  ARM: kirkwood: convert Guruplug Server Plus to use the device tree (2013-01-31 18:06:58 +0000) 

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards_for_v3.9_round2

for you to fetch changes up to 7649cca52a73c10712b033b4eba908c48d9c0bb7:
  
  arm: mvebu: update defconfig with ATAG support when using DT (2013-02-16 16:46:28 +0000)

----------------------------------------------------------------
mvebu boards for v3.9 round2

 - defconfig updates to mvebu
    - SPI, MTD, USB, local_timer, and ATAG->DT
 - new mvebu board DB-MV784MP-GP

Possibly controversial stuff:
 - mvebu local timer support
    - I first attempted to get this through the driver maintainer tree:

      http://www.spinics.net/lists/arm-kernel/msg221317.html

      on Jan 30th.  No response, so I decided to take the whole series through
      mvebu->arm-soc.

    - It turns out that this series depends on:

      16b30cf arm: mvebu: Improve the SMP support of the interrupt controller

      which had already been accepted and pushed into mvebu/boards.

    - So, with the above, I decided the easiest way to merge this series
      in while avoiding circular dependencies (eg by putting in it's proper
      place, mvebu/drivers) was to merge them in to mvebu/boards.  The only
      alternative to this I can think of is to hold off till v3.10, but
      this seemed a little drastic for such a small series.

** From previous tag boards_for_v3.9, no new depends **
depends on:
 - tags/mvebu_fixes_for_v3.8-rc6
 - tags/cleanup_for_v3.9_round2
 - tags/drivers_for_v3.9
 - mmc/mmc-next up to:
    d293875 mmc: mvsdio: add pinctrl integration

conflicts:
 - arm-soc/for-next
    - arch/arm/mach-dove/common.c
       * remove all DT code (it's now in .../board-dt.c)

build fixes (not merge conflict)
 - arm-soc/for-next
    - arch/arm/mach-dove/board-dt.c
       - .timer no longer used
       * s/.timer = &dove_timer/.init_time = dove_timer_init/ (not valid sed)

----------------------------------------------------------------
Ezequiel Garcia (3):
      arm: mvebu: Update defconfig to select USB support
      ARM: mvebu: Update defconfig to select SPI support
      ARM: mvebu: Update defconfig to select SPI flash and MTD support

Gregory CLEMENT (5):
      arm: mvebu: Add support for local interrupt
      clocksource: time-armada-370-xp: add local timer support
      arm: mvebu: update defconfig with local timer support
      arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)
      arm: mvebu: update defconfig with ATAG support when using DT

 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/armada-xp-gp.dts       | 101 +++++++++++++++++++++
 arch/arm/configs/mvebu_defconfig         |  12 ++-
 arch/arm/mach-mvebu/irq-armada-370-xp.c  |  15 +++-
 drivers/clocksource/time-armada-370-xp.c | 150 +++++++++++++++++++++++--------
 5 files changed, 235 insertions(+), 44 deletions(-)
