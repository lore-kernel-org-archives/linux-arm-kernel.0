From: hs.liao@mediatek.com (HS Liao)
Date: Fri, 18 Mar 2016 19:27:11 +0800
Subject: [RFC v3 0/3] Mediatek MT8173 CMDQ support
Message-ID: <1458300434-14438-1-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help read/write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

These patches have a build dependency on top of v4.5-rc1.

Changes since v2:
 - use cmdq instead of cqctx
 - document cmdq_code
 - use cmdq thread base instead of thread id, so remove thread id
 - remove buffer pool and let linux manage memory
 - remove task_free_list
 - merge cmdq_task_exec_async_impl into cmdq_task_exec_async
 - use list_for_each_entry_safe instead of list_for_each_safe
 - merge cmdq_dev_init into cmdq_probe
 - use cmdq record(rec) instead of cmdq handle
 - use cmdq command instead of cmdq desc
 - remove unused interfaces
 - set IRQF_TRIGGER_LOW in device tree
 - remove event array and related code since client should clear event
   before wait it
 - report status to callback function
 - remove some debug code
 - remove some protection code, e.g. suspend/resume
 - rewrite some code to shrink code size

Best regards,
HS Liao

HS Liao (3):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  CMDQ: Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node

 .../devicetree/bindings/soc/mediatek/gce.txt       |   34 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    8 +
 drivers/soc/mediatek/Kconfig                       |   10 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq.c                    | 1805 ++++++++++++++++++++
 include/soc/mediatek/cmdq.h                        |  181 ++
 6 files changed, 2039 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
 create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
 create mode 100644 include/soc/mediatek/cmdq.h

-- 
1.7.9.5
