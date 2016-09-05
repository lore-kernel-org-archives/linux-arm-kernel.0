From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon,  5 Sep 2016 18:25:46 +0100
Subject: [PATCH v2 0/2] arm64: Use static keys for CPU features
Message-ID: <1473096348-19548-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is aimed at optimising the arm64 cpus_have_cap()
functionality (checking for the presence of certain CPU
capabilities/features) to avoid a bitmap test and use a jump label
instead, patched at boot time.

While this series does not provide a significant performance improvement
with the current kernel, it will be more beneficial with new features
like TTBR0 PAN are which are used on hot paths (get_user/put_user,
thread switching).

Jon, if you are happy with this patch (especially the documentation
update), are ok for it to go into mainline via the arm64 tree?

While there doesn't seem to be a specific maintainer for jump_label.*,
cc'ing Peter and Jason for comments/acks/naks.

Thanks.

Changes since v1:
- Moved the jump_label_init() call to smp_prepare_boot_cpu() following
  Suzuki's suggestion
- Fixed missing empty line in Documentation/static-keys.txt

Catalin Marinas (2):
  jump_labels: Allow array initialisers
  arm64: Use static keys for CPU features

 Documentation/static-keys.txt       |  9 +++++++++
 arch/arm64/include/asm/cpufeature.h | 14 +++++++++++---
 arch/arm64/kernel/cpufeature.c      |  3 +++
 arch/arm64/kernel/smp.c             |  5 +++++
 include/linux/jump_label.h          | 12 ++++++++++++
 5 files changed, 40 insertions(+), 3 deletions(-)
