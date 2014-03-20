From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 20 Mar 2014 16:57:06 -0700
Subject: [PATCH v2] KVM: ARM: vgic: plug irq injection race
In-Reply-To: <1395334035-15454-1-git-send-email-marc.zyngier@arm.com>
References: <1395334035-15454-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140320235706.GW1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 04:47:15PM +0000, Marc Zyngier wrote:
> As it stands, nothing prevents userspace from injecting an interrupt
> before the guest's GIC is actually initialized.
> 
> This goes unnoticed so far (as everything is pretty much statically
> allocated), but ends up exploding in a spectacular way once we switch
> to a more dynamic allocation (the GIC data structure isn't there yet).
> 
> The fix is to test for the "ready" flag in the VGIC distributor before
> trying to inject the interrupt. Note that in order to avoid breaking
> userspace, we have to ignore what is essentially an error.
> 
> Also, move the setting of the flag out of the critical section,
> which will ensure the visibility of the initialized data-structure
> before the flag is actually set.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
