From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 16:53:03 +0900
Subject: [v2 0/5] arm64: add kdump support
Message-ID: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enables kdump (crash dump kernel) support on arm64 on top of
Geoff's kexec patchset.

In this version, there are some arm64-specific usage/constraints:
1) "mem=" boot parameter must be specified on crash dump kernel
   if the system starts on uefi.
2) Kvm will not be enabled on crash dump kernel even if configured
See commit messages and Documentation/kdump/kdump.txt for details.

The only concern I have is whether or not we can use the exact same kernel
as both system kernel and crash dump kernel. The current arm64 kernel is
not relocatable in the exact sense but I see no problems in using the same
binary when testing kdump.

I tested the code with
	- ATF v1.1 + EDK2(UEFI) v3.0-rc0
	- kernel v4.0 + Geoff' kexec v9
on
	- Base fast model, and
	- MediaTek MT8173-EVB
using my own kexec-tools [1], currently v0.12.

You may want to start a kernel with the following boot parameter:
	crashkernel=64M (or so, on model)
and try
	$ kexec -p --load <vmlinux> --append ...
	$ echo c > /proc/sysrq-trigger

To examine vmcore (/proc/vmcore), you should use
	- gdb v7.7 or later
	- crash + a small patch (to recognize v4.0 kernel)

Changes from v1:
* rebased to Geoff's v9
* tested this patchset on real hardware and fixed bugs:
- added cache flush operation in ipi_cpu_stop() when shutting down
  the system. Otherwise, data saved in vmcore's note sections by
  crash_save_cpu() might not be flushed to dumped memory and crash command
  fail to fetch correct data.
  I will address Mark's commit[2] after Geoff takes care of it on kexec.
- modified to use ioremap_cache() instead of ioremap() when reading
  crash memory. Otherwise, accessing /proc/vmcore on crash dump kernel
  might cause an alignment fault.
* allows reserve_crashkernel() to handle "crashkernel=xyz[MG]" correctly,
  thanks to Pratyush Anand. And it now also enforces memory limit.
* moved reserve_crashkernel() and reserve_elfcorehdr() to
  arm64_memblock_init() to clarify that they should be called before
  dma_contignuous_reserve().

[1] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338171.html


AKASHI Takahiro (5):
  arm64: kdump: reserve memory for crash dump kernel
  arm64: kdump: implement machine_crash_shutdown()
  arm64: kdump: do not go into EL2 before starting a crash dump kernel
  arm64: add kdump support
  arm64: enable kdump in the arm64 defconfig

 Documentation/kdump/kdump.txt     |   31 +++++++++++++-
 arch/arm64/Kconfig                |   12 ++++++
 arch/arm64/configs/defconfig      |    1 +
 arch/arm64/include/asm/kexec.h    |   34 ++++++++++++++-
 arch/arm64/kernel/Makefile        |    1 +
 arch/arm64/kernel/crash_dump.c    |   71 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c |   55 +++++++++++++++++++++++-
 arch/arm64/kernel/process.c       |    7 +++-
 arch/arm64/kernel/setup.c         |    8 +++-
 arch/arm64/kernel/smp.c           |   12 +++++-
 arch/arm64/mm/init.c              |   84 +++++++++++++++++++++++++++++++++++++
 11 files changed, 309 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
1.7.9.5
