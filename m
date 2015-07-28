From: msalter@redhat.com (Mark Salter)
Date: Tue, 28 Jul 2015 10:32:39 -0400
Subject: [PATCH 0/2] arm64: support initrd outside of mapped RAM
Message-ID: <1438093961-15536-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting an arm64 kernel w/initrd using UEFI/grub, use of mem= will likely
cut off part or all of the initrd. This leaves it outside the kernel linear
map which leads to failure when unpacking. The x86 code has a similar need to
relocate an initrd outside of mapped memory in some cases.

The current x86 code uses early_memremap() to copy the original initrd from
unmapped to mapped RAM. This patchset creates a generic copy_from_early_mem()
utility based on that x86 code and has arm64 use it to relocate the initrd
if necessary.

Mark Salter (2):
  mm: add utility for early copy from unmapped ram
  arm64: support initrd outside kernel linear map

 arch/arm64/kernel/setup.c           | 55 +++++++++++++++++++++++++++++++++++++
 include/asm-generic/early_ioremap.h |  6 ++++
 mm/early_ioremap.c                  | 22 +++++++++++++++
 3 files changed, 83 insertions(+)

-- 
2.4.3
