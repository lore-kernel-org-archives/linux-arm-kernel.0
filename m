From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 7 Dec 2015 12:09:56 +0000
Subject: [PATCH 2/5] iommu/io-pgtable: Indicate granule for TLB maintenance
In-Reply-To: <20151207110804.GA23430@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
 <67223d4b1ff57f3f46e8c3102e663a063a50a7f7.1449246988.git.robin.murphy@arm.com>
 <20151207110804.GA23430@arm.com>
Message-ID: <56657714.50504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/15 11:08, Will Deacon wrote:
[...]
>> +#define ARM_LPAE_GRANULE(d)		(1UL << (d)->pg_shift)
>> +
>>   #define ARM_LPAE_PAGES_PER_PGD(d)					\
>> -	DIV_ROUND_UP((d)->pgd_size, 1UL << (d)->pg_shift)
>> +	DIV_ROUND_UP((d)->pgd_size, ARM_LPAE_GRANULE(d))
>>
>>   /*
>>    * Calculate the index at level l used to map virtual address a using the
>> @@ -169,7 +171,7 @@
>>   /* IOPTE accessors */
>>   #define iopte_deref(pte,d)					\
>>   	(__va((pte) & ((1ULL << ARM_LPAE_MAX_ADDR_BITS) - 1)	\
>> -	& ~((1ULL << (d)->pg_shift) - 1)))
>> +	& ~(ARM_LPAE_GRANULE(d) - 1)))
>
> Do we run the risk of truncating the VA on 32-bit ARM here?

Indeed, in all honesty I'd missed that, but since __va is going to 
truncate it to a 32-bit void * anyway, doing it earlier in the 
expression actually seems to result in better code - with iopte_deref 
wrapped like so to make it easier to pick out:

arm_lpae_iopte *__iopte_deref(arm_lpae_iopte pte, struct 
arm_lpae_io_pgtable *d) {
	return iopte_deref(pte, d);
}

the result goes from this:

1568:	e92d4070 	push	{r4, r5, r6, lr}
156c:	e3a0e001 	mov	lr, #1
1570:	e592c060 	ldr	ip, [r2, #96]	; 0x60
1574:	e3e04000 	mvn	r4, #0
1578:	e30f5fff 	movw	r5, #65535	; 0xffff
157c:	e26c6020 	rsb	r6, ip, #32
1580:	e1a02c1e 	lsl	r2, lr, ip
1584:	e2722000 	rsbs	r2, r2, #0
1588:	e0000002 	and	r0, r0, r2
158c:	e0000004 	and	r0, r0, r4
1590:	e2400481 	sub	r0, r0, #-2130706432	; 0x81000000
1594:	e8bd8070 	pop	{r4, r5, r6, pc}

to this:

151c:	e5922060	ldr	r2, [r2, #96] ; 0x60
1520:	e3e03000	mvn	r3, #0
1524:	e1a03213	lsl	r3, r3, r2
1528:	e0000003	and	r0, r0, r3
152c:	e2400481	sub	r0, r0, #-2130706432 ; 0x81000000
1530:	e12fff1e	bx	lr

which, given how mind-bogglingly silly some of the former code looks, 
seems like an inadvertent win.

Robin.

>
> Will
>
