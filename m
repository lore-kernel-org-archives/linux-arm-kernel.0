From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 24 May 2017 09:44:53 -0700
Subject: [PATCHv2] ARM32: Support mremap() for sigpage/vDSO
In-Reply-To: <7dc84202-9f12-4f0e-a925-e050974e17b9@virtuozzo.com>
References: <20170414132529.8337-1-dsafonov@virtuozzo.com>
 <871579ef-ee9a-c321-80e4-47836bb0e472@virtuozzo.com>
 <bebbe3ce-12ed-419a-248a-55f41d74d9da@virtuozzo.com>
 <20170523200946.GG22219@n2100.armlinux.org.uk>
 <7dc84202-9f12-4f0e-a925-e050974e17b9@virtuozzo.com>
Message-ID: <CALCETrV9khCCCAu4G0nfttKV1ZfrxH6dkeSqsqwrngs-WYbpog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 3:09 AM, Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> + Adding back to CC x86 guys - as I've removed in ping messages.
>
> On 05/23/2017 11:09 PM, Russell King - ARM Linux wrote:
>>
>> On Thu, May 18, 2017 at 02:13:29PM +0300, Dmitry Safonov wrote:
>>>
>>> On 04/25/2017 08:18 PM, Dmitry Safonov wrote:
>>>>
>>>> On 04/14/2017 04:25 PM, Dmitry Safonov wrote:
>>>>>
>>>>> CRIU restores application mappings on the same place where they
>>>>> were before Checkpoint. That means, that we need to move vDSO
>>>>> and sigpage during restore on exactly the same place where
>>>>> they were before C/R.
>>>>>
>>>>> Make mremap() code update mm->context.{sigpage,vdso} pointers
>>>>> during VMA move. Sigpage is used for landing after handling
>>>>> a signal - if the pointer is not updated during moving, the
>>>>> application might crash on any signal after mremap().
>>>>>
>>>>> vDSO pointer on ARM32 is used only for setting auxv at this moment,
>>>>> update it during mremap() in case of future usage.
>>>>>
>>>>> Without those updates, current work of CRIU on ARM32 is not reliable.
>>>>> Historically, we error Checkpointing if we find vDSO page on ARM32
>>>>> and suggest user to disable CONFIG_VDSO.
>>>>> But that's not correct - it goes from x86 where signal processing
>>>>> is ended in vDSO blob. For arm32 it's sigpage, which is not disabled
>>>>> with `CONFIG_VDSO=n'.
>>>>>
>>>>> Looks like C/R was working by luck - because userspace on ARM32 at
>>>>> this moment always sets SA_RESTORER.
>>>>>
>>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
>>>>> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
>>>>> Cc: Christopher Covington <cov@codeaurora.org>
>>>>> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
>>>>> ---
>>>>> v2: (buildbot) Fix (unsinged long) to (void*) cast warning.
>>>>>
>>>>>   arch/arm/kernel/process.c |  8 ++++++++
>>>>>   arch/arm/kernel/vdso.c    | 18 ++++++++++++++++++
>>>>>   arch/x86/entry/vdso/vma.c |  3 ---
>>>>>   mm/mmap.c                 |  4 ++++
>>>>>   4 files changed, 30 insertions(+), 3 deletions(-)
>>>>
>>>>
>>>> Ping?
>>>
>>>
>>> Ping?
>>
>>
>> I'm mostly happy with the ARM bits, but I can't take the patch without
>> acks from others because it touches other architectures/generic code.
>>
>
> Fair enough, thanks.
>
> Andy, does moving of this WARN_ON() looks good to you?
> I've done it to reuse it over arches and between vdso/sigpage mappings,
> reducing code duplication.

Acked-by: Andy Lutomirski <luto@kernel.org> # For the x86 bit

>
> Here is the patch, so you don't need to search it in the mailbox:
> https://patchwork.kernel.org/patch/9681273/
>
> --
>              Dmitry
