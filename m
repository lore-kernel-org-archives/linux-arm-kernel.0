From: andre.przywara@linaro.org (Andre Przywara)
Date: Thu,  5 Dec 2013 16:10:21 +0100
Subject: [PATCH] ARM/KVM: inject data abort on unhandled memory access
Message-ID: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a KVM guest accesses memory that is outside its memory map (so no
MMIO and no RAM), KVM will return -ENOSYS to userland, causing QEMU
to do an abort() and kill the whole guest. This happens while
executing dmidecode on ARM, which mmaps /dev/mem and scans the first
Megabyte of memory for a DMI BIOS signature (sic!).
Of course this is silly, but in any case crashing the whole guest
does not seems appropriate.
So lets mimic native hardware's behavior in this case and inject a
Data Abort exception into the guest. In the previous case this will
crash dmidecode with SIGSEGV, but keeps the guest alive.

I am not sure if this too coarse grained, but I just wanted to start
discussion on this.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 arch/arm/kvm/mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 4cb5a93..04a105e 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -183,7 +183,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			return ret;
 	} else {
 		kvm_err("load/store instruction decoding not implemented\n");
-		return -ENOSYS;
+		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
+		return 1;
 	}
 
 	rt = vcpu->arch.mmio_decode.rt;
-- 
1.7.12.1
