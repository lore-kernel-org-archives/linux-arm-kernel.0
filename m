From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 15:13:09 +0100
Subject: [PATCHv2 1/6] arm64: lib: Implement optimized memcpy routine
In-Reply-To: <1398661895-5559-2-git-send-email-zhichang.yuan@linaro.org>
References: <1398661895-5559-1-git-send-email-zhichang.yuan@linaro.org>
 <1398661895-5559-2-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20140509141308.GE7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 06:11:29AM +0100, zhichang.yuan at linaro.org wrote:
> This patch, based on Linaro's Cortex Strings library, improves
> the performance of the assembly optimized memcpy() function.
[...]
> --- a/arch/arm64/lib/memcpy.S
> +++ b/arch/arm64/lib/memcpy.S
[...]
>  ENTRY(memcpy)
[...]
> +	mov	dst, dstin
> +	cmp	count, #16
> +	/*When memory length is less than 16, the accessed are not aligned.*/
> +	b.lo	.Ltiny15
> +
> +	neg	tmp2, src
> +	ands	tmp2, tmp2, #15/* Bytes to reach alignment. */
> +	b.eq	.LSrcAligned
> +	sub	count, count, tmp2

I started looking at this and comparing it to the original cortex
strings library. Is there any reason why at least the first part has
been rewritten? For example, the cortex strings starts with probably the
most likely case, comparing the count with 64.

-- 
Catalin
