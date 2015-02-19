From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 19 Feb 2015 17:13:32 +0100
Subject: [PATCH 02/14] ARM: ARMv7M: Enlarge vector table to 256 entries
In-Reply-To: <CAL_Jsq+rHFPXmWqByvdG435tpbO_+ODByiMcdxboULYpUfDUmg@mail.gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-3-git-send-email-mcoquelin.stm32@gmail.com>
 <CAMuHMdWESyPktOSBfVoZCb35stUbhNpbbpzSW4JfORdObgg5jw@mail.gmail.com>
 <CALszF6BDa9pUb534YN2z9DbYA+hPCnG8XYy5YbjJwSiseKz4xg@mail.gmail.com>
 <CAL_Jsq+rHFPXmWqByvdG435tpbO_+ODByiMcdxboULYpUfDUmg@mail.gmail.com>
Message-ID: <CALszF6DyVqaE6DLKSQHeuYWgSChzhEtCbmOsbjoTkvipquBivw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

2015-02-15 23:42 GMT+01:00 Rob Herring <robherring2@gmail.com>:
> On Fri, Feb 13, 2015 at 2:42 AM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> Hi Geert,
>>
>> 2015-02-12 21:34 GMT+01:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>>> On Thu, Feb 12, 2015 at 6:45 PM, Maxime Coquelin
>>> <mcoquelin.stm32@gmail.com> wrote:
>>>> From Cortex-M4 and M7 reference manuals, the nvic supports up to 240
>>>> interrupts. So the number of entries in vectors table is 256.
>>>>
>>>> This patch adds the missing entries, and change the alignement, so that
>>>> vector_table remains naturally aligned.
>>>
>>> Shouldn't this depend on ARCH_STM32, or some other M4 or M7 specific
>>> Kconfig option, to avoid wasting the space on other CPUs?
>>
>> Actually, the STM32F429 has 90 interrupts, so it would need 106
>> entries in the vector table.
>> The maximum of supported interrupts is not only for Cortex-M4 and M7,
>> this is also true for Cortex-M3.
>>
>> I see two possibilities:
>>  1 - We declare the vector table for the maximum supported number of
>> IRQs, as this patch does.
>>         - Pro: it will be functionnal with all Cortex-M MCUs
>>         - Con: Waste of less than 1KB for memory
>
> The waste depends on the alignment size as well and could be up to
> almost 2KB worst case. It varies depending on the padding. We should
> try to place it so it always aligned and the wasted space is
> minimized.

Sorry, I just notice I didn't replied to all. That was my question:

Do you mean by forcing its location in the arch/arm/kernel/vmlinux.lds.S file?

Regards,
Maxime

>
> Rob
>
>>  2 - We introduce a config flag that provides the number of interrupts
>>         - Pro: No more memory waste
>>         - Con: Need to declare a per MCU model config flag.
>>
>> Then, regarding the natural alignment, is there a way to ensure it
>> depending on the value of a config flag?
>> Or we should keep it at the maximum value possible?
>>
>> Any feedback will be appreciated, especially from Uwe who maintains
>> the efm32 machine.
>>
>> Kind regards,
>> Maxime
