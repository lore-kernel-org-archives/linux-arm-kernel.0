From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Sat, 15 Mar 2014 14:47:59 +0900
Subject: [PATCH_v5] audit: generic compat system call support
In-Reply-To: <1391410528-4844-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391410528-4844-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1394862480-29019-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 supports 32-bit mode(AArch32) and 64-bit mode(AArch64).
To enable audit on arm64, we want to use lib/audit.c and re-work it
to support compat system calls as well without copying it under
arch sub-directory.

Since this patch is implemented in much the same way as on existing
bi-architectures (ie. ppc, s390, sparc and x86), it's not difficult
for them to utilize this generic code instead of their own implementation.

The code was tested on armv8 fast model with 64-bit and 32-bit userland
by using modified audit-test-code. As this patch is mandatory for my
"system call audit support for arm64" patch, please review it as well
for better understandings.

Changes v4 -> v5:
* Add CONFIG_AUDIT_ARCH_COMPAT_GENERIC. Its purpose is to avoid compling
  compat_audit.c unintentionally. Some architectures may enable AUDIT,
  COMPAT and then AUDIT_GENERIC if !AUDIT_ARCH, but not really need
  compat_audit.c.
  (mips is the case, but mips doesn't really support AUDITSYSCALL though.)

Changes v3 -> v4:
* Add CONFIG_AUDIT_COMPAT_GENERIC to compile in compat_audit.c
* Re-define audit_is_compat() in generic way in order to eliminate
  necessity of asm/audit.h.

Changes v2 -> v3:
* Specify AUDIT_CLASS_XYZ_32 instead of AUDIT_CLASS_XYZ when registering
  compat syscalls (bug fix)

AKASHI Takahiro (1):
  audit: Add generic compat syscall support

 include/linux/audit.h      |  8 ++++++++
 include/uapi/linux/audit.h |  6 ++++++
 lib/Kconfig                |  9 +++++++++
 lib/Makefile               |  1 +
 lib/audit.c                | 15 +++++++++++++-
 lib/compat_audit.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 lib/compat_audit.c

-- 
1.8.3.2
