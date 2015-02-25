From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 25 Feb 2015 15:36:18 +0000
Subject: [PATCH 0/4] KVM ARM64 Migration Fixes
Message-ID: <1424878582-26397-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches fix a number of bugs that were being exposed
when attempting migration with arm64 KVM. Together with some fixes to
QEMU (github.com/stsquad/qemu/tree/migration/fixes-v2) I have
successfully run 500 migrations each on:

  * aarch64 kernel, aarch64 user-space
  * aarch64 kernel, armhf user-space
  * aarch32 kernel, armhf user-space

The various images for testing can be found in:

  people.linaro.org/~alex.bennee/images
  people.linaro.org/~alex.bennee/testcases/arm64.migration

And the expect script in:

  git.linaro.org/people/alex.bennee/test-definitions.git
  branch: migration-tests
  file: ubuntu/scripts/qemu-file-migrate.expect

The active IRQ patch has two checkpatch failures:
  - brace style, consistent with other declarations I was adding to
  - use of kzalloc over kcalloc, consistent with other allocs

This patch series has been re-based and re-tested against 4.0-rc1

The branch I've been working with can be found at:

  http://git.linaro.org/people/alex.bennee/linux.git
  branch: migration/kvmarm-fixes-for-4.0

It includes the two patches from the current kvmarm/master branch.

Cheers,

Alex.

Alex Benn?e (1):
  arm: KVM: export vcpi->pause state via MP_STATE ioctls

Christoffer Dall (3):
  arm/arm64: KVM: Implement support for unqueueing active IRQs
  arm/arm64: KVM: Fix migration race in the arch timer
  arm/arm64: KVM: Keep elrsr/aisr in sync with software model

 Documentation/virtual/kvm/api.txt |  24 +++-
 arch/arm/kvm/arm.c                |  23 +++-
 include/kvm/arm_arch_timer.h      |   7 ++
 include/kvm/arm_vgic.h            |  16 ++-
 virt/kvm/arm/arch_timer.c         |  45 +++++--
 virt/kvm/arm/vgic-v2-emul.c       |  20 +++-
 virt/kvm/arm/vgic-v2.c            |   8 ++
 virt/kvm/arm/vgic-v3.c            |   8 ++
 virt/kvm/arm/vgic.c               | 245 +++++++++++++++++++++++++++++++-------
 virt/kvm/arm/vgic.h               |   8 ++
 10 files changed, 342 insertions(+), 62 deletions(-)

-- 
2.3.0
