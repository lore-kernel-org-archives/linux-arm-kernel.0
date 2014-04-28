From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Mon, 28 Apr 2014 10:31:44 +0100
Subject: [PATCH 0/3] Make kexec work with CONFIG_DEBUG_RODATA enabled
Message-ID: <1398677507-6687-1-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes kexec work on a kernel that has its .text section set to read
only. The main reason of doing it is because there is a patch in the making 
(http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244779.html)
which aims to make it possible to flag the kernel's code section as read-only,
rendering kexec inoperable.

The first patch does the actual functional changes while the 2nd one is
optional and is only to be used in case you have already applied the aforementioned
CONFIG_DEBUG_RODATA patch

Patch 3 is also optional and tries to make the assembly code a bit more "sane"
by introducing a .struct to describe the parameters for the kernel relocation
stub. 

Those patches have been tested on linux 3.14 on THUMB-2/non-THUMB-2 host
kernels. 

Patch 1 and 3 apply cleanly on 3.15-rc3 and Patch 2 applies cleanly, provided
that Kees' patch is applied as well. 

Kees also managed to test that on a QEMU 2.0 based machine. 

Nikolay Borisov (3):
  ARM: kexec: Make kexec work with read-only kernel .text section
  ARM: Kconfig: remove dependence of CONFIG_DEBUG_RODATA on !kexec
  ARM: kexec: Use .struct to describe relocate_new_kernel parameter
    layout

 arch/arm/kernel/machine_kexec.c   | 54 ++++++++++++++++++++++++++++-----------
 arch/arm/kernel/relocate_kernel.S | 47 +++++++++++++++++-----------------
 arch/arm/mm/Kconfig               |  2 +-
 3 files changed, 63 insertions(+), 40 deletions(-)

-- 
1.8.1.5
