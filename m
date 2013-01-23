From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 23 Jan 2013 20:47:07 +0800
Subject: [PATCH 0/5 v3] at91: PMECC: enable PMECC in dt for at91sam9x5ek,
 at91sam9n12ek
Message-ID: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those patches will enable PMECC in dt parameters for at91sam9x5ek and 
at91sam9n12ek.

The PMECC driver will check minimum required ecc on ONFI parameter from NAND 
flash.

If pmecc-cap, pmecc-sector-size in dts file is specified, use those two.
otherwise, set those according to NAND flash ONFI parameters.

If the pmecc-cap, pmecc-sector-size in dts are different with ecc requirement
in ONFI, print out a warning.


For the following compile error:
  ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"

  ERROR: Input tree has errors, aborting (use -f to force output)
  make[2]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2

the fixes are already merged in Linux mainline in v3.8-rc4.
you can find in: 
 544ae6b2e676c3c37fb8c93ef9327932fc2e5bc2 (ARM: at91/dts: add pinctrl support for SSC peripheral)
 ea03c81521bde526570e1dec96eaa21fe5ac84a2 (ASoC: atmel-ssc: add pinctrl selection to driver) 


Change logs:
v2: rebase to v3.8-rc3. And wrapped the commit message.

v3: big chages:
  1. reduce the PMECC lookup table mapping. Just the lookup table not whole
     ROM code according to J.C's suggestion.
  2. use simpler strategy to handle pmecc-cap, pmecc-sector-size:
     * make pmecc-cap, pmecc-sector-size optional.
     * If pmecc-cap, pmecc-sector-size are not set, use ONFI ecc parameters.
       otherwise, use those in DTS file.
     * print out a warning if PMECC use different ecc bits or sector size 
       from ONFI ecc parameters.

Josh Wu (5):
  MTD: atmel_nand: avoid to report an error when lookup table offset is
    0.
  ARM: at91: at91sam9x5: add DT parameters to enable PMECC
  ARM: at91: at91sam9n12: add DT parameters to enable PMECC
  MTD: atmel_nand: make pmecc-cap, pmecc-sector-size in dts is
    optional.
  MTD: at91: atmel_nand: for PMECC, add code to check the ONFI
    parameter ECC requirement.

 arch/arm/boot/dts/at91sam9n12.dtsi  |    3 +-
 arch/arm/boot/dts/at91sam9n12ek.dts |    5 +-
 arch/arm/boot/dts/at91sam9x5.dtsi   |    4 +
 arch/arm/boot/dts/at91sam9x5cm.dtsi |    5 +-
 drivers/mtd/nand/atmel_nand.c       |  141 +++++++++++++++++++++++++++++------
 5 files changed, 131 insertions(+), 27 deletions(-)

-- 
1.7.9.5
