From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 13 Oct 2017 15:59:13 -0500
Subject: [PATCH v5 0/2] memory: Introduce ti-emif-sram driver
Message-ID: <20171013205915.9652-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This is v5 of the series introduces a ti-emif-sram driver to be used on
am335x and am437x. The previous version of this 
series can be found here [1].

The only change to this version is to greatly simplify the makefile rules
used to generate the emif-asm-offsets header to fix some build issues
caught by the kbuild robot. The file has been renamed as ti-emif-asm-offsets.h
and is also now placed under include/generated so that it is handled along
with the other generated headers.

The macros were left inside the "ti_emif_offsets" inline function in the
ti-emif-sram header as they are also needed by the sleep33xx and sleep43xx
from the "code (seen here [2]), and describing the build depency on the
generated ti-emif-asm-offsets.h file got messy. Just including the macros in
the asm-offsets file generated for the arch/arm/mach-omap2 was the cleanest
way I could come up with, otherwise ensuring that ti-emif-asm-offsets.h is
generated before sleep33/43xx.S gets built was problematic. Of course,
I am open to a better idea if someone has one.

This code is required for low-power modes to work on AM335x and AM437x and a
forthcoming PM series for those platforms will depend on this series. After
both this and the PM series are reviewed I will send the necessary device tree
changes for both, but in the meantime all remaining patches for am335x and
am437x PM can be found here [3].

Regards,
Dave

[1] https://www.spinics.net/lists/arm-kernel/msg607959.html
[2] https://www.spinics.net/lists/arm-kernel/msg595934.html
[3] https://github.com/dgerlach/linux-pm/tree/upstream/v4.14/amx3-suspend-v5

Dave Gerlach (2):
  Documentation: dt: Update ti,emif bindings
  memory: ti-emif-sram: introduce relocatable suspend/resume handlers

 .../bindings/memory-controllers/ti/emif.txt        |  18 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |  13 +
 drivers/memory/emif-asm-offsets.c                  |  22 ++
 drivers/memory/emif.h                              |  17 ++
 drivers/memory/ti-emif-pm.c                        | 339 +++++++++++++++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 ++++++++++++++++++++
 include/linux/ti-emif-sram.h                       | 144 +++++++++
 8 files changed, 896 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/emif-asm-offsets.c
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 include/linux/ti-emif-sram.h

-- 
2.13.4
