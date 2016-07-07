From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Thu,  7 Jul 2016 12:09:25 +0530
Subject: [PATCH v4 0/5] Implement SoC driver for Vybrid
Message-ID: <cover.1467872014.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This fourth patch series is rebased on top of shawn's for-next branch
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
Does this patchset address the concerns you had? The only change
to the device tree is now for the compatible property.

@Srinivas
Is this new NVMEM consumer API acceptable? Would you recommend a
different approach?

Changes since v3:
1. Use just a compatible node at the SoC node and do not
use a separate node for the binding
2. Use syscon regmap lookup for getting information from
MSCM and OCROM nodes.
3. Introduce a NVMEM consumer API for getting a NVMEM cell
given a device node containing that cell.
4. Do not introduce any node at the SoC level.

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

2016: v3 patchset
https://lkml.org/lkml/2016/5/20/200

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
  soc: Add SoC driver for Freescale Vybrid platform
  ARM: dts: vfxxx: Add a compatible binding for Vybrid SoC bus driver

Stefan Agner (1):
  nvmem: core: Add consumer API to get nvmem cell from node

 arch/arm/boot/dts/vfxxx.dtsi   |  23 ++++-
 drivers/nvmem/core.c           |  44 ++++++---
 drivers/soc/Kconfig            |   1 +
 drivers/soc/fsl/Kconfig        |  10 ++
 drivers/soc/fsl/Makefile       |   1 +
 drivers/soc/fsl/soc-vf610.c    | 212 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |   1 +
 7 files changed, 278 insertions(+), 14 deletions(-)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/soc-vf610.c

-- 
2.9.0
