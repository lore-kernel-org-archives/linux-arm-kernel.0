From: hs.liao@mediatek.com (HS Liao)
Date: Thu, 30 Jun 2016 15:14:39 +0800
Subject: [PATCH v9 0/4] Mediatek MT8173 CMDQ support
Message-ID: <1467270883-1407-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.7-rc1.

Changes since v8:
 - use mailbox framework, and merge options for GCE thread into
   mailbox channel
 - use timer to handle timeout case
 - rename cmdq_handle_error_done to cmdq_thread_irq_handler, handle
   error by cmdq_task_handle_error, and handle timeout by
   cmdq_thread_handle_timeout
 - use bitops
 - fix bug of treating working task as done task
 - move GCE hardware events' mapping from header to driver
 - remove code about previous tasks since we should keep tasks' order
   for display, and it is impossible to have previous tasks
 - centralize code to handle executed tasks in cmdq_task_exec_done
 - use u64* instead of u32* for GCE command pointer
 - drop cmdq_thread_readl/writel
 - depends on ARM64
 - refine some code accroding to comments for v8

Best regards,
HS Liao

HS Liao (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  CMDQ: Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  CMDQ: save more energy in idle

 .../devicetree/bindings/soc/mediatek/gce.txt       |  44 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
 drivers/soc/mediatek/Kconfig                       |  11 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 967 +++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        | 192 ++++
 6 files changed, 1225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.9.1
