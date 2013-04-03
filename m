From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Apr 2013 10:50:24 +0100
Subject: [PATCH 4/7] ARM: KVM: enforce page alignment for identity mapped
 code
In-Reply-To: <1364909115-3810-5-git-send-email-marc.zyngier@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130403095024.GC11040@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:25:12PM +0100, Marc Zyngier wrote:
> We're about to move to a init procedure where we rely on the
> fact that the init code fits in a single page. Make sure we
> align the idmap text on a page boundary, and that the code is
> not bigger than a single page.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kernel/vmlinux.lds.S | 2 +-
>  arch/arm/kvm/init.S           | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index b571484..d9dd265 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -20,7 +20,7 @@
>  	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
>  	*(.idmap.text)							\
>  	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
> -	ALIGN_FUNCTION();						\
> +	. = ALIGN(PAGE_SIZE);						\
>  	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
>  	*(.hyp.idmap.text)						\
>  	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 9f37a79..35a463f 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -111,4 +111,11 @@ __do_hyp_init:
>  	.globl __kvm_hyp_init_end
>  __kvm_hyp_init_end:
>  
> +	/*
> +	 * The above code *must* fit in a single page for the trampoline
> +	 * madness to work. Whoever decides to change it must make sure
> +	 * we map the right amount of memory for the trampoline to work.
> +	 * The line below ensures any breakage will get noticed.
> +	 */
> +	.org	__kvm_hyp_init + PAGE_SIZE
>  	.popsection

What effect does this have on the size of the kernel image? I'd expect the
idmap code to be pretty small, so aligning to a page might be overkill a lot
of the time.

Will
