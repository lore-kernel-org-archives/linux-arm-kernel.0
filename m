From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Jun 2018 10:42:49 +0100
Subject: [PATCH 0/2] KVM: Fix !KVM_COMPAT ioctl behaviour
Message-ID: <20180619094251.8586-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland recently pointed out that a couple of issues with the way
we deal with compat tasks:

1) arm64 unexpectedly selects KVM_COMPAT, while offering no way for a
   32bit userspace to change any register

2) Even deselecting KVM_COMPAT, we end-up with compat_ioctl being NULL,
   and the VFS behaviour is thus to call the non-compat ioctl

(1) is completely unintentional and should be fixed. (2) is quite odd,
and probably just as unintentional. This series fixes it by installing
a compat_ioctl callback whose only job is to return -EINVAL.

Tested on arm64 with a 32bit kvmtool.

Marc Zyngier (2):
  KVM: Enforce error in ioctl for compat tasks when !KVM_COMPAT
  KVM: arm64: Prevent KVM_COMPAT from being selected

 virt/kvm/Kconfig    |  2 +-
 virt/kvm/kvm_main.c | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.17.1
