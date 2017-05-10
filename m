From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 May 2017 11:23:06 +0100
Subject: [PATCH] KVM: arm/arm64: Simplify active_change_prepare and plug
 race
In-Reply-To: <20170510100118.4189-1-cdall@linaro.org>
References: <20170510100118.4189-1-cdall@linaro.org>
Message-ID: <ab9a2195-6940-63ab-2ea6-a7a314253f2c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/17 11:01, Christoffer Dall wrote:
> We don't need to stop a specific VCPU when changing the active state,
> because private IRQs can only be modified by a running VCPU for the
> VCPU itself and it is therefore already stopped.
> 
> However, it is also possible for two VCPUs to be modifying the active
> state of SPIs at the same time, which can cause the thread being stuck
> in the loop that checks other VCPU threads for a potentially very long
> time, or to modify the active state of a running VCPU.  Fix this by
> serializing all accesses to setting and clearing the active state of
> interrupts using the KVM mutex.
> 
> Reported-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
