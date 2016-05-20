From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 20 May 2016 15:32:01 +0530
Subject: [PATCH v3 0/4] Implement SoC driver for Vybrid
Message-ID: <cover.1463737502.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This third patch series is rebased on top of shawn's for-next branch
and tested on Colibri Vybrid VF50 and VF61 modules.

This patchset implements SoC bus support for Freescale Vybrid platform,
implementing the following
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc

This a reworked version of an older patchset series posted in June 2015
which was at v5 then [1]. Since the NVMEM framework was then getting
introduced, we decided that first a NVMEM driver for OCOTP peripheral
being in place would be better.

Compared to the older revisions, this driver now relies on NVMEM
consumer API using the NVMEM based vf610_ocotp driver which has
already been in mainline for a while now.

One point on which we were not sure here is whether we really should
introduce a new Kconfig symbol as being introduced here. While we
could just enable it when SOC_VF610 is selected, this however would
introduce circular dependencies.

Feedback is most welcome.

@Rob Herring
Does this patchset address the concerns you had?

Changes since v2:
1. Remove syscon_regmap_read_from_offset function and use the
available syscon functions
2. Remove fsl,vf610-soc-bus and related bindings at SoC node
level and introduce a fsl,vf610-soc node which is used by the
driver to bind and has all the required phandles plus the NVMEM
consumer handles.
3. Fix memory leak. of_node_put was not called for returned node
of of_parse_phandle and memory allocated by nvmem_cell_read was
not freed explicitly in return error paths.

Changes since v1:
Add device tree binding documentation.

2016: v2 patchset
https://lkml.org/lkml/2016/5/2/69

2016: v1 patchset
https://lkml.org/lkml/2016/3/11/132

[1] Older v5:
http://lkml.iu.edu/hypermail/linux/kernel/1506.0/03787.html
Even earlier versions:
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

Regards,
Sanchayan.

Sanchayan Maity (4):
  ARM: dts: vfxxx: Add device tree node for OCOTP
  ARM: dts: vfxxx: Add On-Chip ROM node for Vybrid
  ARM: dts: vfxxx: Add device tree node required by Vybrid SoC driver
  soc: Add SoC driver for Freescale Vybrid platform

 .../bindings/arm/freescale/fsl,vf610-soc.txt       |  20 +++
 arch/arm/boot/dts/vfxxx.dtsi                       |  29 +++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/fsl/Kconfig                            |  10 ++
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/soc-vf610.c                        | 198 +++++++++++++++++++++
 6 files changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/soc-vf610.c

-- 
2.8.2
