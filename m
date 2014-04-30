From: keescook@chromium.org (Kees Cook)
Date: Wed, 30 Apr 2014 10:54:58 -0700
Subject: [PATCH 0/3] Make kexec work with CONFIG_DEBUG_RODATA enabled
In-Reply-To: <1C23526A7C42DB45BBF55B662C7C530E2B769FB60D@BUNGLE.Emea.Arm.com>
References: <1398677507-6687-1-git-send-email-Nikolay.Borisov@arm.com>
 <20140430130241.GA15719@arm.com>
 <1C23526A7C42DB45BBF55B662C7C530E2B769FB60D@BUNGLE.Emea.Arm.com>
Message-ID: <CAGXu5j+htWTt1V8VVCKM9Zkj3=bzEO16MoFisOCz6qUFvmsdTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 6:19 AM, Nikolay Borisov
<Nikolay.Borisov@arm.com> wrote:
>> From: Will Deacon [mailto:will.deacon at arm.com]
>> Hi Nikolay,
>>
>> On Mon, Apr 28, 2014 at 10:31:44AM +0100, Nikolay Borisov wrote:
>> > This patch makes kexec work on a kernel that has its .text section
>> set to read
>> > only. The main reason of doing it is because there is a patch in the
>> making
>> > (http://lists.infradead.org/pipermail/linux-arm-kernel/2014-
>> April/244779.html)
>> > which aims to make it possible to flag the kernel's code section as
>> read-only,
>> > rendering kexec inoperable.
>> >
>> > The first patch does the actual functional changes while the 2nd one
>> is
>> > optional and is only to be used in case you have already applied the
>> aforementioned
>> > CONFIG_DEBUG_RODATA patch
>> >
>> > Patch 3 is also optional and tries to make the assembly code a bit
>> more "sane"
>> > by introducing a .struct to describe the parameters for the kernel
>> relocation
>> > stub.
>> >
>> > Those patches have been tested on linux 3.14 on THUMB-2/non-THUMB-2
>> host
>> > kernels.
>> >
>> > Patch 1 and 3 apply cleanly on 3.15-rc3 and Patch 2 applies cleanly,
>> provided
>> > that Kees' patch is applied as well.
>> >
>> > Kees also managed to test that on a QEMU 2.0 based machine.
>>
>> Wouldn't it be far simpler to set_kernel_text_rw() on a kexec? At this
>> point, we've committed to replacing our image, so whether we can write
>> to the .text of the old image before we clobber it entirely seems somewhat
>> moot to me.
>>
>
> We are poking one of the values in the prepare stage so doing set_kernel_text_rw() there
> won't be very clean solution. However, I agree that if the values being poked into the prep

set_kernel_text_rw() is also mm-specific, since the PMD sections are
copied per-mm. I'm not sure if that's as much of a problem here since
the prepare looks to be all in the same thread, but if we can avoid
set_kernel_text_rw() that'll probably make things less surprising if
changes are made later on.

-Kees

> stage is stashed in a static variable and then in the kexec_execute function we make the kernel
> RW since we are turning the MMO off and nuking the old kernel anyway.
>
>> Will
>
> Regards,
> Nikolay
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
> ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
> ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
>



-- 
Kees Cook
Chrome OS Security
