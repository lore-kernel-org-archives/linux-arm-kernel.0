From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Dec 2010 17:39:22 +0000
Subject: [RFC 2/2] Selective MMU identity mapping for kexec
In-Reply-To: <1288636375-22805-3-git-send-email-per.xx.fransson@stericsson.com>
References: <1288636375-22805-1-git-send-email-per.xx.fransson@stericsson.com>
	<1288636375-22805-3-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <1292434762.2926.7.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Per,

It's nice to see somebody looking at this!

On Mon, 2010-11-01 at 19:32 +0100, Per Fransson wrote:
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> ---
>  arch/arm/kernel/machine_kexec.c   |   27 +++++++++++++++++++++-
>  arch/arm/kernel/relocate_kernel.S |   23 +++++++++++++++++++
>  arch/arm/mm/mmu.c                 |   44 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mm/proc-v7.S             |    1 +
>  4 files changed, 94 insertions(+), 1 deletions(-)

Some parts of this patchset will be useful for implementing CPU hotplug
on the ARM RealView boards. The idea is to throw cores back to the
bootloader when they are offlined, so we need to be able to disable the
MMU safely before we jump.

> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 3a8fd51..d5bb12f 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -17,12 +17,20 @@ extern const unsigned char relocate_new_kernel[];
>  extern const unsigned int relocate_new_kernel_size;
>  
>  extern void setup_mm_for_reboot(char mode);
> +extern void identity_map(unsigned long, pgd_t*, pgd_t**);

[...]

> +	cpu_reset_phys = virt_to_phys(cpu_reset);
> +	identity_map(cpu_reset_phys, &kexec_mmu_ents[0].store,
> +		     &kexec_mmu_ents[0].ptr);
> +	identity_map(((char *)cpu_reset_phys)+PGDIR_SIZE,
> +		     &kexec_mmu_ents[1].store, &kexec_mmu_ents[1].ptr);

I think this could become common code as calling cpu_reset will require
the identity map to be in place now that you have added MMU disable code
there.

> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index b249143..37ee55b 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -61,6 +61,7 @@ ENDPROC(cpu_v7_proc_fin)
>   */
>  	.align	5
>  ENTRY(cpu_v7_reset)
> +	sub	pc, pc, #PAGE_OFFSET+4		@ go to physical addresses
>  	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
>  	bic	ip, ip, #0x0001			@ ...............m
>  	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register

I'm not too keen on modifying the PC directly here. It also won't
compile for Thumb2. How about invoking the function using the 1:1
mapping instead? I think casting its physical address to a function
pointer will cause the compiler to generate any trampolines that are
needed.

Cheers,

Will
