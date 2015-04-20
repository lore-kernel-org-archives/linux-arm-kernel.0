From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 20 Apr 2015 16:02:30 +0200
Subject: [PATCH 0/3] ARM: ux500: Fix SD-card regression by using GPIO regulator
Message-ID: <1429538553-17366-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes an old stability issue for detection of SD-cards. The DT
node for the GPIO regulator which controls the I/O voltage level towards the
SD-card was disabled in below commit.

c94a4ab7af3f ("ARM: ux500: Disable the MMCI gpio-regulator by default")

The conseqeunce from that commit, was that the initially chosen voltage level
remained, even after I/O voltage switch sequence was performed for UHS-I cards,
since no GPIO regulator could be fetched.

Appearantly some SD-cards didn't have any problem to cope with that, but some
had.

Recently thorough error handling was introduced for the MMCI mmc host driver,
while fetching the regulators for the SD-card. That actually made the driver to
continously return -EPROBE_DEFER while probing, which thus meant failing all the
times instead of just failing "sometimes".

The commit that introduced the thorough error handling is:
9369c97cc7ec ("mmc: mmci: Cascade EPROBE_DEFER from regulators")


Ulf Hansson (3):
  ARM: ux500: Move GPIO regulator for SD-card into board DTSs
  ARM: ux500: Enable GPIO regulator for SD-card for HREF boards
  ARM: ux500: Enable GPIO regulator for SD-card for snowball

 arch/arm/boot/dts/ste-dbx5x0.dtsi  | 17 -----------------
 arch/arm/boot/dts/ste-href.dtsi    | 15 +++++++++++++++
 arch/arm/boot/dts/ste-snowball.dts | 13 +++++++++++++
 3 files changed, 28 insertions(+), 17 deletions(-)

-- 
1.9.1
