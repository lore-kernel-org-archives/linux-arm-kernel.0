From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 23 Jun 2015 19:14:55 +0530
Subject: [RFC PATCH v6 0/2] Implement NVMEM/SoC bus support for Vybrid
Message-ID: <cover.1435066190.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset is based on top of v5 of Srinivas's NVMEM framework patches.
Recently, a v6 was posted, however since I mean this patchset to be only
RFC I am not basing this on v6 for now. Applied the NVMEM framework patches
on shawn's tree along with Stefan's NAND patches and then tested on Colibri
VF61.

Would like to have some initial comments on the patchset. Maxime? Srinivas?

Thanks for the comments and feedback till now.

Version 5 of the patchset can be found here
http://lkml.iu.edu/hypermail/linux/kernel/1506.0/03787.html

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

Changes since v5:
- Use NVMEM framework by Srinivas and Maxime

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

Regards,
Sanchayan.

Sanchayan Maity (2):
  ARM: dts: vfxxx: Add OCOTP and OCROM nodes
  nvmem: Add Vybrid OCOTP and OCROM support

 arch/arm/boot/dts/vfxxx.dtsi | 18 +++++++++++++
 drivers/nvmem/Kconfig        | 11 ++++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/vf610-ocotp.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 drivers/nvmem/vf610-ocotp.c

-- 
2.4.4
