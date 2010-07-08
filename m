From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 08 Jul 2010 00:49:24 -0400 (EDT)
Subject: [PATCH 2/4] ARM: atomic ops: reduce critical region in
	atomic64_cmpxchg
In-Reply-To: <1277906688-12065-3-git-send-email-will.deacon@arm.com>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1007080045450.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jun 2010, Will Deacon wrote:

> In order to reduce the likelihood of failure in a load/store
> exclusive block, the number of intervening instructions should
> be kept to a minimum.
> 
> This patch hoists a mov operation out of the critical region
> in atomic64_cmpxchg.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/atomic.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index e9e56c0..4f0f282 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -358,8 +358,8 @@ static inline u64 atomic64_cmpxchg(atomic64_t *ptr, u64 old, u64 new)
>  
>  	do {
>  		__asm__ __volatile__("@ atomic64_cmpxchg\n"
> -		"ldrexd		%1, %H1, [%2]\n"
>  		"mov		%0, #0\n"
> +		"ldrexd		%1, %H1, [%2]\n"
>  		"teq		%1, %3\n"
>  		"teqeq		%H1, %H3\n"
>  		"strexdeq	%0, %4, %H4, [%2]"

I'm not sure you gain anything here.  The ldrexd probably requires at 
least one result delay cycle which is filled by the  mov instruction.  
By moving the mov insn before the ldrexd you are probably making the 
whole sequence one cycle longer.


Nicolas
