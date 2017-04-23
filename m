From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:29 +0200
Subject: [PULL 79/79] ARM: KVM: Fix idmap stub entry when running Thumb-2 code
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-80-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When entering the hyp stub implemented in the idmap, we try to
be mindful of the fact that we could be running a Thumb-2 kernel
by adding 1 to the address we compute. Unfortunately, the assembler
also knows about this trick, and has already generated an address
that has bit 0 set in the litteral pool.

Our superfluous correction ends up confusing the CPU entierely,
as we now branch to the stub in ARM mode instead of Thumb, and on
a possibly unaligned address for good measure. From that point,
nothing really good happens.

The obvious fix in to remove this stupid target PC correction.

Fixes: 6bebcecb6c5b ("ARM: KVM: Allow the main HYP code to use the init hyp stub implementation")
Reported-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/kvm/hyp/hyp-entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index a35baa8..95a2fae 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -144,7 +144,6 @@ hyp_hvc:
 	ldr	r1, [r1]
 	ldr	ip, =__kvm_handle_stub_hvc
 	sub	ip, ip, r1
-THUMB(	add	ip, ip, #1)
 	pop	{r1}
 
 	bx	ip
-- 
2.9.0
