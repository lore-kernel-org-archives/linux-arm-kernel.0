From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Jul 2012 22:36:02 +0100
Subject: [PATCH] arm: Use phys_addr_t to hold sizes in arm_add_memory and
 struct membank
In-Reply-To: <1341850565-29191-1-git-send-email-peter.maydell@linaro.org>
References: <1341850565-29191-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <20120709213602.GA8004@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Jul 09, 2012 at 05:16:05PM +0100, Peter Maydell wrote:
> The memory regions which are passed to arm_add_memory() from
> device tree blobs via early_init_dt_add_memory_arch() can
> have sizes which are larger than will fit in a 32 bit integer,
> so switch to using a phys_addr_t to hold them, to avoid
> silently dropping the top 32 bits of the size.

I think originally the 32-bit size limitation came about due to the mem64
atag but, with the introduction of devicetree, that never made it into
mainline so it seems like something we should fix. Thanks.

Couple of minor comments inline.

> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e15d83b..3f62dd1 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -508,7 +508,7 @@ void __init dump_machine_table(void)
>  		/* can't use cpu_relax() here as it may require MMU setup */;
>  }
>  
> -int __init arm_add_memory(phys_addr_t start, unsigned long size)
> +int __init arm_add_memory(phys_addr_t start, phys_addr_t size)
>  {
>  	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
>  
> @@ -538,7 +538,7 @@ int __init arm_add_memory(phys_addr_t start, unsigned long size)
>  	}
>  #endif
>  
> -	bank->size = size & PAGE_MASK;
> +	bank->size = size & ~(phys_addr_t)(PAGE_SIZE-1);

Pedantry: can you stick spaces either side of the '-' please? I know it
doesn't match PAGE_MASK, but it fits with most of the C code.

Slightly more constructive feedback: can you also change early_mem to accept
64-bit (well, phys_addr_t) size values on the command line please? memparse
can already deal with unsigned long long, so it should be trivial. The only
remaining code I can see using 32-bit types for sizes is the CMA stuff but
I can't see that being a problem.

Will
