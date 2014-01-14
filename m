From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 13 Jan 2014 19:19:40 -0500
Subject: [PATCH 0/3] arm: remap non-modular uses of module_init properly
Message-ID: <1389658783-9876-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal is to move module_init/module_exit from init.h and into
module.h -- however in doing so, we uncover several instances in
ARM code where module_init is used somewhat incorrectly by non modular
code, and a file that needs module.h but isn't sourcing it.  We need to
make these fixups 1st before changing the headers so that we don't cause
build failures later on.

The changes are largely inert, however we do cause a largely trivial
change in one initcall ordering -- that happens because module_init
is really device_initcall; but I didn't use device_initcall because
subsys_initcall seems somewhat more appropriate.

All modified files were build tested on today's linux next tree.

Paul.
---

Paul Gortmaker (3):
  arm: use subsys_initcall in non-modular pl320 IPC code
  arm: include module.h in drivers/bus/omap_l3_smx.c
  arm: don't use module_init in non-modular mach-vexpress/spc.c code

 arch/arm/mach-vexpress/spc.c | 2 +-
 drivers/bus/omap_l3_smx.c    | 1 +
 drivers/mailbox/pl320-ipc.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.5.2
