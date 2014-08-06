From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 6 Aug 2014 21:40:40 +0800
Subject: [RFC PATCH] kprobes: arm: enable OPTPROBES for arm 32
In-Reply-To: <1407332208.3006.13.camel@linaro1.home>
References: <1407223697-74911-1-git-send-email-wangnan0@huawei.com>	
 <53E1B2A0.1040807@hitachi.com> <1407332208.3006.13.camel@linaro1.home>
Message-ID: <53E23058.3030206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/8/6 21:36, Jon Medhurst (Tixy) wrote:
> On Wed, 2014-08-06 at 13:44 +0900, Masami Hiramatsu wrote:
>> (2014/08/05 16:28), Wang Nan wrote
> [...]
>>> +asm (
>>> +			".global optprobe_template_entry\n"
>>> +			"optprobe_template_entry:\n"
>>> +#ifndef CONFIG_THUMB
>>> +			"	sub	sp, sp, #80\n"
>>> +			"	stmia	sp, {r0 - r14} \n"
>>> +			"	add	r3, sp, #80\n"
>>> +			"	str	r3, [sp, #52]\n"
>>> +			"	mrs	r4, cpsr\n"
>>> +			"	str	r4, [sp, #64]\n"
>>> +			"	mov	r1, sp\n"
>>> +			"	ldr	r0, 1f\n"
>>> +			"	ldr	r2, 2f\n"
>>> +			"	blx	r2\n"
>>> +			"	ldr	r1, [sp, #64]\n"
>>> +			"	msr	cpsr_fs, r1\n"
>>> +			"	ldmia	sp, {r0 - r15}\n"
>>> +			".global optprobe_template_val\n"
>>> +			"optprobe_template_val:\n"
>>> +			"1:	nop\n"
>>> +			".global optprobe_template_call\n"
>>> +			"optprobe_template_call:\n"
>>> +			"2:	nop\n"
>>> +#else /* CONFIG_THUMB */
>>> +# error optprobe for thumb is not supported.
>>
>> Can we set CONFIG_THUMB=y without CONFIG_THUMB2_KERNEL ?
> 
> Yes, CONFIG_THUMB is for supporting userside Thumb code,
> CONFIG_THUMB2_KERNEL is for building the kernel for Thumb and the
> options are orthogonal. So I don't think kprobes code should be testing
> CONFIG_THUMB as it doesn't deal with userside.
> 

You are correct. This is my mistake.
