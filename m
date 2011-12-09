From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 9 Dec 2011 17:50:11 +0000
Subject: [PATCH 1/4] Add generic ARM instruction set condition code checks.
In-Reply-To: <20111209153649.GH5196@mudshark.cambridge.arm.com>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173138.7572.48841.stgit@localhost6.localdomain6>
 <20111209153649.GH5196@mudshark.cambridge.arm.com>
Message-ID: <4EE24A53.5090807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/11 15:36, Will Deacon wrote:
> Hi Leif,
>
> This looks largely there, but I have some small comments inline.
>
> On Thu, Dec 08, 2011 at 05:31:43PM +0000, Leif Lindholm wrote:
>> +#ifndef __ASSEMBLY__
>> +extern unsigned int arm_check_condition(unsigned int opcode, unsigned int psr);
>> +#endif
>
> You could use u32 for the parameters to reinforce the point that they're
> words.

Yeah, fair point. I just kept the types from the original nwfpe code.

>> +unsigned int arm_check_condition(unsigned int opcode, unsigned int psr)
>
> I think you want asmlinkage for this function.

OK

>> +{
>> +    unsigned int cc_bits  = opcode>>  28;
>> +    unsigned int psr_cond = psr>>  28;
>> +
>> +    if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
>> +            if ((cc_map[cc_bits]>>  (psr_cond))&  1)
>> +                    return ARM_OPCODE_CONDTEST_PASS;
>> +            else
>> +                    return ARM_OPCODE_CONDTEST_FAIL;
>> +    } else {
>> +            return ARM_OPCODE_CONDTEST_UNCOND;
>> +    }
>> +}
>
> Maybe have a single return here returning a ret value which you assign in
> the conditional blocks.

OK

>> +EXPORT_SYMBOL(arm_check_condition);
>
> EXPORT_SYMBOL_GPL?

OK

/
        Leif

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
