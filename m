From: geoff@infradead.org (Geoff Levand)
Date: Fri, 09 May 2014 00:48:17 +0000
Subject: [PATCH 0/8] arm64 kexec kernel patches 
Message-ID: <cover.1399594544.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maintainers,

This patchset adds support for kexec re-boots on arm64.  I have tested with the 
VE fast model using various kernel config options with both spin and psci enable 
methods.  I'll continue to test in the coming weeks.

I tried to re-use the existing hot plug cpu_ops support for the secondary CPU 
shutdown as much as possible, but needed to do some things specific to kexec 
that I couldn't do with what was already there.  A significant change is in 
[PATCH 4/8] (arm64: Add smp_spin_table_set_die) where I add the ability to setup 
a custom cpu_die handler.

To get the the spin-table secondary CPUs into the proper state described in 
Documentation/arm64/booting.txt I use a three step spin loop.  First in the 
kernel's virtual address space, then to the identity mapped address, then jump 
to the final spin code in the 2nd stage kernel's /memreserve/ area.  To support 
this three step spin I needed [PATCH 5/8] (arm64: Split soft_restart into two 
stages).  Please see the patch comments for more info.  If we added the 2nd 
stage kernel's /memreserve/ area to the identity map we could eliminate the 
middle step and go from the VA space to the /memreserve/ area directly.

Please consider all patches for inclusion.  Any comments or suggestions on how 
to improve would be very welcome.

To load a kexec kernel and execute a kexec re-boot on arm64 my patches to
kexec-tools, which have not yet been merged upstream, are needed:

  https://git.linaro.org/people/geoff.levand/kexec-tools.git

-Geoff

The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git for-arm64-kexec

for you to fetch changes up to 32399380e2249697ca549848ef83e5706eb4d83c:

  arm64: Enable kexec in defconfig (2014-05-08 17:09:27 -0700)

----------------------------------------------------------------
Geoff Levand (8):
      arm64: Use cpu_ops for smp_stop
      arm64: Make cpu_read_ops generic
      arm64: Add spin-table cpu_die
      arm64: Add smp_spin_table_set_die
      arm64: Split soft_restart into two stages
      arm64/kexec: kexec needs cpu_die
      arm64/kexec: Add core kexec support
      arm64: Enable kexec in defconfig

 MAINTAINERS                          |   9 +
 arch/arm64/Kconfig                   |   8 +
 arch/arm64/configs/defconfig         |   1 +
 arch/arm64/include/asm/cpu_ops.h     |   5 +-
 arch/arm64/include/asm/kexec.h       |  44 +++
 arch/arm64/include/asm/system_misc.h |   1 +
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/cpu_ops.c          |  11 +-
 arch/arm64/kernel/machine_kexec.c    | 623 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c          |   4 +-
 arch/arm64/kernel/psci.c             |   4 +-
 arch/arm64/kernel/relocate_kernel.S  | 239 ++++++++++++++
 arch/arm64/kernel/smp.c              |  10 +-
 arch/arm64/kernel/smp_spin_table.c   |  21 +-
 include/uapi/linux/kexec.h           |   1 +
 15 files changed, 969 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

-- 
1.9.1
