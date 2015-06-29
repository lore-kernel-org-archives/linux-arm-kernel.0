From: neilb@suse.com (NeilBrown)
Date: Mon, 29 Jun 2015 11:32:34 +1000
Subject: [PATCH] md/raid6: delta syndrome for ARM NEON
In-Reply-To: <1435164213-25410-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1435164213-25410-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150629113234.7f6d4a49@noble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jun 2015 18:43:33 +0200 Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> This implements XOR syndrome calculation using NEON intrinsics.
> As before, the module can be built for ARM and arm64 from the
> same source.
> 
> Relative performance on a Cortex-A57 based system:
> 
>   raid6: int64x1  gen()   905 MB/s
>   raid6: int64x1  xor()   881 MB/s
>   raid6: int64x2  gen()  1343 MB/s
>   raid6: int64x2  xor()  1286 MB/s
>   raid6: int64x4  gen()  1896 MB/s
>   raid6: int64x4  xor()  1321 MB/s
>   raid6: int64x8  gen()  1773 MB/s
>   raid6: int64x8  xor()  1165 MB/s
>   raid6: neonx1   gen()  1834 MB/s
>   raid6: neonx1   xor()  1278 MB/s
>   raid6: neonx2   gen()  2528 MB/s
>   raid6: neonx2   xor()  1942 MB/s
>   raid6: neonx4   gen()  2888 MB/s
>   raid6: neonx4   xor()  2334 MB/s
>   raid6: neonx8   gen()  2957 MB/s
>   raid6: neonx8   xor()  2232 MB/s
>   raid6: using algorithm neonx8 gen() 2957 MB/s
>   raid6: .... xor() 2232 MB/s, rmw enabled
> 
> Cc: Markus Stockhausen <stockhausen@collogia.de>
> Cc: Neil Brown <neilb@suse.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  lib/raid6/neon.c  | 13 ++++++++++++-
>  lib/raid6/neon.uc | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/raid6/neon.c b/lib/raid6/neon.c
> index d9ad6ee284f4..7076ef1ba3dd 100644
> --- a/lib/raid6/neon.c
> +++ b/lib/raid6/neon.c
> @@ -40,9 +40,20 @@
>  					(unsigned long)bytes, ptrs);	\
>  		kernel_neon_end();					\
>  	}								\
> +	static void raid6_neon ## _n ## _xor_syndrome(int disks,	\
> +					int start, int stop, 		\
> +					size_t bytes, void **ptrs)	\
> +	{								\
> +		void raid6_neon ## _n  ## _xor_syndrome_real(int,	\
> +				int, int, unsigned long, void**);	\
> +		kernel_neon_begin();					\
> +		raid6_neon ## _n ## _xor_syndrome_real(disks,		\
> +			start, stop, (unsigned long)bytes, ptrs);	\
> +		kernel_neon_end();					\
> +	}								\
>  	struct raid6_calls const raid6_neonx ## _n = {			\
>  		raid6_neon ## _n ## _gen_syndrome,			\
> -		NULL,		/* XOR not yet implemented */		\
> +		raid6_neon ## _n ## _xor_syndrome,			\
>  		raid6_have_neon,					\
>  		"neonx" #_n,						\
>  		0							\
> diff --git a/lib/raid6/neon.uc b/lib/raid6/neon.uc
> index 1b9ed793342d..4fa51b761dd0 100644
> --- a/lib/raid6/neon.uc
> +++ b/lib/raid6/neon.uc
> @@ -3,6 +3,7 @@
>   *   neon.uc - RAID-6 syndrome calculation using ARM NEON instructions
>   *
>   *   Copyright (C) 2012 Rob Herring
> + *   Copyright (C) 2015 Linaro Ltd. <ard.biesheuvel@linaro.org>
>   *
>   *   Based on altivec.uc:
>   *     Copyright 2002-2004 H. Peter Anvin - All Rights Reserved
> @@ -78,3 +79,48 @@ void raid6_neon$#_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>  		vst1q_u8(&q[d+NSIZE*$$], wq$$);
>  	}
>  }
> +
> +void raid6_neon$#_xor_syndrome_real(int disks, int start, int stop,
> +				    unsigned long bytes, void **ptrs)
> +{
> +	uint8_t **dptr = (uint8_t **)ptrs;
> +	uint8_t *p, *q;
> +	int d, z, z0;
> +
> +	register unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
> +	const unative_t x1d = NBYTES(0x1d);
> +
> +	z0 = stop;		/* P/Q right side optimization */
> +	p = dptr[disks-2];	/* XOR parity */
> +	q = dptr[disks-1];	/* RS syndrome */
> +
> +	for ( d = 0 ; d < bytes ; d += NSIZE*$# ) {
> +		wq$$ = vld1q_u8(&dptr[z0][d+$$*NSIZE]);
> +		wp$$ = veorq_u8(vld1q_u8(&p[d+$$*NSIZE]), wq$$);
> +
> +		/* P/Q data pages */
> +		for ( z = z0-1 ; z >= start ; z-- ) {
> +			wd$$ = vld1q_u8(&dptr[z][d+$$*NSIZE]);
> +			wp$$ = veorq_u8(wp$$, wd$$);
> +			w2$$ = MASK(wq$$);
> +			w1$$ = SHLBYTE(wq$$);
> +
> +			w2$$ = vandq_u8(w2$$, x1d);
> +			w1$$ = veorq_u8(w1$$, w2$$);
> +			wq$$ = veorq_u8(w1$$, wd$$);
> +		}
> +		/* P/Q left side optimization */
> +		for ( z = start-1 ; z >= 0 ; z-- ) {
> +			w2$$ = MASK(wq$$);
> +			w1$$ = SHLBYTE(wq$$);
> +
> +			w2$$ = vandq_u8(w2$$, x1d);
> +			wq$$ = veorq_u8(w1$$, w2$$);
> +		}
> +		w1$$ = vld1q_u8(&q[d+NSIZE*$$]);
> +		wq$$ = veorq_u8(wq$$, w1$$);
> +
> +		vst1q_u8(&p[d+NSIZE*$$], wp$$);
> +		vst1q_u8(&q[d+NSIZE*$$], wq$$);
> +	}
> +}


Looks good, thanks.
I've queued this for the next merge window (4.3)

NeilBrown
