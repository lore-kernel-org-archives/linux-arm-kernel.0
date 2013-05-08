From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 May 2013 15:30:04 +0100
Subject: [PATCH] ARM v6/v7 cmpxchg64 shouldn't clear upper 32 bits of the
 old/new value
In-Reply-To: <1368021817-17309-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1368021817-17309-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20130508143004.GA20820@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 03:03:37PM +0100, jaccon.bastiaansen at gmail.com wrote:
> From: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> 
> The implementation of cmpxchg64() for the ARM v6 and v7 architecture
> casts parameter 2 and 3 (the old and new 64bit values) to an unsigned
> long before calling the atomic_cmpxchg64() function. This clears
> the top 32 bits of the old and new values, resulting in the wrong
> values being compare-exchanged.
> 
> This bug is introduced by commit 3e0f5a15f5003f4576c35498814f0f1567860449

Please truncate the commit id to 12 characters and stick the title string in
brackets afterwards, e.g. 123456789abc ("will's broken commit"),

> Change-Id: I8e8a4c09c525ed8056385c9dc4d65163c28307dc

You can drop the Change-Id.

> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> ---
>  arch/arm/include/asm/cmpxchg.h |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 7eb18c1..4f009c1 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -233,15 +233,15 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
>  	((__typeof__(*(ptr)))atomic64_cmpxchg(container_of((ptr),	\
>  						atomic64_t,		\
>  						counter),		\
> -					      (unsigned long)(o),	\
> -					      (unsigned long)(n)))
> +					      (unsigned long long)(o),	\
> +					      (unsigned long long)(n)))
>  
>  #define cmpxchg64_local(ptr, o, n)					\
>  	((__typeof__(*(ptr)))local64_cmpxchg(container_of((ptr),	\
>  						local64_t,		\
>  						a),			\
> -					     (unsigned long)(o),	\
> -					     (unsigned long)(n)))
> +					     (unsigned long long)(o),	\
> +					     (unsigned long long)(n)))
>  
>  #endif	/* __LINUX_ARM_ARCH__ >= 6 */

With the above cleanup:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
