From: julien.grall@arm.com (Julien Grall)
Date: Mon, 5 Feb 2018 12:32:33 +0000
Subject: [PATCH v3 01/41] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
In-Reply-To: <20180112120747.27999-2-christoffer.dall@linaro.org>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
 <20180112120747.27999-2-christoffer.dall@linaro.org>
Message-ID: <f4e5f966-24bb-630d-9d3f-907850d7e29d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 12/01/18 12:07, Christoffer Dall wrote:
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
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall
