From: nschichan@freebox.fr (Nicolas Schichan)
Date: Mon, 04 May 2015 18:16:30 +0200
Subject: [PATCH 4/4] ARM: net fix emit_udiv() for BPF_ALU | BPF_DIV |
 BPF_K intruction.
In-Reply-To: <20150501173721.GO12732@n2100.arm.linux.org.uk>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
 <1430314657-2552-5-git-send-email-nschichan@freebox.fr>
 <20150501173721.GO12732@n2100.arm.linux.org.uk>
Message-ID: <55479B5E.2070901@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2015 07:37 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 29, 2015 at 03:37:37PM +0200, Nicolas Schichan wrote:
[...]
>> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
>> index b5f470d..ffaf311 100644
>> --- a/arch/arm/net/bpf_jit_32.c
>> +++ b/arch/arm/net/bpf_jit_32.c
>> @@ -449,10 +449,10 @@ static inline void emit_udiv(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx)
>>  		return;
>>  	}
>>  #endif
>> -	if (rm != ARM_R0)
>> -		emit(ARM_MOV_R(ARM_R0, rm), ctx);
>>  	if (rn != ARM_R1)
>>  		emit(ARM_MOV_R(ARM_R1, rn), ctx);
>> +	if (rm != ARM_R0)
>> +		emit(ARM_MOV_R(ARM_R0, rm), ctx);
> 
> I don't think you've thought enough about this.  What if rm is ARM_R1?
> What if rn = ARM_R0 and rm = ARM_R1?
>
> How about:
> 
> 	if (rn == ARM_R0 && rm == ARM_R1) {
> 		emit(ARM_MOV_R(ARM_R3, rn), ctx); // r3 <- r0(rn)
> 		emit(ARM_MOV_R(ARM_R0, rm), ctx); // r0 <- r1(rm)
> 		emit(ARM_MOV_R(ARM_R1, ARM_R3), ctx); // r1 <- r3
> 	} else if (rn == ARM_R0) {
> 		emit(ARM_MOV_R(ARM_R1, rn), ctx); // r1 <- rn
> 		if (rm != ARM_R0)
> 			emit(ARM_MOV_R(ARM_R0, rm), ctx); // r0 <- rm
> 	} else {
> 		if (rm != ARM_R0)
> 			emit(ARM_MOV_R(ARM_R0, rm), ctx); // r0 <- rm
> 		if (rn != ARM_R1)
> 			emit(ARM_MOV_R(ARM_R1, rn), ctx); // r1 <- rn
> 	}
> 

Hello Russell,

In the current JIT, emit_udiv() is only being called with:

- rm = ARM_R4 (r_A) and rn = ARM_R0 (r_scrach) for BPF_ALU | BPF_DIV | BPF_K

- rm = ARM_R4 (r_A) and rn = ARM_R5 (r_X) for BPF_ALU | BPF_DIV | BPF_X

so it should not cause any issue in the current code state.

But yes, I'll rework the patch to avoid any other nasty surprises should the
code change.

Thanks,

-- 
Nicolas Schichan
Freebox SAS
