From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 16 Mar 2018 00:07:35 +0800
Subject: [PATCH v7 0/3] Add support for Hi3660 mailbox driver
Message-ID: <1521130058-24796-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi3660 mailbox controller is used to send message within multiple
processors, MCU, HIFI, etc. This patch series is to implement an
initial version for Hi3660 mailbox driver with "automatic
acknowledge" mode.

The patch set have been verified with Hi3660 stub clock driver, so
we can send message to MCU to execute CPU frequency scaling. This is
tested on 96boards Hikey960.

Changes from v6:
* Rebased patches on latest mainline kernel: commit 0aa3fdb8b3a6
  ("Merge branch 'percpu_ref-rcu-audit-fixes' of git://git.kernel.org/
   pub/scm/linux/kernel/git/tj/misc")

Changes from v5:
* Changed to use writel()/readl() to replace {writel|readl}_relaxed()
  to make safe for memory ordering;

Changes from v4:
* According to Jassi suggestion, refactored mailbox driver and removed
  "inline" for function declaration;

Changes from v3:
* According to Jassi suggestion, refined structure name to
  "struct hi3660_chan_info";
* According to Jassi suggestion, moved channel 'lock'+'acquire'
  operations into .startup();

Changes from v2:
* According to Mark Rutland suggestions, removed sev()/wfe() from
  driver, the system has no two masters sharing the same channel for
  data transferring so we don't need these instructions;
* Refined DT binding and doc according to Rob suggestions;
* Refined driver according to Julien suggestions;

Changes from v1:
* Added cover letter to track the changelog;
* Added document for DT binding;
* Refactored and simplized mailbox driver with "automatic ack" mode;
* Refined commit logs for patches;


Kaihua Zhong (2):
  mailbox: Add support for Hi3660 mailbox
  dts: arm64: Add mailbox binding for hi3660

Leo Yan (1):
  dt-bindings: mailbox: Introduce Hi3660 controller binding

 .../bindings/mailbox/hisilicon,hi3660-mailbox.txt  |  51 ++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   8 +
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/hi3660-mailbox.c                   | 312 +++++++++++++++++++++
 5 files changed, 381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
 create mode 100644 drivers/mailbox/hi3660-mailbox.c

-- 
1.9.1
