From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 21 Nov 2014 13:19:21 -0500 (EST)
Subject: [PATCH] ARM: allow modules outside of bl range
In-Reply-To: <1416585326-3838-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1416585326-3838-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.11.1411211307410.11690@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Nov 2014, Ard Biesheuvel wrote:

> Loading modules far away from the kernel in memory is problematic
> because the 'bl' instruction only has limited reach, and modules are not
> built with PLTs. Instead of using the -mlong-calls option (which affects
> all compiler emitted bl instructions, but not the ones in assembler),
> this patch allocates some additional space at module load time, and
> populates it with PLT like entries when encountering relocations that
> are out of reach.
> 
> This should work with all relocations against symbols exported by the
> kernel, including those resulting from GCC generated function calls for
> ftrace etc.
> 
> The module memory needs increase by about 5% on average, regardless of
> whether any PLT entries were actually emitted. However, due to the page
> based rounding that occurs when allocating module memory, the typical
> memory footprint increase is negligible.
> 
> This is largely based on the ia64 implementation.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[...]

> +static u32 get_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
> +{
> +	struct plt_entries *plt, *plt_end;
> +	int c, *count;
> +
> +	if (in_init(mod, loc)) {
> +		plt = (void *)mod->arch.init_plt->sh_addr;
> +		plt_end = (void *)plt + mod->arch.init_plt->sh_size;
> +		count = &mod->arch.init_plt_count;
> +	} else {
> +		plt = (void *)mod->arch.core_plt->sh_addr;
> +		plt_end = (void *)plt + mod->arch.core_plt->sh_size;
> +		count = &mod->arch.core_plt_count;
> +	}
> +
> +	/* Look for an existing entry pointing to 'val' */
> +	for (c = *count; plt < plt_end; c -= PLT_ENT_COUNT, plt++) {
> +		int i;
> +
> +		if (!c) {
> +			/* Populate a new set of entries */
> +			*plt = (struct plt_entries){
> +				{ [0 ... PLT_ENT_COUNT - 1] = PLT_ENT_LDR, },
> +				{ val, }
> +			};
> +			++*count;
> +			return (u32)plt->ldr;
> +		}
> +		for (i = 0; i < PLT_ENT_COUNT; i++) {
> +			if (!plt->lit[i]) {
> +				plt->lit[i] = val;
> +				++*count;
> +			}
> +			if (plt->lit[i] == val)
> +				return (u32)&plt->ldr[i];
> +		}
> +	}
> +	BUG();
> +	return 0;

You shouldn't need a return here as this is unreachable code.

Also I'd suggest creating a kconfig option allowing for this extra code 
and the possible memory overhead to be configured out if someone really 
doesn't want it.  Judicious usage of IS_ENABLED() in the code is 
sufficient to have it all compiled out when not configured.


Nicolas
