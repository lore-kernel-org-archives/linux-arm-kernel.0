From: hari.vyas@broadcom.com (Hari Vyas)
Date: Wed, 8 Aug 2018 23:48:19 +0530
Subject: [PATCH] arm64: fix for bad_mode() handler to always result in
 panic
In-Reply-To: <20180807122727.GA9359@kroah.com>
References: <1533639828-19039-1-git-send-email-hari.vyas@broadcom.com>
 <20180807122727.GA9359@kroah.com>
Message-ID: <CAM5rFu-_x1EfXE72X-4_5XcO6zK86itiny16mgwoRrDBB2=oAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 5:57 PM, Greg KH <greg@kroah.com> wrote:
> On Tue, Aug 07, 2018 at 04:33:48PM +0530, Hari Vyas wrote:
>> bad_mode() handler is called for invalid or undefined
>> instruction in el1 level or when irq,fiq,sync or error
>> situation happen in el1 or el0 level.
>>
>> As per latest code, above abnormal situation may not result in
>> panic always due to die() call if user mode is determined at
>> that moment. That will just result in kill of current process
>> and panic will be avoided which it must not.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200637
>> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
>> ---
>>  arch/arm64/kernel/traps.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index d399d45..716ee73 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -621,7 +621,6 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
>>               handler[reason], smp_processor_id(), esr,
>>               esr_get_class_string(esr));
>>
>> -     die("Oops - bad mode", regs, 0);
>>       local_daif_mask();
>>       panic("bad mode");
>>  }
>> --
>> 1.9.1
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Thanks. Probably my mistake to include stable kernel list for regular
minor patch.
In any case, will take care about it along with arm maintainers and
developers review comments which I am awaiting.
