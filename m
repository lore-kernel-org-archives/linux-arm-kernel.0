From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 30 Sep 2016 16:58:25 +0100
Subject: [PATCH 3/3] arm64: dump: Add checking for writable and
 exectuable pages
In-Reply-To: <20160929213257.30505-4-labbott@redhat.com>
References: <20160929213257.30505-1-labbott@redhat.com>
 <20160929213257.30505-4-labbott@redhat.com>
Message-ID: <20160930155814.GA1729@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 02:32:57PM -0700, Laura Abbott wrote:
> @@ -219,6 +223,15 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
>  		unsigned long delta;
>  
>  		if (st->current_prot) {
> +			if (st->check_wx &&
> +			((st->current_prot & PTE_RDONLY) != PTE_RDONLY) &&
> +			((st->current_prot & PTE_PXN) != PTE_PXN)) {
> +				WARN_ONCE(1, "arm64/mm: Found insecure W+X mapping at address %p/%pS\n",
> +					 (void *)st->start_address,
> +					 (void *)st->start_address);
> +				st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
> +			}
> +

Would it be worth verifying that all kernel mappings are UXN, too?

ARMv8 allows execute-only mappings, and a !UXN mapping could result in an info
leak (e.g. pointers in MOVZ+MOVK sequences), or potential asynchronous issues
(e.g. user instruction fetches accessing read-destructive device registers).
All kernel mappings *should* be UXN.

Thanks,
Mark.
