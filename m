From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 18:33:19 +0000
Subject: [PATCH v5 08/14] KVM: ARM: Emulation framework and CP15 emulation
In-Reply-To: <CANM98qJpbrOsDcDmcGJp6fogLZHCFxghDg6zMXyt8jaXzm1QsA@mail.gmail.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183931.46302.60921.stgit@ubuntu>
 <20130114163636.GG23505@n2100.arm.linux.org.uk>
 <CANM98qJpbrOsDcDmcGJp6fogLZHCFxghDg6zMXyt8jaXzm1QsA@mail.gmail.com>
Message-ID: <20130114183319.GM23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 12:38:17PM -0500, Christoffer Dall wrote:
> On Mon, Jan 14, 2013 at 11:36 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jan 08, 2013 at 01:39:31PM -0500, Christoffer Dall wrote:
> >> +     /*
> >> +      * Check whether this vcpu requires the cache to be flushed on
> >> +      * this physical CPU. This is a consequence of doing dcache
> >> +      * operations by set/way on this vcpu. We do it here to be in
> >> +      * a non-preemptible section.
> >> +      */
> >> +     if (cpumask_test_cpu(cpu, &vcpu->arch.require_dcache_flush)) {
> >> +             cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
> >
> > There is cpumask_test_and_clear_cpu() which may be better for this.
> 
> nice:
> 
> commit d31686fadb74ad564f6a5acabdebe411de86d77d
> Author: Christoffer Dall <c.dall@virtualopensystems.com>
> Date:   Mon Jan 14 12:36:53 2013 -0500
> 
>     KVM: ARM: Use cpumask_test_and_clear_cpu
> 
>     Nicer shorter cleaner code. Ahhhh.
> 
>     Cc: Russell King <linux@arm.linux.org.uk>

Great, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

>     Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index b5c6ab1..fdd4a7c 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -352,10 +352,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	 * operations by set/way on this vcpu. We do it here to be in
>  	 * a non-preemptible section.
>  	 */
> -	if (cpumask_test_cpu(cpu, &vcpu->arch.require_dcache_flush)) {
> -		cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
> +	if (cpumask_test_and_clear_cpu(cpu, &vcpu->arch.require_dcache_flush))
>  		flush_cache_all(); /* We'd really want v7_flush_dcache_all() */
> -	}
> 
>  	kvm_arm_set_running_vcpu(vcpu);
>  }
> 
> --
> 
> Thanks,
> -Christoffer
