From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 22 May 2015 16:21:52 +0530
Subject: [PATCH v3 0/2] Implement SoC bus support for Vybrid
Message-ID: <cover.1432290463.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset implements SoC bus support for Freescale Vybrid platform,
implementing the following
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc
and is the third revision.

Version 2 of the patchset can be found here
http://www.spinics.net/lists/devicetree/msg80654.html

Version 1 of the patchset can be found here
http://www.spinics.net/lists/devicetree/msg80257.html

The RFC version can be found here
https://lkml.org/lkml/2015/5/11/13

Changes since v2:
- Implement the SoC bus code as a driver in drivers/soc
  by registering with fsl,mscm-cpucfg as per Arnd's feedback

Changes since v1:
- Sort the headers in alphabetical order 

Changes since RFC:
- Use a DT entry for the ROM area while specifying it as syscon.

One question I had in comparison to the previous implementation is, the
previous patch also resulted in exposing the DT devices in the subdirectory
soc under soc0/ which happened due to the of_platform_populate call. With
the current implementation this does not happen anymore. I am not too
thorough on all this, but I guess that of_platform_populate needs to be
called early with the right arguments. With the current implementation is
it possible to get that soc0/soc directory exposed in any way? Am I missing
something trivial in all this?

I guess we are OK, even if the above cannot be achived with the current
implementation. The main aim of this exercise was to expose the SoC specific
attributes. However it did be nice, if it could still be done. Perhaps that
part of the implementation can go in later in a separate patch.

Arnd are you ok with this implementation?

Notes same since v1 and v2:
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

 arch/arm/boot/dts/vfxxx.dtsi |  10 ++++
 drivers/soc/Kconfig          |   1 +
 drivers/soc/Makefile         |   1 +
 drivers/soc/fsl/Kconfig      |   9 ++++
 drivers/soc/fsl/Makefile     |   1 +
 drivers/soc/fsl/soc-vf610.c  | 113 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 135 insertions(+)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/Makefile
 create mode 100644 drivers/soc/fsl/soc-vf610.c

-- 
2.4.1
