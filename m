From: dave.long@linaro.org (David Long)
Date: Fri, 10 Jun 2016 15:16:23 -0400
Subject: [PATCH v13 04/10] arm64: Blacklist non-kprobe-able symbol
In-Reply-To: <20160604124032.94ac1bb76fde6c661e1a47a5@kernel.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-5-git-send-email-dave.long@linaro.org>
 <20160604124032.94ac1bb76fde6c661e1a47a5@kernel.org>
Message-ID: <575B1207.10003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2016 11:40 PM, Masami Hiramatsu wrote:
> Hi David,
>
> On Thu,  2 Jun 2016 23:26:18 -0400
> David Long <dave.long@linaro.org> wrote:
>
>> From: Pratyush Anand <panand@redhat.com>
>>
>> Add all function symbols which are called from do_debug_exception under
>> NOKPROBE_SYMBOL, as they can not kprobed.
>
> I see, but this patch should be applied after kprobes
> are implemented on arm64.
>

I've gone back to that ordering (I think it was that way in earlier 
versions) but it feels odd.  Wouldn't you want the unsafe symbols marked 
that way before turning on kprobes, like it already is in the generic 
kernel code?

> And also, I have a comment below.
>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 5954881..4359ca8 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -563,6 +563,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
>>   	info.si_addr  = (void __user *)addr;
>>   	arm64_notify_die("Oops - SP/PC alignment exception", regs, &info, esr);
>>   }
>> +NOKPROBE_SYMBOL(do_debug_exception)
>
> This seems at wrong place. Please correct it in this patch.
>

Fixed.  It was fixed in the next patch but now I've fixed it where it's 
introduced.

> Thank you,
>


Thanks,
-dl
