From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 1 Dec 2014 16:59:42 +0800
Subject: [PATCH v10 2/2] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <547BC490.9020806@huawei.com>
References: <1416551751-50846-1-git-send-email-wangnan0@huawei.com>	
 <1416551751-50846-3-git-send-email-wangnan0@huawei.com>
 <1417099007.2041.6.camel@linaro.org> <547BC490.9020806@huawei.com>
Message-ID: <547C2DFE.7010005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> +/*
>>> + * NOTE: the first sub and add instruction will be modified according
>>> + * to the stack cost of the instruction.
>>> + */
>>> +asm (
>>> +			".global optprobe_template_entry\n"
>>> +			"optprobe_template_entry:\n"
>>> +			"	sub	sp, sp, #0xff\n"
>>> +			"	stmia	sp, {r0 - r14} \n"
>>
>> AEABI requires that the stack be aligned to a multiple of 8 bytes at
>> function call boundaries, however kprobes can be inserted in the middle
>> of functions where such alignment isn't guaranteed to be maintained.
>> Therefore, this trampoline code needs to make adjust SP if necessary to
>> ensure that alignment. See svc_entry in arch/arm/kernel/entry-armv.S for
>> an example of how this is done; though note, we can't use that exact
>> method because we can't change the flags value without saving them
>> first. (Exception handlers don't have to worry about that because the
>> flags are saved in spsr).
>>
> 
> So I think we have to push a flag into stack for it.
> 

By more thinking I found another method on it. Please see my version 11 patch:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/307562.html
