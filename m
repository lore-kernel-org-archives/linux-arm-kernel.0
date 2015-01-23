From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Jan 2015 15:09:55 +0100
Subject: [PATCH v2] MediaTek PMIC support
Message-ID: <1422022202-7526-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial support for the MediaTek MT6397 PMIC and the
necessary infrastructure to attach it on the MT8135 / MT8173 SoCs.

The infrastructure includes:

- pericfg / infracfg controller support
  The pericfg / infracfg controllers contain miscellaneous registers for
  reset controllers and clocks.

- PMIC wrapper support
  On MediaTek MT8135, MT8173 and other SoCs the PMIC is connected via
  SPI. The SPI master interface is not directly visible to the CPU, but
  only through the PMIC wrapper inside the SoC. The communication between
  the SoC and the PMIC can optionally be encrypted. Also a non standard
  Dual IO SPI mode can be used to increase speed. The MT8135 also supports
  a special feature named "IP Pairing". With IP Pairing the pins of some
  SoC internal peripherals can be on the PMIC. The signals of these pins
  are routed over the SPI bus using the pwrap bridge. Because of these
  optional non SPI conform features the PMIC driver is not implemented as
  a SPI bus master driver.

The MT6397 PMIC itself is implemented as a regular mfd device driver which
uses regmap to access the PMIC registers.

This series also adds regulator support for the MT6397 PMIC.

The first 6 patches can be merged through the ARM SoC tree. The mfd
patch is independent of the first 6 patches and can be merged through the
mfd maintainer trees.

Changes since v1:

- document reset bindings for infracfg/pericfg
- fix base addresses in infracfg binding example
- Remove more Email addresses from Flora Fu (She is not working at
  MediaTek anymore, her address is no longer valid)
- drop Regulator support patch, it's already in next

Sascha
