From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 7 Mar 2018 13:01:21 +0000
Subject: [PATCH v5 01/40] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
In-Reply-To: <20180227113429.637-2-cdall@kernel.org>
References: <20180227113429.637-1-cdall@kernel.org>
 <20180227113429.637-2-cdall@kernel.org>
Message-ID: <2031649b-1327-861c-0086-cb7ac9ab640d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/18 11:33, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Calling vcpu_load() registers preempt notifiers for this vcpu and calls
> kvm_arch_vcpu_load().  The latter will soon be doing a lot of heavy
> lifting on arm/arm64 and will try to do things such as enabling the
> virtual timer and setting us up to handle interrupts from the timer
> hardware.
> 
> Loading state onto hardware registers and enabling hardware to signal
> interrupts can be problematic when we're not actually about to run the
> VCPU, because it makes it difficult to establish the right context when
> handling interrupts from the timer, and it makes the register access
> code difficult to reason about.
> 
> Luckily, now when we call vcpu_load in each ioctl implementation, we can
> simply remove the call from the non-KVM_RUN vcpu ioctls, and our
> kvm_arch_vcpu_load() is only used for loading vcpu content to the
> physical CPU when we're actually going to run the vcpu.
> 
> Reviewed-by: Julien Grall <julien.grall@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
I've queued this patch for 4.16-rc5 as part of the reset fix.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
