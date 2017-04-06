From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 6 Apr 2017 17:49:05 +0100
Subject: [PATCH v3 3/5] KVM: arm/arm64: Support arch timers with a
 userspace gic
In-Reply-To: <20170405092815.22503-4-cdall@linaro.org>
References: <20170405092815.22503-1-cdall@linaro.org>
 <20170405092815.22503-4-cdall@linaro.org>
Message-ID: <baaf0d40-222b-633e-77b6-75fc61f3e0ed@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/17 10:28, Christoffer Dall wrote:
> From: Alexander Graf <agraf@suse.de>
> 
> If you're running with a userspace gic or other interrupt constroller

controller

> (that is no vgic in the kernel), then you have so far not been able to
> use the architected timers, because the output of the architected
> timers, which are driven inside the kernel, was a kernel-only construct
> between the arch timer code and the vgic.
> 
> This patch implements the new KVM_CAP_ARM_USER_IRQ feature, where we use a
> side channel on the kvm_run structure, run->s.regs.device_irq_level, to
> always notify userspace of the timer output levels when using a userspace
> irqchip.
> 
> This works by ensureing that before we enter the guest, if the timer

ensuring

> output level has changed compared to what we last told userspace, we
> don't enter the guest, but instead return to userspace to notify it of
> the new level.  If we are exiting, because of an MMIO for example, and
> the level changed at the same time, the value is also updated and
> userspace can sample the line as it needs.  This is nicely achieved
> simply always updating the timer_irq_level field after the main run
> loop.
> 
> Note that the kvm_timer_update_irq trace event is changed to show the
> host IRQ number for the timer instead of the guest IRQ number, because
> the kernel no longer know which IRQ userspace wires up the timer signal
> to.
> 
> Also note that this patch implements all required functionality but does
> not yet advertise the capability.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Otherwise looks good.

	M.
-- 
Jazz is not dead. It just smells funny...
