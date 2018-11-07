From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2018 21:59:20 +0000
Subject: [PATCH 5/7] arm64: Do not apply BP hardening for hyp entries
 from EL2
In-Reply-To: <1537970184-44348-6-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <1537970184-44348-6-git-send-email-julien.thierry@arm.com>
Message-ID: <20181107215918.GG12248@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 02:56:22PM +0100, Julien Thierry wrote:
> When an EL2 entry of __kvm_hyp_vector is taken, it means an entry from a
> lower EL was previously taken to exit the guest. Taking that lower EL entry
> already applied BP hardening if it was needed, so there is no need to do
> it again.
> 
> Only apply BP hardening for exception coming from lower EL.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: kvmarm at lists.cs.columbia.edu
> ---
>  arch/arm64/kernel/cpu_errata.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index dec1089..9db5ecc 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -103,10 +103,16 @@ static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
>  	void *dst = lm_alias(__bp_harden_hyp_vecs_start + slot * SZ_2K);
>  	int i;
> 
> -	for (i = 0; i < SZ_2K; i += 0x80)
> +	/*
> +	 * Only overwrite hyp entries for exceptions from lower EL.
> +	 * Exception vection vector is 2K bytes, first 1K bytes concern
> +	 * exception from EL2 (EL2t, EL2h), last 1K concert lower exception
> +	 * levels (ELx-64bits, ELx-32bits).
> +	 */
> +	for (i = SZ_1K; i < SZ_2K; i += 0x80)
>  		memcpy(dst + i, hyp_vecs_start, hyp_vecs_end - hyp_vecs_start);
> 
> -	__flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
> +	__flush_icache_range((uintptr_t)dst + SZ_1K, (uintptr_t)dst + SZ_2K);
>  }

I'd personally find this clearer if you did:

	dst += SZ_1K;

before the for loop and with your comment above it. Then the for loop
becomes:

	for (i = 0; i < SZ_1K; i += 0x80)

and the range of the cache maintenance is [dst, dst + SZ_1K)

But I'll leave it up to Marc.

Will
