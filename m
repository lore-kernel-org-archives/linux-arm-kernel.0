From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Apr 2016 15:02:02 +0100
Subject: [RFC PATCH] arm64: Fix EL1/EL2 early init inconsistencies with VHE
In-Reply-To: <1461002246-25314-1-git-send-email-Dave.Martin@arm.com>
References: <1461002246-25314-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <5718DD5A.2050800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 18/04/16 18:57, Dave Martin wrote:
> When using the Virtualisation Host Extensions, EL1 is not used in
> the host and requires no separate configuration.
> 
> In addition, with VHE enabled, non-hyp-specific EL2 configuration
> that does not need to be done early will be done anyway in
> __cpu_setup via the _EL1 system register aliases.  In particular,
> the layout and definition of CPTR_EL2 are changed by enabling VHE
> so that they resemble CPACR_EL1, so existing code to initialise
> CPTR_EL2 becomes architecturally wrong in this case.
> 
> This patch simply skips the affected initialisation code in the
> non-VHE case.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
> 
> Note -- not tested yet, and I'm still unclear on whether this is the
> correct architectural approach...

This looks correct to me. Given that we're not leaving EL2, there is no
reason to do things earlier than they are done at EL1, and this fixes an
obvious bug on CPTR_EL2 access.

I've given it a go on a VHE model, and it ran just fine, so:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
