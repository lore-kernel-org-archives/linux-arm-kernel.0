From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jul 2018 10:16:27 +0100
Subject: next-20180723 build: 2 failures 11 warnings (next-20180723)
In-Reply-To: <20180723181150.GF13981@sirena.org.uk>
References: <E1fheAy-0003tU-Dq@optimist> <20180723181150.GF13981@sirena.org.uk>
Message-ID: <20180724091626.GC19324@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 07:11:50PM +0100, Mark Brown wrote:
> On Mon, Jul 23, 2018 at 05:59:12PM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm64 allmodconfig with:
> 
> > 	arm64-allmodconfig
> > ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> 
> using
> 
>    aarch64-linux-gnu-gcc (Linaro GCC 5.3-2016.05) 5.3.1 20160412
> 
> however it builds perfectly fine with
> 
>    aarch64-linux-gnu-gcc (Linaro GCC 6.2-2016.11) 6.2.1 20161016
> 
> which honestly seems like a sensible and worthwhile upgrade at this
> point anyway given that it's a year and a half old so I'm going to do
> that for my builder (perhaps even jump on a newer version) but it seemed
> worth highlighting in case this is considered undesirable.  A similar
> issue is hitting on KernelCI, we should probably look at upgrading the
> toolchain there too.

Hmm, it looks to me like this comes about because xen/privcmd.c is being
built as a module, but contains a call to set_pte_at() with a special pte:

	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));

	set_pte_at(r->mm, addr, ptep, pte);

which on arm64 contains:

	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
		__sync_icache_dcache(pte);

so GCC 6 can optimise away the call to the non-exported symbol, but GCC 5
has trouble.

What I don't understand is why this suddenly cropped up. Did GCC 5 build
linux-next arm64 allmodconfig last week?

Cheers,

Will
