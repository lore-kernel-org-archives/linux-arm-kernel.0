From: marc.ceeeee@gmail.com (Marc C)
Date: Mon, 3 Jun 2013 19:23:09 -0700
Subject: [RFC PATCH] ARM: update legacy CPU ID in decompressor cache
 support jump table
In-Reply-To: <20130604003525.GI599@codeaurora.org>
References: <CAO1A-8AaWyp6eq7c5nkU=KBxwrm1CM3erXcsxLmYpCn2mHhMUA@mail.gmail.com>
 <20130604003525.GI599@codeaurora.org>
Message-ID: <CAO1A-8BtUvDELaPvTw_gG1MB4JdMUYt8rmVP2oy+YoJENTvW2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Stephen pointed out a patch by Brian [1] which switches out the
initial entry in the cache/MMU jump table so that ARM-v7 processors
from non-ARM vendors can use the appropriate cache maintenance and MMU
setup routines. Your response to an RFC [2] solves this problem
without requiring adding an #if/#endif to boot.S. Which method would
you prefer?

[1] - http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7736/1
[2] - http://lists.infradead.org/pipermail/linux-arm-kernel/2010-January/007871.html

Regards,
Marc
marc.ceeeee at gmail.com

On Mon, Jun 3, 2013 at 5:35 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/03, Marc C wrote:
>> Hello,
>>
>> The following is a formal RFC PATCH for the suggestion offered by rmk
>> in this thread:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-January/007871.html
>>
>> The previous mask values for the legacy ARM CPU IDs were conflicting
>> with the CPU ID assignments for late-generation CPUs (like the
>> Qualcomm MSM/QSD or Broadcom Brahma-15 processors). This change
>> corrects the legacy ARM CPU ID value so that the jump table can
>> fall-through to the appropriate cache maintenance / MMU functions.
>>
>> To: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
>> ---
>>  arch/arm/boot/compressed/head.S |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index fe4d9c3..a1b9e83 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -805,8 +805,8 @@ call_cache_fn:      adr     r12, proc_types
>>                 .align  2
>>                 .type   proc_types,#object
>>  proc_types:
>> -               .word   0x00000000              @ old ARM ID
>> -               .word   0x0000f000
>> +               .word   0x41000000              @ old ARM ID
>> +               .word   0xff00f000
>>                 mov     pc, lr
>>   THUMB(                nop                             )
>>                 mov     pc, lr
>
> I sent a similar patch and Russell just applied it[1]. It removes
> this entry on V7 builds. Your patch will also work for me.
>
> [1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7736/1
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
