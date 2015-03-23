From: geoff@infradead.org (Geoff Levand)
Date: Mon, 23 Mar 2015 09:46:54 -0700
Subject: [RFC 1/4] arm64: kvm: add a cpu tear-down function
In-Reply-To: <1427111639-4575-2-git-send-email-takahiro.akashi@linaro.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
 <1427111639-4575-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427129214.27739.4.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

On Mon, 2015-03-23 at 20:53 +0900, AKASHI Takahiro wrote:
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 3e6859b..428f41c 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
...
> +phys_addr_t kvm_get_stub_vectors(void)
> +{
> +       return virt_to_phys(__hyp_stub_vectors);
> +}

The stub vectors are not part of KVM, but part of kernel,
so to me a routine get_hyp_stub_vectors() with a prototype
in asm/virt.h, then a definition in maybe
kernel/process.c, or a new file kernel/virt.c makes more
sense.

> +unsigned long kvm_reset_func_entry(void)
> +{
> +       /* VA of __kvm_hyp_reset in trampline code */
> +       return TRAMPOLINE_VA + (__kvm_hyp_reset - __hyp_idmap_text_start);
> +}
> +
>  int kvm_mmu_init(void)
>  {
>         int err;
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 4f7310f..97ee2fc 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -116,8 +116,11 @@
>  struct kvm;
>  struct kvm_vcpu;
>  
> +extern char __hyp_stub_vectors[];

I think this should at least be in asm/virt.h, or better,
have a get_hyp_stub_vectors().

>  extern char __kvm_hyp_init[];
>  extern char __kvm_hyp_init_end[];
> +extern char __kvm_hyp_reset[];
>  
>  extern char __kvm_hyp_vector[];
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 8ac3c70..97f88fe 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -199,6 +199,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
>  struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
>  
>  u64 kvm_call_hyp(void *hypfn, ...);
> +void kvm_call_reset(unsigned long reset_func, ...);

kvm_call_reset() takes a fixed number of args, so we shouldn't
have it as a variadic here.  I think a variadic routine
complicates things for my kvm_call_reset() suggestion below.

>  void force_vm_exit(const cpumask_t *mask);
>  void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>  
> @@ -223,6 +224,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>                      hyp_stack_ptr, vector_ptr);
>  }
>  
> +static inline void __cpu_reset_hyp_mode(unsigned long reset_func,
> +                                       phys_addr_t boot_pgd_ptr,
> +                                       phys_addr_t phys_idmap_start,
> +                                       unsigned long stub_vector_ptr)

> +       kvm_call_reset(reset_func, boot_pgd_ptr,
> +                      phys_idmap_start, stub_vector_ptr);

Why not switch the order of the args here to:

  kvm_call_reset(boot_pgd_ptr, phys_idmap_start, stub_vector_ptr, reset_func)

This will eliminate the register shifting in the HVC_RESET
hcall vector which becomes just 'br x3'.


> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index fd085ec..aee75f9 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -1136,6 +1136,11 @@ ENTRY(kvm_call_hyp)
>         ret
>  ENDPROC(kvm_call_hyp)
>  
> +ENTRY(kvm_call_reset)
> +       hvc     #HVC_RESET
> +       ret
> +ENDPROC(kvm_call_reset)
> +
>  .macro invalid_vector  label, target
>         .align  2
>  \label:
> @@ -1179,10 +1184,10 @@ el1_sync:                                       // Guest trapped into EL2
>         cmp     x18, #HVC_GET_VECTORS
>         b.ne    1f
>         mrs     x0, vbar_el2
> -       b       2f
> -
> -1:     /* Default to HVC_CALL_HYP. */

It seems you are deleting this comment and also
removing the logic that makes HVC_CALL_HYP the default.

> +       b       3f
>  
> +1:     cmp     x18, #HVC_CALL_HYP
> +       b.ne    2f
>         push    lr, xzr
>  
>         /*
> @@ -1196,7 +1201,23 @@ el1_sync:                                        // Guest trapped into EL2
>         blr     lr
>  
>         pop     lr, xzr
> -2:     eret
> +       b       3f
> +
> +       /*
> +        * shuffle the parameters and jump into trampline code.
> +        */
> +2:     cmp     x18, #HVC_RESET
> +       b.ne    3f
> +
> +       mov     x18, x0
> +       mov     x0, x1
> +       mov     x1, x2
> +       mov     x2, x3
> +       mov     x3, x4
> +       br      x18
> +       /* not reach here */
> +
> +3:     eret

We don't need to change labels for each new hcall, I
think just this is OK:

	cmp	x18, #HVC_GET_VECTORS
	b.ne	1f
	mrs	x0, vbar_el2
	b	2f

+1:	cmp	x18, #HVC_RESET
+	b.ne	1f
+	br	x3			// No return

1:	/* Default to HVC_CALL_HYP. */
	...

-Geoff
