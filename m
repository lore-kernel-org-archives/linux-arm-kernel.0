From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jun 2018 13:49:51 +0100
Subject: [PATCH 6/8] KVM: arm/arm64: add WARN_ON if size is not PAGE_SIZE
 aligned in unmap_stage2_range
In-Reply-To: <20180622124953.12355-1-marc.zyngier@arm.com>
References: <20180622124953.12355-1-marc.zyngier@arm.com>
Message-ID: <20180622124953.12355-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jia He <hejianet@gmail.com>

There is a panic in armv8a server(QDF2400) under memory pressure tests
(start 20 guests and run memhog in the host).

---------------------------------begin--------------------------------
[35380.800950] BUG: Bad page state in process qemu-kvm  pfn:dd0b6
[35380.805825] page:ffff7fe003742d80 count:-4871 mapcount:-2126053375
mapping:          (null) index:0x0
[35380.815024] flags: 0x1fffc00000000000()
[35380.818845] raw: 1fffc00000000000 0000000000000000 0000000000000000
ffffecf981470000
[35380.826569] raw: dead000000000100 dead000000000200 ffff8017c001c000
0000000000000000
[35380.805825] page:ffff7fe003742d80 count:-4871 mapcount:-2126053375
mapping:          (null) index:0x0
[35380.815024] flags: 0x1fffc00000000000()
[35380.818845] raw: 1fffc00000000000 0000000000000000 0000000000000000
ffffecf981470000
[35380.826569] raw: dead000000000100 dead000000000200 ffff8017c001c000
0000000000000000
[35380.834294] page dumped because: nonzero _refcount
[...]
--------------------------------end--------------------------------------

The root cause might be what was fixed at [1]. But from the KVM points of
view, it would be better if the issue was caught earlier.

If the size is not PAGE_SIZE aligned, unmap_stage2_range might unmap the
wrong(more or less) page range. Hence it caused the "BUG: Bad page
state"

Let's WARN in that case, so that the issue is obvious.

[1] https://lkml.org/lkml/2018/5/3/1042

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: jia.he at hxt-semitech.com
[maz: tidied up commit message]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 8d90de213ce9..1d90d79706bd 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -297,6 +297,8 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
 	phys_addr_t next;
 
 	assert_spin_locked(&kvm->mmu_lock);
+	WARN_ON(size & ~PAGE_MASK);
+
 	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
 	do {
 		/*
-- 
2.17.1
