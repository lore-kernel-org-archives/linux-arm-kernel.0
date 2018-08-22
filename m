From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 22 Aug 2018 22:21:39 +0200
Subject: [PATCH] ARM: spectre-v2: Try to set IBE bit for Cortex-A15 and
 Brahma-B15
In-Reply-To: <e4db9ef9-398f-114a-b5a8-8d8de0b0f85e@gmail.com>
References: <20180607225804.28771-1-f.fainelli@gmail.com>
 <e4db9ef9-398f-114a-b5a8-8d8de0b0f85e@gmail.com>
Message-ID: <3698a520-00cd-f904-a031-a7d6f22c8885@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2018 03:58 PM, Marek Vasut wrote:
> On 06/08/2018 12:58 AM, Florian Fainelli wrote:
>> Per the ARM reference manual for the Cortex-A15, The ACTLR:
>>
>>  Is a read/write register.
>>
>>  Common to the Secure and Non-secure states.
>>
>>  Is only accessible from PL1 or higher, with access rights that depend
>>  on the mode:
>>
>>     * Read/write in Secure PL1 modes.
>>
>>     * Read-only and write-ignored in Non-secure PL1 and PL2 modes
>>       if NSACR.NS_SMP is 0.
>>
>>     * Read/write in Non-secure PL1 and PL2 modes if NSACR.NS_SMP
>>       is 1. In this case, all bits are write-ignored except for the SMP bit.
>>
>> We can attempt to set this bit from within the kernel, which helps
>> avoiding firmware side modifications to set the IBE bit when that is
>> impractical. We do this within __v7_ca15mp_setup and __v7_b15mp_setup
>> because by then we already took those labels because the processors we
>> run on do match.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> I believe this would help on selected R-Car Gen2 SoCs which have CA15
> cores. Those cores are released from reset by Linux directly and jump to
> the reset vector set up by Linux in Secure mode.
> 
> I was looking for a generic solution after discussing how to mitigate
> the spectrev2 on such SoCs with Catalin on IRC and this seems to be one
> option. There was also a suggestion that Russell is working on some sort
> of generic solution too. Can you comment on that please ?

Is there any feedback on this ?

>> ---
>>  arch/arm/mm/proc-v7.S | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index 6fe52819e014..a21cf3729efa 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -284,10 +284,16 @@ __v7_cr8mp_setup:
>>  	b	1f
>>  __v7_ca7mp_setup:
>>  __v7_ca12mp_setup:
>> +	b	2f
>>  __v7_ca15mp_setup:
>>  __v7_b15mp_setup:
>> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>> +	mrc	p15, 0, r0, c1, c0, 1
>> +	orr	r0, r0, #1			@ Enable IBE bit
>> +	mcr	p15, 0, r0, c1, c0, 1
>> +#endif
>>  __v7_ca17mp_setup:
>> -	mov	r10, #0
>> +2:	mov	r10, #0
>>  1:	adr	r0, __v7_setup_stack_ptr
>>  	ldr	r12, [r0]
>>  	add	r12, r12, r0			@ the local stack
>>
> 
> 


-- 
Best regards,
Marek Vasut
