From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 10:05:43 +0100
Subject: [PATCH v6 14/15] KVM: arm64: Fold redundant exit code checks out
 of fixup_guest_exit()
In-Reply-To: <1525797900-5548-15-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-15-git-send-email-Dave.Martin@arm.com>
Message-ID: <b418f004-6c1c-fc97-5600-7ccbb07e9f08@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> The entire tail of fixup_guest_exit() is contained in if statements
> of the form if (x && *exit_code == ARM_EXCEPTION_TRAP).  As a result,
> we can check just once and bail out of the function early, allowing
> the remaining if conditions to be simplified.
> 
> The only awkward case is where *exit_code is changed to
> ARM_EXCEPTION_EL1_SERROR in the case of an illegal GICv2 CPU
> interface access: in that case, the GICv3 trap handling code is
> skipped using a goto.  This avoids pointlessly evaluating the
> static branch check for the GICv3 case, even though we can't have
> vgic_v2_cpuif_trap and vgic_v3_cpuif_trap true simultaneously
> unless we have a GICv3 and GICv2 on the host: that sounds stupid,
> but I haven't satisfied myself that it can't happen.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
