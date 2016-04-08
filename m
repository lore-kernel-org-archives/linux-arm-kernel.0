From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 17:15:01 +0200
Subject: [PATCH 00/17] kvm-arm: Add stage2 page table walker
In-Reply-To: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408151501.GB8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Mon, Apr 04, 2016 at 05:26:00PM +0100, Suzuki K Poulose wrote:
> This series adds support for stage2 page table helpers and makes
> the core kvm-arm MMU code make use of it. At the moment we assume
> that the host/hyp and the stage2 page tables have same number of
> levels and hence use the host level accessors (except for some
> hooks, e.g kvm_p.d_addr_end) and shares the routines for unmapping
> the page table ranges.
> 
> On arm32, the only change w.r.t the page tables is dealing
> with > 32bit physical addresses.
> 
> However on arm64, the hardware supports concatenation of tables (upto 16)
> at the entry level, which could affect :
>  1) number of entries in the PGD table (upto 16 * PTRS_PER_PTE)
>  2) number of page table levels (reduced number of page table levels).
> 
> Also depending on the VA_BITS for the host kernel, the number of page table
> levels for both host and stage2(40bit IPA) could differ. At present, we insert
> (upto) one fake software page table(as the hardware is not aware of it and is
> only used by the OS to walk the table) level to bring the number of levels to
> that of the host/hyp table. However, with 16K + 48bit, and 40bit IPA, we could
> end up in 2 fake levels, which complicates the code.
> 
> This series introduces explicit stage2 page table helpers and also defines
> separate set of routines for unmapping hyp and stage2 tables.
> 
> On arm64 stage2 page table helpers are defined based on the number of levels
> required to map the IPA bits. See patch 15 for more details.
> 
> Tested on TC2 (arm32), Fast models(with VHE) and real hardwares.
> 

This looks pretty good overall.  Could you rebase it on kvmarm/master
where Marc addressed the 36 bits PA size of the foundation model and
have a look at the interactions there?

If we can solve that bit and address the cosmetic issues I had in this
series, then I think we can queue this real soon.

Thanks a lot for going the extra mile on this with rewriting the whole
KVM page table handling!

Best,
-Christoffer
