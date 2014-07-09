From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 9 Jul 2014 12:48:56 -0700
Subject: [PATCH 1/3] arm64: vdso: put vdso datapage in a separate vma
In-Reply-To: <53BD9BA1.4070103@mentor.com>
References: <1404930133-30324-1-git-send-email-will.deacon@arm.com>
 <1404930133-30324-2-git-send-email-will.deacon@arm.com>
 <53BD9BA1.4070103@mentor.com>
Message-ID: <CALCETrXv=HJGV+Mc4ys0R+OgwAqJ_bRLxZp8XQ=McELAGi-yrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 12:44 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> Hi Will, one question (and maybe it's more of a question for Andy than
> for you).
>
> On 07/09/2014 01:22 PM, Will Deacon wrote:
>> -     ret = install_special_mapping(mm, vdso_base, vdso_mapping_len,
>> +     ret = install_special_mapping(mm, vdso_base, vdso_text_len,
>>                                     VM_READ|VM_EXEC|
>>                                     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>>                                     vdso_pagelist);
>> -     if (ret) {
>> -             mm->context.vdso = NULL;
>> +     if (ret)
>> +             goto up_fail;
>> +
>> +     vdso_base += vdso_text_len;
>> +     ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
>> +                                   VM_READ|VM_MAYREAD,
>> +                                   vdso_pagelist + vdso_pages);
>
> I note this code sets VM_MAYREAD for the data page, while x86's vvar
> mapping sets only VM_READ.  (Personally I am not totally clear on the
> meaning of VM_MAYREAD, but it looks like it would have implications for
> use of mprotect on the mapping.)  Should one arch or the other adjust
> its flags?
>

On quick inspection, this doesn't matter.  That being said, VM_MAYREAD
seems reasonable here.  I'll queue up the x86 change.

--Andy
