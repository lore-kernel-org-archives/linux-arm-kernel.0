From: julien.thierry@arm.com (Julien Thierry)
Date: Thu,  9 Aug 2018 16:26:35 +0100
Subject: [PATCH 0/8] ARM: spectre-v1.1 mitigations
Message-ID: <1533828403-21323-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series applies on top of Russell's latest spectre variant 1
mitigations [1],

This is mostly mirroring what Russell did, but this time for writes to
user provided addresses.

* Patches 1-4 ensure user addresses used by __put_user* and
  __copy_to_user functions are sanitized before being used.

* Patches 5-8 replace some __put_user_error calls with __copy_to_user, this
  both reduces the number of time address sanitizing is performed and also
  the number of time PAN needs to be toggled.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/589869.html

Cheers,

Julien

-->

Julien Thierry (8):
  ARM: uaccess: Prevent speculative use of the current addr_limit
  ARM: spectre-v1.1: force address sanitizing for __put_user*()
  ARM: spectre-v1,v1.1: provide helpers for address sanitization
  ARM: spectre-v1.1: harden __copy_to_user
  ARM: signal: copy registers using __copy_to_user()
  ARM: signal: always use __copy_to_user to save iwmmxt context
  ARM: vfp: use __copy_to_user() when saving VFP state
  ARM: oabi-compat: copy oabi events using __copy_to_user()

 arch/arm/include/asm/assembler.h   | 10 ++++++
 arch/arm/include/asm/thread_info.h |  4 +--
 arch/arm/include/asm/uaccess.h     | 48 ++++++++++++++++++++++++++
 arch/arm/kernel/signal.c           | 71 +++++++++++++++++++++-----------------
 arch/arm/kernel/sys_oabi-compat.c  | 10 +++---
 arch/arm/lib/copy_from_user.S      |  6 +---
 arch/arm/lib/copy_to_user.S        |  6 +++-
 arch/arm/lib/uaccess_with_memcpy.c |  3 +-
 arch/arm/vfp/vfpmodule.c           | 20 +++++------
 9 files changed, 119 insertions(+), 59 deletions(-)

--
1.9.1
