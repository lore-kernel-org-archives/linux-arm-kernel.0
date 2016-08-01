From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 1 Aug 2016 14:36:19 +0100
Subject: [PATCH v2] arm64: mm: convert __dma_* routines to use start, size
In-Reply-To: <1c4ec01bd3594485b6a4b386994dc6ca@nmail01.hynixad.com>
References: <1469518496-8177-1-git-send-email-kwangwoo.lee@sk.com>
 <b978e732-f5c3-4b77-01d9-dd5f7e2303e3@arm.com>
 <15c12f9900fd4b31a875250c478023c6@nmail01.hynixad.com>
 <c355debc-0238-ff51-ca90-6e0c8085366b@arm.com>
 <b0d9ef6b59364c4587f8d7c2493160ed@nmail01.hynixad.com>
 <c4ee86f4-e7c4-aeee-f3eb-cb4477a95bf6@arm.com>
 <1c4ec01bd3594485b6a4b386994dc6ca@nmail01.hynixad.com>
Message-ID: <21272fb2-bffb-15ee-41a9-af0251a33fd0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/16 00:45, kwangwoo.lee at sk.com wrote:
[...]
>>>> -----8<-----
>>>> diff --git a/arch/arm64/include/asm/assembler.h
>>>> b/arch/arm64/include/asm/assembler.h
>>>> index 10b017c4bdd8..1c005c90387e 100644
>>>> --- a/arch/arm64/include/asm/assembler.h
>>>> +++ b/arch/arm64/include/asm/assembler.h
>>>> @@ -261,7 +261,16 @@ lr	.req	x30		// link register
>>>>  	add	\size, \kaddr, \size
>>>>  	sub	\tmp2, \tmp1, #1
>>>>  	bic	\kaddr, \kaddr, \tmp2
>>>> -9998:	dc	\op, \kaddr
>>>> +9998:
>>>> +	.ifeqs "\op", "cvac"
>>>> +alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
>>>> +	dc	cvac, \kaddr
>>>> +alternative_else
>>>> +	dc	civac, \kaddr
>>>> +alternative_endif
>>>> +	.else
>>>> +	dc	\op, \kaddr
>>>> +	.endif
>>>>  	add	\kaddr, \kaddr, \tmp1
>>>>  	cmp	\kaddr, \size
>>>>  	b.lo	9998b
>>>
>>> I agree that it looks not viable because it makes the macro bigger and
>>> conditional specifically with CVAC op.
>>
>> Actually, having had a poke around in the resulting disassembly, it
>> looks like this does work correctly. I can't think of a viable reason
>> for the whole dcache_by_line_op to ever be wrapped in yet another
>> alternative (which almost certainly would go horribly wrong), and it
>> would mean that any other future users are automatically covered for
>> free. It's just horrible to look at at the source level.
> 
> Then, Are you going to send a patch for this? Or should I include this change?

I'll do a bit more testing just to make sure, then spin a separate patch
(and try to remember to keep you on CC..)

Robin.
