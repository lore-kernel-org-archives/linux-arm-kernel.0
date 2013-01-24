From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jan 2013 15:45:35 +0000
Subject: [PATCH v6 04/15] KVM: ARM: Hypervisor initialization
In-Reply-To: <20130116175748.29147.91246.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175748.29147.91246.stgit@ubuntu>
Message-ID: <20130124154535.GD18233@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:57:48PM +0000, Christoffer Dall wrote:
> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -32,6 +32,9 @@
>  #define PMD_TYPE_SECT          (_AT(pmdval_t, 1) << 0)
>  #define PMD_BIT4               (_AT(pmdval_t, 0))
>  #define PMD_DOMAIN(x)          (_AT(pmdval_t, 0))
> +#define PMD_APTABLE_SHIFT      (61)
> +#define PMD_APTABLE            (_AT(pgdval_t, 3) << PGD_APTABLE_SHIFT)
> +#define PMD_PXNTABLE           (_AT(pgdval_t, 1) << 59)

Are these used anywhere? I grep'ed but couldn't find. While I'm fine
with keeping some hardware definitions for future use, I think here you
need to qualify these bits with some suffix to PMD_APTABLE. The APTable
are just a group of bits with different meaning (no write access etc.).
If you want to keep them as group of bits, you can add a _MASK suffix.

> +static int init_hyp_mode(void)
> +{
> +       phys_addr_t init_phys_addr;
> +       int cpu;
> +       int err = 0;
> +
> +       /*
> +        * Allocate Hyp PGD and setup Hyp identity mapping
> +        */
> +       err = kvm_mmu_init();
> +       if (err)
> +               goto out_err;

The comment is a bit misleading since kvm_mmu_init() simply checks
whether hyp_pgd has been initialised. The actual initialisation is done
by the idmap code.

-- 
Catalin
