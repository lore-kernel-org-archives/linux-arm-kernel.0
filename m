From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:05:02 +0100
Subject: [PATCH v4 01/40] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
In-Reply-To: <20180215210332.8648-2-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-2-christoffer.dall@linaro.org>
Message-ID: <20180221170502.5czjqewvmmprp4bm@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:02:53PM +0100, Christoffer Dall wrote:
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
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/guest.c | 3 ---
>  virt/kvm/arm/arm.c     | 9 ---------
>  2 files changed, 12 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
