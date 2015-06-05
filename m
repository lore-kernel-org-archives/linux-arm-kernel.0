From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri,  5 Jun 2015 14:52:36 +0530
Subject: [PATCH v5 0/2] Implement SoC bus support for Vybrid
Message-ID: <cover.1433494491.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset implements SoC bus support for Freescale Vybrid platform,
implementing the following
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc
and is the fifth revision. Tested on a Colibri VF61 module after
rebasing on shawn's for-next branch.

Arnd and Shawn I did like to have your comments to get this in a
mergeable state and make any changes as necessary and required.

Thanks for the comments and feedback till now. Feedback is most
welcome.

Version 4 of the patchset can be found here
https://lkml.org/lkml/2015/5/26/199

Version 3 of the patchset can be found here
http://www.spinics.net/lists/arm-kernel/msg420847.html

Version 2 of the patchset can be found here
http://www.spinics.net/lists/devicetree/msg80654.html

Version 1 of the patchset can be found here
http://www.spinics.net/lists/devicetree/msg80257.html

The RFC version can be found here
https://lkml.org/lkml/2015/5/11/13

Changes since v4:
- Use devm_* family of functions and use a struct to get rid of
  global variables (suggested by Joachim Eastwood)
- Make Kconfig govern the compilation with tristate, instead of
  earlier bool. Paul Bolle raised a valid point that perhaps this
  should have been built in with the bool, however I had not taken
  into consideration generic distro kernels and it makes sense to
  have this tristated. (comments from Paul Bolle and Andreas Farber)

Changes since v3:
- Instead of using the syscon_regmap_lookup_by_compatible function
  use a phandle in the device tree along with offsets specified in
  this phandle node and then read the offset along with the device
  node in the driver for reading from the required region.

Changes since v2:
- Implement the SoC bus code as a driver in drivers/soc
  by registering with fsl,mscm-cpucfg as per Arnd's feedback

Changes since v1:
- Sort the headers in alphabetical order

Changes since RFC:
- Use a DT entry for the ROM area while specifying it as syscon.

Notes same since v1:
Currently the required information is more or less read across the whole
SoC, but I guess we cannot change that since these are the locations
with the required information.

There seem to be three options for the revision field:
- ROM revision (see https://community.freescale.com/docs/DOC-94802)
- ANADIG revision (ANADIG_DIGIPROC, as used for the i.MX SoC's)
- OCOTP revision

Some numbers:

Colibri VF61 1.1A (2N02G)
- 0x00000013
- 0x00610000
- 0x01000000
- 0x410000c8

Colibri VF61 V1.0B (1N02G)
- 0x00000011
- 0x00610000
- 0x01000000
- 0x410000c8

Colibri VF61 V1.0A (which is actually a VF600 SoC, no L2 cache, since
that was the only one we could buy back then, 1N02G printed on it)
- 0x00000011
- 0x00610000
- 0x01000000
- none...

Colibri VF50 V1.0A (1N02G)
- 0x00000011
- 0x00610000
- 0x01000000
- none...

Vybrid Tower Rev J (1N02G)
- 0x00000011
- 0x00610000
- 0x01000000
- 0x410000c8

The ROM revision differs the most, so we would like to go with the
revision information from the ROM register 0x80.

Sanchayan Maity (2):
  ARM: dts: vfxxx: Add OCOTP and OCROM nodes
  soc: Add driver for Freescale Vybrid Platform

 arch/arm/boot/dts/vfxxx.dtsi |  12 ++++
 drivers/soc/Kconfig          |   1 +
 drivers/soc/Makefile         |   1 +
 drivers/soc/fsl/Kconfig      |  10 +++
 drivers/soc/fsl/Makefile     |   1 +
 drivers/soc/fsl/soc-vf610.c  | 166 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 191 insertions(+)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/Makefile
 create mode 100644 drivers/soc/fsl/soc-vf610.c

-- 
2.4.2
