From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:14:59 -0700
Subject: [PATCH 00/34] Convert clk providers to clk_hw based APIs (part 1)
Message-ID: <20160601231533.9354-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an initial set of patches to convert clk provider
drivers over to the clk_hw based approach of registering clks.
The foundational part of that has merged into v4.7-rc1 (see commit
58657d189a2f and it's children for details), so this series updates
some drivers for the new registration style. Not all drivers are
converted because this takes quite some time, but this should be
a good chunk of it.

Stephen Boyd (34):
  clk: qcom: Migrate to clk_hw based registration and OF APIs
  clk: at91: Migrate to clk_hw based registration and OF APIs
  clk: highbank: Migrate to clk_hw based registration and OF APIs
  clk: bcm2835: Migrate to clk_hw based registration and OF APIs
  clk: bcm: iproc: Migrate to clk_hw based registration and OF APIs
  clk: bcm: kona: Migrate to clk_hw based registration and OF APIs
  clk: berlin: Migrate to clk_hw based registration and OF APIs
  clk: asm9260: Migrate to clk_hw based registration and OF APIs
  clk: axi-clkgen: Migrate to clk_hw based OF and registration APIs
  clk: axm5516: Migrate to clk_hw based OF and registration APIs
  clk: cdce: Migrate to clk_hw based OF and registration APIs
  clk: cdce925: Migrate to clk_hw based OF and provider APIs
  clk: clps711x: Migrate to clk_hw based OF and registration APIs
  clk: cs2000: Migrate to clk_hw based OF and registration APIs
  clk: efm32gg: Migrate to clk_hw based OF and registration APIs
  clk: ls1x: Migrate to clk_hw based OF and registration APIs
  clk: maxgen: Migrate to clk_hw based OF and registration APIs
  clk: mb86s7x: Migrate to clk_hw based OF and registration APIs
  clk: moxart: Migrate to clk_hw based OF and registration APIs
  clk: nomadik: Migrate to clk_hw based OF and registration APIs
  clk: nspire: Migrate to clk_hw based OF and registration APIs
  clk: palmas: Migrate to clk_hw based OF and registration APIs
  clk: pwm: Migrate to clk_hw based OF and registration APIs
  clk: rk808: Migrate to clk_hw based OF and registration APIs
  clk: s2mps11: Migrate to clk_hw based OF and registration APIs
  clk: scpi: Migrate to clk_hw based OF and registration APIs
  clk: si514: Migrate to clk_hw based OF and registration APIs
  clk: si5351: Migrate to clk_hw based OF and registration APIs
  clk: si570: Migrate to clk_hw based OF and registration APIs
  clk: stm32f3: Migrate to clk_hw based OF and registration APIs
  clk: twl6040: Migrate to clk_hw based registration APIs
  clk: u300: Migrate to clk_hw based registration APIs
  clk: vt8500: Migrate to clk_hw based registration APIs
  clk: wm831x: Migrate to clk_hw based registration APIs

 drivers/clk/at91/clk-generated.c    | 30 +++++++-----
 drivers/clk/at91/clk-h32mx.c        |  8 +--
 drivers/clk/at91/clk-main.c         | 88 +++++++++++++++++++--------------
 drivers/clk/at91/clk-master.c       | 21 ++++----
 drivers/clk/at91/clk-peripheral.c   | 39 +++++++++------
 drivers/clk/at91/clk-pll.c          | 21 ++++----
 drivers/clk/at91/clk-plldiv.c       | 24 ++++-----
 drivers/clk/at91/clk-programmable.c | 22 +++++----
 drivers/clk/at91/clk-slow.c         | 88 +++++++++++++++++++--------------
 drivers/clk/at91/clk-smd.c          | 22 +++++----
 drivers/clk/at91/clk-system.c       | 22 +++++----
 drivers/clk/at91/clk-usb.c          | 69 +++++++++++++++-----------
 drivers/clk/at91/clk-utmi.c         | 22 +++++----
 drivers/clk/bcm/clk-bcm2835-aux.c   | 28 +++++------
 drivers/clk/bcm/clk-bcm2835.c       | 83 +++++++++++++++++--------------
 drivers/clk/bcm/clk-iproc-armpll.c  |  9 ++--
 drivers/clk/bcm/clk-iproc-asiu.c    | 27 +++++-----
 drivers/clk/bcm/clk-iproc-pll.c     | 32 ++++++------
 drivers/clk/bcm/clk-kona-setup.c    | 76 +++++++++++++---------------
 drivers/clk/bcm/clk-kona.c          |  9 ++--
 drivers/clk/bcm/clk-kona.h          |  7 +--
 drivers/clk/berlin/berlin2-avpll.c  | 12 ++---
 drivers/clk/berlin/berlin2-avpll.h  |  8 +--
 drivers/clk/berlin/berlin2-div.c    |  4 +-
 drivers/clk/berlin/berlin2-div.h    |  4 +-
 drivers/clk/berlin/berlin2-pll.c    |  6 +--
 drivers/clk/berlin/berlin2-pll.h    |  5 +-
 drivers/clk/berlin/bg2.c            | 98 ++++++++++++++++++++-----------------
 drivers/clk/berlin/bg2q.c           | 39 ++++++++-------
 drivers/clk/clk-asm9260.c           | 31 +++++++-----
 drivers/clk/clk-axi-clkgen.c        | 12 ++---
 drivers/clk/clk-axm5516.c           | 39 +++++++--------
 drivers/clk/clk-cdce706.c           | 40 ++++++++-------
 drivers/clk/clk-cdce925.c           | 42 +++++++++-------
 drivers/clk/clk-clps711x.c          | 78 ++++++++++++++---------------
 drivers/clk/clk-cs2000-cp.c         | 16 +++---
 drivers/clk/clk-efm32gg.c           | 63 +++++++++++++-----------
 drivers/clk/clk-highbank.c          |  9 ++--
 drivers/clk/clk-ls1x.c              | 69 +++++++++++++-------------
 drivers/clk/clk-max-gen.c           | 64 ++++++++++++------------
 drivers/clk/clk-mb86s7x.c           | 16 +++---
 drivers/clk/clk-moxart.c            | 22 +++++----
 drivers/clk/clk-nomadik.c           | 48 +++++++++---------
 drivers/clk/clk-nspire.c            | 19 +++----
 drivers/clk/clk-palmas.c            | 12 ++---
 drivers/clk/clk-pwm.c               |  9 ++--
 drivers/clk/clk-rk808.c             | 42 ++++++++--------
 drivers/clk/clk-s2mps11.c           | 21 ++++----
 drivers/clk/clk-scpi.c              | 33 ++++++-------
 drivers/clk/clk-si514.c             | 11 ++---
 drivers/clk/clk-si5351.c            | 71 +++++++++++++++------------
 drivers/clk/clk-si570.c             | 13 +++--
 drivers/clk/clk-stm32f4.c           | 12 ++---
 drivers/clk/clk-twl6040.c           |  8 +--
 drivers/clk/clk-u300.c              | 59 ++++++++++++----------
 drivers/clk/clk-vt8500.c            | 22 +++++----
 drivers/clk/clk-wm831x.c            | 21 ++++----
 drivers/clk/qcom/clk-regmap.c       |  5 +-
 drivers/clk/qcom/clk-regmap.h       |  3 +-
 drivers/clk/qcom/common.c           | 58 ++++++++++++----------
 drivers/clk/qcom/gcc-msm8996.c      |  9 ++--
 drivers/clk/qcom/mmcc-msm8996.c     |  9 ++--
 62 files changed, 1004 insertions(+), 905 deletions(-)

-- 
2.7.4
