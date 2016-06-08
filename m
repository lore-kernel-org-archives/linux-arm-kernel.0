From: james.morse@arm.com (James Morse)
Date: Wed,  8 Jun 2016 17:24:45 +0100
Subject: [PATCH] KVM: arm/arm64: Stop leaking vcpu pid references
Message-ID: <1465403085-2358-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm provides kvm_vcpu_uninit(), which amongst other things, releases the
last reference to the struct pid of the task that was last running the vcpu.

On arm64 built with CONFIG_DEBUG_KMEMLEAK, starting a guest with kvmtool,
then killing it with SIGKILL results (after some considerable time) in:
> cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff80007d5ea080 (size 128):
>  comm "lkvm", pid 2025, jiffies 4294942645 (age 1107.776s)
>  hex dump (first 32 bytes):
>    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  backtrace:
>    [<ffff8000001b30ec>] create_object+0xfc/0x278
>    [<ffff80000071da34>] kmemleak_alloc+0x34/0x70
>    [<ffff80000019fa2c>] kmem_cache_alloc+0x16c/0x1d8
>    [<ffff8000000d0474>] alloc_pid+0x34/0x4d0
>    [<ffff8000000b5674>] copy_process.isra.6+0x79c/0x1338
>    [<ffff8000000b633c>] _do_fork+0x74/0x320
>    [<ffff8000000b66b0>] SyS_clone+0x18/0x20
>    [<ffff800000085cb0>] el0_svc_naked+0x24/0x28
>    [<ffffffffffffffff>] 0xffffffffffffffff

On x86 kvm_vcpu_uninit() is called on the path from kvm_arch_destroy_vm(),
on arm no equivalent call is made. Add the call to kvm_arch_vcpu_free().

Signed-off-by: James Morse <james.morse@arm.com>
Fixes: 749cf76c5a36 ("KVM: ARM: Initial skeleton to compile KVM support")
Cc: <stable@vger.kernel.org> # 3.10+
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 893941ec98dc..f1bde7c4e736 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -263,6 +263,7 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 	kvm_timer_vcpu_terminate(vcpu);
 	kvm_vgic_vcpu_destroy(vcpu);
 	kvm_pmu_vcpu_destroy(vcpu);
+	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
-- 
2.8.0.rc3
