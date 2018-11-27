From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 27 Nov 2018 18:57:04 +0000
Subject: [PATCH] arm64: tlbi: Set MAX_TLBI_OPS to PTRS_PER_PTE
In-Reply-To: <1543251667-30520-1-git-send-email-will.deacon@arm.com>
References: <1543251667-30520-1-git-send-email-will.deacon@arm.com>
Message-ID: <20181127185703.zbpl2uketmgyfpjk@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 05:01:07PM +0000, Will Deacon wrote:
> In order to reduce the possibility of soft lock-ups, we bound the
> maximum number of TLBI operations performed by a single call to
> flush_tlb_range() to an arbitrary constant of 1024.
> 
> Whilst this does the job of avoiding lock-ups, we can actually be a bit
> smarter by defining this as PTRS_PER_PTE. Due to the structure of our
> page tables, using PTRS_PER_PTE means that an outer loop calling
> flush_tlb_range() for entire table entries will end up performing just a
> single TLBI operation for each entry. As an example, mremap()ing a 1GB
> range mapped using 4k pages now requires only 512 TLBI operations when
> moving the page tables as opposed to 262144 operations (512*512) when
> using the current threshold of 1024.

To be more precise, we'd have 512 TLBI ASIDE1IS vs 262144 TLBI VAE1IS
(or VALE1IS). But since it only affects the given ASID, I don't think it
matters.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
