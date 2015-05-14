From: gangchen@rdamicro.com (Chen Gang)
Date: Thu, 14 May 2015 11:39:02 +0800
Subject: [PATCH 1/1] ARM:r0 is also corrupted after calling __do_div64.
In-Reply-To: <1431427201-14371-1-git-send-email-gangchen@rdamicro.com>
References: <20150512100042.GN2067@n2100.arm.linux.org.uk>
 <1431427201-14371-1-git-send-email-gangchen@rdamicro.com>
Message-ID: <555418D6.6000707@rdamicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell

The following patch is made according to your suggestion. Could you 
review or merge it before your context is cleaned? Thanks!

Br, Chen Gang

On 05/12/2015 06:40 PM, Chen Gang wrote:
> R0 is corrupted after calling __do_div64 and compiler is not informed
> about this in macro __do_div_asm. If n is to be used again after this
> macro, r0 is not reloaded and n will contain incorrect value
>
> Signed-off-by: Chen Gang <gangchen@rdamicro.com>
> ---
>   arch/arm/include/asm/div64.h | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index a66061a..4829618 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -34,13 +34,15 @@
>   	register unsigned long long __n   asm("r0") = n;	\
>   	register unsigned long long __res asm("r2");		\
>   	register unsigned int __rem       asm(__xh);		\
> +	register unsigned int __clobber   asm(__xl);		\
>   	asm(	__asmeq("%0", __xh)				\
> -		__asmeq("%1", "r2")				\
> -		__asmeq("%2", "r0")				\
> -		__asmeq("%3", "r4")				\
> +		__asmeq("%1", __xl)				\
> +		__asmeq("%2", "r2")				\
> +		__asmeq("%3", "r0")				\
> +		__asmeq("%4", "r4")				\
>   		"bl	__do_div64"				\
> -		: "=r" (__rem), "=r" (__res)			\
> -		: "r" (__n), "r" (__base)			\
> +		: "=r"(__rem), "=r"(__clobber), "=r"(__res)	\
> +		: "r"(__n), "r"(__base)				\
>   		: "ip", "lr", "cc");				\
>   	n = __res;						\
>   	__rem;							\
