From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Wed,  9 Apr 2014 17:50:35 +0100
Subject: [RFC PATCH 0/3] Make kexec work with CONFIG_DEBUG_RODATA enabled
Message-ID: <1397062238-10515-1-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes kexec work on a kernel that has its .text section set to read
only. The main reason of doing it is because there is a patch in the making 
(http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244779.html)
which aims to make it possible to flag the kernel's code section as read-only,
rendering kexec inoperable.

The first patch does the actual functional changes while the 2nd one is
optionail and is only to be used in case you have already applied the aforementioned
CONFIG_DEBUG_RODATA patch

Patch 3 is also optional and tries to make the assembly code a bit more "sane"
by introducing a .struct to describe the parameters for the kernel relocation
stub. 

Those patches have been tested on linux 3.14 on THUMB-2/non-THUMB-2 host
kernels.

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
