From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jan 2015 10:13:00 +0100
Subject: [PATCH V4 0/4] mmc: core: Add support for MMC power sequences
Message-ID: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
	- Fixed call to kfree() in patch3 and patch4.

Changes in v3:
	Fixed comments from Mark Rutland:
	- Document binding in one patch to get the big picture.
	- Keep code and DT document consistent around how many GPIO resets we
	  support. I decided to go for one GPIO, we can extend that if needed
	  later on.
	- Change compatible string for simple MMC power sequence and renamed the
	  file for its documentation.
	- Updated commit messages according to above changes.

Changes in v2:
	Fixed comments from Russell King:
	- Renamed pwrseq callbacks and corresponding interface functions.
	- Move the call to the previous namned ->power_on() callback, to the
	  end of mmc_power_up() to get consistent behavior.


This is yet another try to solve the issues of dealing with power sequences for
the MMC subsystem. The latest attempt, see link below, took a generic approach
by adding a new top level driver layer. That's was rejected by several reasons.
http://lwn.net/Articles/602855/

This time the approach is focused to fix the issues for MMC only.

To give a short background, SOCs may specify a specific MMC power sequence. To
successfully detect an (e)MMC/SD/SDIO card, that power sequence must be followed
while initializing the card.

To be able to handle these SOC specific power sequences, we add a MMC power
sequence interface, which helps the mmc core to deal with such.

A MMC power sequence provider then implements a set of callbacks from the above
mentioned interface. The provider has a corresponding DT compatibility string
and relies on CONFIG_OF to be set to find it's various resourses, like for
example a GPIO reset.

The mmc core will from mmc_of_parse() try find a "mmc-pwrseq" DT node and then
call the corresponding MMC power sequence provider's initialization function.


Ulf Hansson (4):
  mmc: core: Initial support for MMC power sequences
  mmc: pwrseq: Document DT bindings for the simple MMC power sequence
  mmc: pwrseq: Initial support for the simple MMC power sequence
    provider
  mmc: pwrseq_simple: Add support for a reset GPIO pin

 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  20 ++++
 Documentation/devicetree/bindings/mmc/mmc.txt      |  14 +++
 drivers/mmc/core/Makefile                          |   2 +-
 drivers/mmc/core/core.c                            |   7 ++
 drivers/mmc/core/host.c                            |   4 +-
 drivers/mmc/core/pwrseq.c                          | 109 +++++++++++++++++++++
 drivers/mmc/core/pwrseq.h                          |  42 ++++++++
 drivers/mmc/core/pwrseq_simple.c                   |  86 ++++++++++++++++
 include/linux/mmc/host.h                           |   2 +
 9 files changed, 284 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
 create mode 100644 drivers/mmc/core/pwrseq.c
 create mode 100644 drivers/mmc/core/pwrseq.h
 create mode 100644 drivers/mmc/core/pwrseq_simple.c

-- 
1.9.1
