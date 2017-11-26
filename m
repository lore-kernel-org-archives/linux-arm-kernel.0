From: alex.shi@linaro.org (Alex Shi)
Date: Sun, 26 Nov 2017 23:23:42 +0800
Subject: do page fault in atomic bug on arm
In-Reply-To: <17ed7101-f076-f68c-b8f3-7cc62d24a641@linaro.org>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124155649.GT31757@n2100.armlinux.org.uk>
 <17ed7101-f076-f68c-b8f3-7cc62d24a641@linaro.org>
Message-ID: <c26314ab-90c0-cb04-4c55-ebcf2a7045e4@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, this patch should be passed off, since we got your new fixing
patches. I shouldn't mentioned here.

Regards
Alex

On 11/26/2017 10:58 PM, Alex Shi wrote:
>> Can you try the following patch to try and catch the problem earlier?
>> I haven't tested it myself, and adding code may move things around in
>> the kernel and make this bug disappear.
> Do we still need to try this patch? I saw you tried it and do further more.
>> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
>> index d523cd8439a3..ff577177b286 100644
>> --- a/arch/arm/kernel/entry-header.S
>> +++ b/arch/arm/kernel/entry-header.S
>> @@ -299,6 +299,8 @@
>>  	@ ARM mode restore
>>  	mov	r2, sp
>>  	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
>> +	tst	r1, #0xcf
>> +	bne	oops
>>  	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
>>  	msr	spsr_cxsf, r1			@ save in spsr_svc
>>  #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
>> @@ -314,6 +316,15 @@
>>  						@ after ldm {}^
>>  	add	sp, sp, #\offset + PT_REGS_SIZE
>>  	movs	pc, lr				@ return & move spsr_svc into cpsr
>> +oops:	.word	0xe7f001f2
> This oops cause allnoconfig with arm failed in build. but it's fine for
> a multi_v7_defconfig
> arch/arm/kernel/entry-common.S:106: Error: symbol `oops' is already defined
> 
>> +	.pushsection .rodata.str, "aMS", %progbits, 1
>> +2:	.asciz	"Returning to usermode but unexpected PSR bits set?"
>> +	.popsection
>> +	.pushsection __bug_table, "aw"
>> +	.align	2
>> +	.word	oops, 2b
>> +	.hword	\@
>> +	.popsection
>>  #elif defined(CONFIG_CPU_V7M)
>>  	@ V7M restore.
>>  	@ Note that we don't need to do clrex here as clearing the local
