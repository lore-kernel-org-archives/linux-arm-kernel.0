From: panand@redhat.com (Pratyush Anand)
Date: Mon, 19 Jan 2015 14:33:14 +0530
Subject: [PATCH v4 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <54B96662.3030201@linaro.org>
References: <1420949002-3726-1-git-send-email-dave.long@linaro.org>	<1420949002-3726-4-git-send-email-dave.long@linaro.org>
 <CAHM4w1no=A1kTxN26znXD42USzO+ByHWHy76F2UMnmXhPKH0kQ@mail.gmail.com>
 <54B96662.3030201@linaro.org>
Message-ID: <54BCC852.60203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 17 January 2015 12:58 AM, David Long wrote:
>>> +static bool aarch64_insn_is_steppable(u32 insn)
>>> +{
>>> +       if (aarch64_get_insn_class(insn) == AARCH64_INSN_CLS_BR_SYS) {
>>> +               if (aarch64_insn_is_branch(insn))
>>> +                       return false;
>>> +
>>> +               /* modification of daif creates issues */
>>> +               if (aarch64_insn_is_msr_daif(insn))
>>> +                       return false;
>>> +
>>> +               if (aarch64_insn_is_hint(insn))
>>> +                       return aarch64_insn_is_nop(insn);
>>> +
>>> +               return true;
>>> +       }
>>> +
>>> +       if (aarch64_insn_uses_literal(insn))
>>> +               return false;
>>> +
>>> +       if (aarch64_insn_is_exclusive(insn))
>>> +               return false;
>>> +
>>> +       return true;
>>
>> Default true return may not be a good idea until we are sure that we
>> are returning false for all possible
>> simulation and rejection cases. In my opinion, its better to return
>> true only for steppable and false for
>> all remaining.
>>
>
> I struggled a little with this when I did it but I decided if the
> question was:  "should we have to recognize every instruction before
> deciding it was single-steppable or should we only recognize
> instructions that are *not* single-steppable", maybe it was OK to do the
> latter while recognizing extensions to the instruction set *could* end
> up (temporarly) allowing us to try and fail (badly) at single-stepping
> any problematic new instructions.  Certainly opinions could differ.  If

Lets see what others say, but I see that this approach will result in 
undesired behavior. For example: a probe has been tried to insert to svc 
instruction. SVC or any other exception generation instruction is 
expected to be rejected. But, current aarch64_insn_is_steppable will 
return true for it and then kprobe/uprobe code will allow to insert 
probe at that instruction, which will be wrong, no? I mean, I do not see 
a way to get into last else (INSN_REJECTED) of arm_kprobe_decode_insn.

So, if we go with this approach we need to insure that we cover all 
simulation-able and reject-able cases in aarch64_insn_is_steppable.

~Pratyush



> the consensus is that we can't allow this to ever happen (because old
> kprobe code is running on new hardware) then I think the only choice is
> to return to parsing binary tables.  Hopefully I could still find a way
> to leverage insn.c in that case.
