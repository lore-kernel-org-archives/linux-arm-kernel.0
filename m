From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 10 Sep 2018 11:42:39 +0100
Subject: [PATCH v3 0/9] ARM: spectre-v1.1 mitigations
Message-ID: <1536576168-40096-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The series provides mitigations for spectre-v1.1. It is mostly mirroring
what Russell did [1], but this time for writes to user provided addresses.

* Patches 1-5 replace some __put_user_error calls with __copy_to_user, this
  both reduces the number of time address sanitizing is performed and also
  the number of time PAN needs to be toggled.

* Patches 6-9 ensure user addresses used by __put_user* and
  __copy_to_user functions are sanitized before being used.

Changes since v2[2]:
- Ensure padding in vfp_sigframe is properly initialized
- Fix incorrect copy of oabi events

Changes since v1[3]:
- Fixed off-by-one error in uaccess_mask_range_ptr, spotted by Russell
- Remove remaining calls to __put_user_error() and get rid of the macro
- Reorder the patches to better reflect the spectre-v1 series

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/589869.html
[2] https://www.spinics.net/lists/arm-kernel/msg674995.html
[3] https://www.spinics.net/lists/arm-kernel/msg671026.html

Cheers,

Julien


Julien Thierry (9):
  ARM: signal: copy registers using __copy_to_user()
  ARM: signal: always use __copy_to_user to save iwmmxt context
  ARM: vfp: use __copy_to_user() when saving VFP state
  ARM: oabi-compat: copy oabi events using __copy_to_user()
  ARM: signal: replace __put_user_error with __put_user
  ARM: uaccess: Prevent speculative use of the current addr_limit
  ARM: spectre-v1.1: use put_user() for __put_user()
  ARM: spectre-v1,v1.1: provide helpers for address sanitization
  ARM: spectre-v1.1: harden __copy_to_user

 arch/arm/include/asm/assembler.h   | 11 ++++++
 arch/arm/include/asm/thread_info.h |  4 +-
 arch/arm/include/asm/uaccess.h     | 49 ++++++++++++++++++++---
 arch/arm/kernel/signal.c           | 80 +++++++++++++++++++++-----------------
 arch/arm/kernel/sys_oabi-compat.c  |  8 +++-
 arch/arm/lib/copy_from_user.S      |  6 +--
 arch/arm/lib/copy_to_user.S        |  6 ++-
 arch/arm/lib/uaccess_with_memcpy.c |  3 +-
 arch/arm/vfp/vfpmodule.c           | 20 ++++------
 9 files changed, 122 insertions(+), 65 deletions(-)

--
1.9.1
