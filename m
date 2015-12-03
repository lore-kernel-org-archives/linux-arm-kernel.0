From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Dec 2015 12:18:40 +0000
Subject: [PATCH v3 3/7] arm64: split off early mapping code from
 early_fixmap_init()
In-Reply-To: <1447672998-20981-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151203121840.GB28731@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Apologies that it's taken me so long to get around to this...

On Mon, Nov 16, 2015 at 12:23:14PM +0100, Ard Biesheuvel wrote:
> This splits off and generalises the population of the statically
> allocated fixmap page tables so that we may reuse it later for
> the linear mapping once we move the kernel text mapping out of it.
> 
> This also involves taking into account that table entries at any of
> the levels we are populating may have been populated already, since
> the fixmap mapping might not be disjoint up to the pgd level anymore
> from other early mappings.

As a heads-up, for avoiding TLB conflicts, I'm currently working on
alternative way of creating the kernel page tables which will definitely
conflict here, and may or may not supercede this approach.

By adding new FIX_{PGD,PUD,PMD,PTE} indicees to the fixmap, we can
allocate page tables from anywhere via memblock, and temporarily map
them as we need to.

That would avoid the need for the bootstrap tables. In head.S we'd only
need to create a temporary (coarse-grained, RWX) kernel mapping (with
the fixmap bolted on). Later we would create a whole new set of tables
with a fine-grained kernel mapping and a full linear mapping using the
new fixmap entries to temporarily map tables, then switch over to those
atomically.

Otherwise, one minor comment below.

> +static void __init bootstrap_early_mapping(unsigned long addr,
> +					   struct bootstrap_pgtables *reg,
> +					   bool pte_level)

The only caller in this patch passes true for pte_level.

Can we not introduce the argument when it is first needed? Or at least
have something in the commit message as to why we'll need it later?

>  	/*
>  	 * The boot-ioremap range spans multiple pmds, for which
> -	 * we are not preparted:
> +	 * we are not prepared:
>  	 */

I cannot wait to see this typo go!

Otherwise, this looks fine to me.

Thanks,
Mark.
