From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Oct 2017 17:24:06 +0200
Subject: [PATCH v2 1/5] ARM: head-common.S: speed up startup code
In-Reply-To: <CAKv+Gu8BSnn3XhUALM-CfPqw2zNxovvup4uHf1F4qYZZ5oVUaA@mail.gmail.com>
References: <20170830025547.30347-1-nicolas.pitre@linaro.org>
 <20170830025547.30347-2-nicolas.pitre@linaro.org>
 <CAMuHMdXnYysiDURyztXv3bhBMyk0o1EN=JzwqwvUifzw5fFYAw@mail.gmail.com>
 <CAKv+Gu8BSnn3XhUALM-CfPqw2zNxovvup4uHf1F4qYZZ5oVUaA@mail.gmail.com>
Message-ID: <CAMuHMdXXZ6Z694VU+PByucG76NxEjiiq-+GV3uVhgBU_0f_ONA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hoi Ard,

On Tue, Oct 3, 2017 at 3:15 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 3 October 2017 at 13:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Aug 30, 2017 at 4:55 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>>> Let's use optimized routines such as memcpy to copy .data and memzero
>>> to clear .bss in the startup code instead of doing it one word at a
>>> time. Those routines don't use any global data so they're safe to use
>>> even if .data and .bss segments are not initialized.
>>>
>>> In the .data copy case a temporary stack is installed in the .bss area
>>> as the actual kernel stack is located within the copied data area. The
>>> XIP kernel linker script ensures a 8 byte alignment for that purpose.
>>>
>>> Finally, make the .data copy and related pointers surrounded by
>>> CONFIG_XIP_KERNEL to make it obvious what it is all about. This will
>>> allow for further cleanups in the non-XIP linker script.
>>>
>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> This is now commit 9520b1a1b5f7a348 ("ARM: head-common.S: speed up startup
>> code") in arm/for-next.
>>
>> If CONFIG_DEBUG_LOCK_ALLOC=y, the kernel log is spammed with a few hundred
>> identical messages on various Renesas systems:
>>
>>     unwind: Unknown symbol address c0800300
>>     unwind: Index not found c0800300
>>
>> I've bisected this to the aforementioned commit.
>>
>> c0800300 points to the instruction just after the __memzero call, cfr. below.
>>
>> Do you have a clue? Thanks!
>
> It looks like this patch results in start_kernel() being entered with
> a different value for lr than before. Could you please try setting it
> to zero instead, right before the jump to start_kernel() ?
>
> I don't think the patch itself is to blame here, it simply triggers an
> existing issue in the unwinder (if my analysis is correct, of course)

Your analysis looks correct to me, thanks! Patch sent.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
