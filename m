From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 26 Mar 2015 17:28:48 +0900
Subject: [PATCH 0/5] arm64: add kdump support
Message-ID: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enables kdump (crash dump kernel) support on arm64 on top of
Geoff's kexec patchset.

In this version, there are some arm64-specific usage/constraints:
1) "mem=" boot parameter must be specified on crash dump kernel
2) Kvm will not be enabled on crash dump kernel even if configured
See commit messages and Documentation/kdump/kdump.txt for details.

The only concern I have is whether or not we can use the exact same kernel
as both system kernel and crash dump kernel. The current arm64 kernel is
not relocatable in the exact sense but I have no problems in using the same
binary for testing kdump.

I tested the code with
	- ATF v1.1 + EDK2(UEFI) v3.0-rc0
	- kernel v4.0-rc4 + Geoff' kexec v8
on Base fast model, using my yet-to-be-submitted kexec-tools [1].
You may want to start a kernel with the following boot parameter:
	crashkernel=64M at 2240M
and try
	$ kexec -p --load <vmlinux> --append ...
	$ echo c > /proc/sysrq-trigger

To examine vmcore (/proc/vmcore), you may use
	- gdb v7.7 or later
	- crash + a small patch (to recognize v4.0 kernel)

[1] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git


AKASHI Takahiro (5):
  arm64: kdump: reserve memory for crash dump kernel
  arm64: kdump: implement machine_crash_shutdown()
  arm64: kdump: do not go into EL2 before starting a crash dump kernel
  arm64: add kdump support
  arm64: enable kdump in the arm64 defconfig

 Documentation/kdump/kdump.txt     |   31 ++++++++++++++-
 arch/arm64/Kconfig                |   12 ++++++
 arch/arm64/configs/defconfig      |    1 +
 arch/arm64/include/asm/kexec.h    |   34 +++++++++++++++-
 arch/arm64/kernel/Makefile        |    1 +
 arch/arm64/kernel/crash_dump.c    |   71 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c |   55 +++++++++++++++++++++++++-
 arch/arm64/kernel/process.c       |    7 +++-
 arch/arm64/kernel/setup.c         |   78 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/smp.c           |   10 ++++-
 10 files changed, 294 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

-- 
1.7.9.5
