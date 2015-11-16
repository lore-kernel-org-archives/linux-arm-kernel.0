From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 19:01:56 +0000
Subject: [PATCH v2 11/12] ARM: wire up UEFI init and runtime support
In-Reply-To: <1447698757-8762-12-git-send-email-ard.biesheuvel@linaro.org>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-12-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151116190156.GH8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 07:32:36PM +0100, Ard Biesheuvel wrote:
> +static inline void efi_set_pgd(struct mm_struct *mm)
> +{
> +	if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
> +		__check_vmalloc_seq(mm);
> +
> +	cpu_switch_mm(mm->pgd, mm);
> +
> +	flush_tlb_all();
> +	if (icache_is_vivt_asid_tagged())
> +		__flush_icache_all();
> +}

I don't think that's sufficient.  There's a gap between switching the mm
and flushing the TLBs where we could have different global TLB entries
from those in the page tables - and that can cause problems with CPUs
which speculatively prefetch.  Some CPUs raise exceptions for this...

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
