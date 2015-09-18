From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 17 Sep 2015 18:05:15 -0700
Subject: [PATCH 0/2] KVM/arm: add fp/simd lazy switch support
Message-ID: <1442538317-13618-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches enable armv7 fp/simd lazy switch. On guest entry fp/simd
access trap is set, and on guest first access fp/simd registers are switched -
host saved, guest restored. CPU continues with guest fp/simd content until
vcpu_put where guest is saved and host is restored. 

Running floating point workload illustrates reduction of fp/simd context 
switches the amount depends on the load. For a light load with with FP 
application running only 2% of all exits result in calls to lazy switch.

arm64 version is in test and appears to work fine, remaining work is
boot arm32 guest on arm64 and verify operation. Initial intent was to post
all patches at once, but arm64 version will be posted soon.

Mario Smarduch (2):
  add hooks for armv7 vfp/simd lazy switch support
  enable armv7 vfp/simd lazy switch

 arch/arm/include/asm/kvm_asm.h  |  1 +
 arch/arm/include/asm/kvm_host.h |  3 +++
 arch/arm/kernel/asm-offsets.c   |  1 +
 arch/arm/kvm/arm.c              | 17 +++++++++++++++++
 arch/arm/kvm/interrupts.S       | 40 +++++++++++++++++++++++++++++-----------
 5 files changed, 51 insertions(+), 11 deletions(-)

-- 
1.9.1
