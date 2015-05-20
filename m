From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 20 May 2015 11:06:50 +0530
Subject: [PATCH v2 0/2] Implement SoC bus support for Vybrid
Message-ID: <cover.1432099651.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset implements SoC bus support for Freescale Vybrid platform,
implementing the following
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc

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

Version 1 of the patchset can be found here
http://www.spinics.net/lists/devicetree/msg80257.html

The RFC version can be found here
https://lkml.org/lkml/2015/5/11/13

Changes since v1:
- Sort the headers in alphabetical order

Changes since RFC:
- Use a DT entry for the ROM area while specifying it as syscon.

Sanchayan Maity (2):
  ARM: dts: vfxxx: Add OCOTP and OCROM nodes
  ARM: vf610: Add SoC bus support for Vybrid

 arch/arm/boot/dts/vfxxx.dtsi   | 10 +++++
 arch/arm/mach-imx/mach-vf610.c | 85 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 2 deletions(-)

-- 
2.4.1
