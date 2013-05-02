From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 May 2013 12:03:57 +0100
Subject: [PATCH v3 16/32] arm64: KVM: hypervisor initialization code
In-Reply-To: <1365437854-30214-17-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-17-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130502110356.GA10418@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:18PM +0100, Marc Zyngier wrote:
> Provide EL2 with page tables and stack, and set the vectors
> to point to the full blown world-switch code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  13 +++++
>  arch/arm64/kvm/hyp-init.S         | 112 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 arch/arm64/kvm/hyp-init.S
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index a0279ff..8655de4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -183,4 +183,17 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> +static inline void __cpu_init_hyp_mode(unsigned long long boot_pgd_ptr,
> +				       unsigned long long pgd_ptr,
> +				       unsigned long hyp_stack_ptr,
> +				       unsigned long vector_ptr)

Why some types are long long other others just long? Is it called from
arch/arm/ code? I would rather use phys_addr_t where relevant and
unsigned long where it means a virtual address.

-- 
Catalin
