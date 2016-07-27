From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 27 Jul 2016 10:56:18 +0100
Subject: [PATCH v2] arm64: mm: convert __dma_* routines to use start, size
In-Reply-To: <15c12f9900fd4b31a875250c478023c6@nmail01.hynixad.com>
References: <1469518496-8177-1-git-send-email-kwangwoo.lee@sk.com>
 <b978e732-f5c3-4b77-01d9-dd5f7e2303e3@arm.com>
 <15c12f9900fd4b31a875250c478023c6@nmail01.hynixad.com>
Message-ID: <c355debc-0238-ff51-ca90-6e0c8085366b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/16 02:55, kwangwoo.lee at sk.com wrote:
[...]
>>>  /*
>>> - *	__dma_clean_range(start, end)
>>> + *	__dma_clean_area(start, size)
>>>   *	- start   - virtual start address of region
>>> - *	- end     - virtual end address of region
>>> + *	- size    - size in question
>>>   */
>>> -__dma_clean_range:
>>> -	dcache_line_size x2, x3
>>> -	sub	x3, x2, #1
>>> -	bic	x0, x0, x3
>>> -1:
>>> +__dma_clean_area:
>>>  alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
>>> -	dc	cvac, x0
>>> +	dcache_by_line_op cvac, sy, x0, x1, x2, x3
>>>  alternative_else
>>> -	dc	civac, x0
>>> +	dcache_by_line_op civac, sy, x0, x1, x2, x3
>>
>> dcache_by_line_op is a relatively large macro - is there any way we can
>> still apply the alternative to just the one instruction which needs it,
>> as opposed to having to patch the entire mostly-identical routine?
> 
> I agree with your opinion. Then, how do you think about using CONFIG_* options
> like below? I think that alternative_* macros seems to keep the space for
> unused instruction. Is it necessary? Please, share your thought about the
> space. Thanks!
> 
> +__dma_clean_area:
> +#if    defined(CONFIG_ARM64_ERRATUM_826319) || \
> +       defined(CONFIG_ARM64_ERRATUM_827319) || \
> +       defined(CONFIG_ARM64_ERRATUM_824069) || \
> +       defined(CONFIG_ARM64_ERRATUM_819472)
> +       dcache_by_line_op civac, sy, x0, x1, x2, x3
> +#else
> +       dcache_by_line_op cvac, sy, x0, x1, x2, x3
> +#endif

That's not ideal, because we still only really want to use the
workaround if we detect a CPU which needs it, rather than baking it in
at compile time. I was thinking more along the lines of pushing the
alternative down into dcache_by_line_op, something like the idea below
(compile-tested only, may not actually be viable).

Robin.

-----8<-----
diff --git a/arch/arm64/include/asm/assembler.h
b/arch/arm64/include/asm/assembler.h
index 10b017c4bdd8..1c005c90387e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -261,7 +261,16 @@ lr	.req	x30		// link register
 	add	\size, \kaddr, \size
 	sub	\tmp2, \tmp1, #1
 	bic	\kaddr, \kaddr, \tmp2
-9998:	dc	\op, \kaddr
+9998:
+	.ifeqs "\op", "cvac"
+alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
+	dc	cvac, \kaddr
+alternative_else
+	dc	civac, \kaddr
+alternative_endif
+	.else
+	dc	\op, \kaddr
+	.endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
 	b.lo	9998b
