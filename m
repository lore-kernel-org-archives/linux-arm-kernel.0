From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 6 Feb 2017 09:33:08 +0000
Subject: [PATCH] irqchip/gicv3: Fix GICR_WAKE & GICD_IGROUPR accesses from
 non-secure
In-Reply-To: <1486347465-28316-1-git-send-email-shankerd@codeaurora.org>
References: <1486347465-28316-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <fd1d435d-28e8-117b-4794-886b11a7454c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On 06/02/17 02:17, Shanker Donthineni wrote:
> On systems where it supports two security states, both the register
> GICR_WAKE and GICD_IGROUPR accesses are RAZ/WI from non-secure.
> The function gic_enable_redist() to wake/sleep redistributor is not
> harmful at all, but it is confusing looking at the code. The current
> code checks the single security state based on bit GICD_CTLR.DS which
> is absolutely incorrect. The disable security bit GICD_CTLR.DS is RAZ
> to non-secure.

I'm afraid we don't have the same definition of GICD_CTLR.DS. In my copy
of the architecture spec, it says:

"When this field is set to 1, all accesses to GICD_CTLR access the
single Security state view, and all bits are accessible".
                                ^^^^^^^^^^^^^^^^^^^^^^^

This would tend to support my interpretation that once DS has been set
from the secure side, it becomes visible to all type of accesses.

> The GICD_TYPE.SecurityExtn indicates whether the GIC
> implementation supports two security states or only one security
> state.

Yes, and that's orthogonal to having set DS or not.

So clearly, we have a difference of interpretation. What part of the
spec is supporting yours?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
