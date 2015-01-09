From: panand@redhat.com (Pratyush Anand)
Date: Fri, 09 Jan 2015 10:48:51 +0530
Subject: [RFC 4/8] ARM64: Add instruction_pointer_set function
In-Reply-To: <20150108165909.GR11583@arm.com>
References: <cover.1420038188.git.panand@redhat.com>
 <028aab951a24c56075b1060afa1c2b2d88c09083.1420038188.git.panand@redhat.com>
 <20150108165909.GR11583@arm.com>
Message-ID: <54AF64BB.5010609@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 08 January 2015 10:29 PM, Will Deacon wrote:
> On Wed, Dec 31, 2014 at 03:21:20PM +0000, Pratyush Anand wrote:
>> instruction_pointer_set is needed for uprobe implementation. Hence
>> define it for ARM64.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>   arch/arm64/include/asm/ptrace.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index 24cc048ac3e7..29d9bf5e3635 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -206,6 +206,12 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
>>   #define instruction_pointer(regs)	((regs)->pc)
>>   #define stack_pointer(regs)		((regs)->sp)
>>
>> +static inline void instruction_pointer_set(struct pt_regs *regs,
>> +					   unsigned long val)
>> +{
>> +	instruction_pointer(regs) = val;
>> +}
>
> Do you think we could make use of the asm-generic ptrace header to get
> this for free? afaict, we just need to implement GET_USP and possibly
> GET_FP for the compat case (although it may well be that we still handle
> the compat case entirely separately).
>

Yes, We can use asm-generic for it.

I think , we can also add link_pointer and link_pointer_set in 
asm-generic/ptrace.h to help with all retprobes.

~Pratyush
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
