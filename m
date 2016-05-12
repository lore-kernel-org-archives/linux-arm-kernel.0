From: hs.liao@mediatek.com (HS Liao)
Date: Thu, 12 May 2016 15:13:26 +0800
Subject: [PATCH v6 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1463037210-863-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help read/write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.6-rc1.

Changes since v5:
 - keep order of display tasks
 - use list instead of arrary for thread's tasks management
 - remove task_active_list
 - prevent deadlock in suspend/resume flow
 - prevent to flush in both suspending and suspended
 - prevent to add auto release work after suspending or suspended
 - merge cmdq_task_create() into cmdq_task_acquire()
 - remove cmdq_task_free_command_buffer() and call dma_free_coherent()
   directly

Best regards,
HS Liao

HS Liao (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  CMDQ: Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  CMDQ: suspend/resume protection

 .../devicetree/bindings/soc/mediatek/gce.txt       |   34 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    8 +
 drivers/soc/mediatek/Kconfig                       |   10 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 1446 ++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        |  197 +++
 6 files changed, 1696 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.9.1
