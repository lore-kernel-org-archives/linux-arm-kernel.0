From: baicar.tyler@gmail.com (Tyler Baicar)
Date: Thu, 16 Aug 2018 17:24:29 -0400
Subject: [RFC PATCH] edac: armv8_edac: Add ARMv8 EDAC driver
In-Reply-To: <20180816073559.GA2111@nazgul.tnic>
References: <1533242990-12828-1-git-send-email-tbaicar@codeaurora.org>
 <20180816073559.GA2111@nazgul.tnic>
Message-ID: <CABo9ajBeXnuS4GQep9GTP8zeQrYENXtY6Pp7FHgbTbf5wFD4ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2018 at 3:35 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> Remember to always run your stuff through checkpatch to catch legit issues:
>

Sorry about that, I will clean those up!

>
>> diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
>> new file mode 100644
>> index 0000000..2cb0265
>> --- /dev/null
>> +++ b/arch/arm64/kernel/ras.c
>> @@ -731,6 +732,9 @@ asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>>  {
>>       nmi_enter();
>>
>> +     if (IS_ENABLED(CONFIG_EDAC_ARMV8))
>> +             armv8_edac_report_error();
>
> I would strongly advise against that - calling driver code from arch
> core code. You've made armv8_edac bool as it cannot be a module because
> of it, which is silly. I was lucky that we were able to remove that ugly
> dependency from x86 traps code. Hint: use a notifier and this way the
> edac driver can be a module too.
>
> And looking at armv8_edac.c - this is making the whole error reporting
> unnecessarily complicated. Why? Why aren't you doing everything in
> ras.c?!
>
> I don't see the need for adding anything to drivers/edac/ *at* *all*!
>

I agree with this for now, but I wanted to tie it into edac from the start since
this driver will have extended capabilities in the future. This
current patch only
deals with the RAS extension nodes accessible by the CPU SRs; however,
there will be memory mapped error nodes for things like platform memory.
These will then need to go through the proper software intervention similar
to the handling in other EDAC drivers (e.g. ghes_edac_report_mem_error).
For these we will probably also like to tie them into the DIMM counters that
are exposed through the EDAC sysfs nodes. That was the main motivation
for creating this as an armv8_edac driver :)

Thanks,
Tyler
