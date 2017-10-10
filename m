From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Oct 2017 11:06:10 +0100
Subject: [PATCH v4 1/7] KVM: arm/arm64: Remove redundant preemptible checks
In-Reply-To: <1505513994-77939-2-git-send-email-christoffer.dall@linaro.org>
 (Christoffer Dall's message of "Fri, 15 Sep 2017 15:19:48 -0700")
References: <1505513994-77939-1-git-send-email-christoffer.dall@linaro.org>
 <1505513994-77939-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <87sheruxkd.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15 2017 at  3:19:48 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> From: Christoffer Dall <cdall@linaro.org>
>
> The __this_cpu_read() and __this_cpu_write() functions already implement
> checks for the required preemption levels when using
> CONFIG_DEBUG_PREEMPT which gives you nice error messages and such.
> Therefore there is no need to explicitly check this using a BUG_ON() in
> the code (which we don't do for other uses of per cpu variables either).
>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
> ---
>  virt/kvm/arm/arm.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a39a1e1..04313a2 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -69,7 +69,6 @@ static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
>  
>  static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
>  {
> -	BUG_ON(preemptible());
>  	__this_cpu_write(kvm_arm_running_vcpu, vcpu);
>  }
>  
> @@ -79,7 +78,6 @@ static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
>   */
>  struct kvm_vcpu *kvm_arm_get_running_vcpu(void)
>  {
> -	BUG_ON(preemptible());
>  	return __this_cpu_read(kvm_arm_running_vcpu);
>  }

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
