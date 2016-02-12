From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Feb 2016 16:57:07 +0000
Subject: [PATCH 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <1455293208-6763-3-git-send-email-jeremy.linton@arm.com>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
 <1455293208-6763-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160212165707.GB20262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 12, 2016 at 10:06:48AM -0600, Jeremy Linton wrote:
> With 64k pages, the next larger segment size is 512M. The linux
> kernel also uses different protection flags to cover its code and data.
> Because of this requirement, the vast majority of the kernel code and
> data structures end up being mapped with 64k pages instead of the larger
> pages common with a 4k page kernel.
> 
> Recent ARM processors support a contiguous bit in the
> page tables which allows the a TLB to cover a range larger than a
> single PTE if that range is mapped into physically contiguous
> ram.
> 
> So, for the kernel its a good idea to set this flag. Some basic
> micro benchmarks show it can significantly reduce the number of
> L1 dTLB refills.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 6 deletions(-)

This generally looks good.

As a heads-up, I have one concern:

> +static void clear_cont_pte_range(pte_t *pte, unsigned long addr)
> +{
> +	int i;
> +
> +	pte -= CONT_RANGE_OFFSET(addr);
> +	for (i = 0; i < CONT_PTES; i++) {
> +		if (pte_cont(*pte))
> +			set_pte(pte, pte_mknoncont(*pte));
> +		pte++;
> +	}
> +	flush_tlb_all();
> +}

As far as I can tell, "splitting" contiguous entries comes with the same
caveats as splitting sections. In the absence of a BBM sequence we might
end up with conflicting TLB entries.

However, I think we're OK for now.

The way we consistently map/unmap/modify image/linear "chunks" should
prevent us from trying to split those, and if/when we do this for the
EFI runtime page tables thy aren't live.

It would be good to figure out how to get rid of the splitting entirely.

Otherwise, this looks good to me; I'll try to give this a spin next
week.

Thanks,
Mark.
