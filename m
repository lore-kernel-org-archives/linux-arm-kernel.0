From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 08 Aug 2013 09:22:00 +0100
Subject: [PATCH v2] ARM: KVM: Fix 64-bit coprocessor handling
In-Reply-To: <1375814453-8425-1-git-send-email-christoffer.dall@linaro.org>
References: <1375814453-8425-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <52035528.4020509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/13 19:40, Christoffer Dall wrote:
> The PAR was exported as CRn == 7 and CRm == 0, but in fact the primary
> coprocessor register number was determined by CRm for 64-bit coprocessor
> registers as the user space API was modeled after the coprocessor
> access instructions (see the ARM ARM rev. C - B3-1445).
> 
> However, just changing the CRn to CRm breaks the sorting check when
> booting the kernel, because the internal kernel logic always treats CRn
> as the primary register number, and it makes the table sorting
> impossible to understand for humans.
> 
> Alternatively we could change the logic to always have CRn == CRm, but
> that becomes unclear in the number of ways we do look up of a coprocessor
> register.  We could also have a separate 64-bit table but that feels
> somewhat over-engineered.  Instead, keep CRn the primary representation
> of the primary coproc. register number in-kernel and always export the
> primary number as CRm as per the existing user space ABI.
> 
> Note: The TTBR registers just magically worked because they happened to
> follow the CRn(0) regs and were considered CRn(0) in the in-kernel
> representation.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

FWIW: Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
