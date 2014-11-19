From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Nov 2014 11:36:56 +0000
Subject: [PATCH] arm/arm64: KVM: Handle traps of ICC_SRE_EL1 as RAZ/WI
In-Reply-To: <1416396234-6887-1-git-send-email-ard.biesheuvel@linaro.org> (Ard
 Biesheuvel's message of "Wed, 19 Nov 2014 11:23:54 +0000")
References: <1416396234-6887-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <87oas3bew7.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19 2014 at 11:23:54 am GMT, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
>
> When running on a system with a GICv3, we currenly don't allow the guest
> to access the system register interface of the GICv3.  We do this by
> clearing the ICC_SRE_EL2.Enable, which causes all guest accesses to
> ICC_SRE_EL1 to trap to EL2 and causes all guest accesses to other ICC_
> registers to cause an undefined exception in the guest.
>
> However, we currently don't handle the trap of guest accesses to
> ICC_SRE_EL1 and will spill out a warning.  The trap just needs to handle
> the access as RAZ/WI, and a guest that tries to prod this register and
> set ICC_SRE_EL1.SRE=1, must read back the value (which Linux already
> does) to see if it succeeded, and will thus observe that ICC_SRE_EL1.SRE
> was not set.
>
> Add the simple trap handler in the sorted table of the system registers.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> [ardb: added cp15 handling]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v3: add handling for 32-bit *guests* not 32-bit hosts

Looks good to me. I'll queue it up as a fix for the next RC.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
