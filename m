From: khilman@ti.com (Kevin Hilman)
Date: Tue, 15 Feb 2011 08:15:20 -0800
Subject: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <AANLkTinz1055v7x0y2W_AYkbj+9h7z_cGtF4xn4=pkQ7@mail.gmail.com>
	(Dave Martin's message of "Tue, 15 Feb 2011 10:45:16 +0000")
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
	<87pqqy6tdj.fsf@ti.com> <20110214131750.GA2869@arm.com>
	<alpine.LFD.2.00.1102140950580.14920@xanadu.home>
	<20110214153726.GA20144@arm.com> <87zkpyxl64.fsf@ti.com>
	<AANLkTinz1055v7x0y2W_AYkbj+9h7z_cGtF4xn4=pkQ7@mail.gmail.com>
Message-ID: <87ei79uvdz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <dave.martin@linaro.org> writes:

> On Mon, Feb 14, 2011 at 11:15 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Hi Dave,
>>
>> Dave Martin <dave.martin@linaro.org> writes:
>>
>>> On Mon, Feb 14, 2011 at 10:00:23AM -0500, Nicolas Pitre wrote:
>>>> On Mon, 14 Feb 2011, Dave Martin wrote:
>>>>
>>>> > @@ -289,8 +297,20 @@ clean_l2:
>>>> > ? ? * ?- should be faster and will change with kernel
>>>> > ? ? * ?- 'might' have to copy address, load and jump to it
>>>> > ? ? */
>>>> > +#ifdef CONFIG_THUMB2_KERNEL
>>>> > + ?/* kernel is non-interworking : must do this from Thumb */
>>>> > + ?adr ? ? r1, . + 1
>>>> > + ?bx ? ? ?r1
>>>> > + ?.thumb
>>>> > +#endif
>>>> > ? ?ldr ? ? r1, kernel_flush
>>>>
>>>> Didn't you mean this instead:
>>>>
>>>> ? ? ?/* kernel is non-interworking : must do this from Thumb */
>>>> ? ? ?adr ? ? r1, 1f + 1
>>>> ? ? ?bx ? ? ?r1
>>>> ? ? ?.thumb
>>>> 1: ? ldr ? ? r1, kernel_flush
>>>> ? ? ?...
>>>
>>> Note that this is intended as an experimental hack, not a real patch
>>> (apologies if I didn't make that clear...)
>>>
>>> Well, actually I meant "add r1, pc, #1" ... which means I was too
>>> busy trying to be clever... oops!
>>>
>>> That is of course exactly equivalent to your code...
>>>
>>>>
>>>> ?
>>>>
>>>> > ? ?blx ? ? r1
>>>> > +#ifdef CONFIG_THUMB2_KERNEL
>>>> > + ?.align
>>>> > + ?bx ? ? ?pc
>>>> > + ?nop
>>>> > + ?.arm
>>>>
>>>> Also here, the .align has the potential to introduce a zero halfword in
>>>> the instruction stream before the bx. ?What about:
>>>>
>>>> ? ? ?adr ? ? r3, 1f
>>>> ? ? ?bx ? ? ?r3
>>>> ? ? ?.align
>>>> ? ? ?.arm
>>>> 1: ? ...
>>>
>>> .align inserts a 16-bit nop when misaligned in Thumb in a text section,
>>> and a word-aligned bx pc is a specific architecturally allowed way
>>> to do an inline switch to ARM. ?The linker uses this trick for PLT
>>> veneers etc.
>>>
>>> A nicer fix for doing this sort of call from low-level code which
>>> might be ARM is to convert arch/arm/mm/*-v7.S to use "bx lr" to return.
>>>
>>> Generally, we can do this for all arches >= v5, without any
>>> incompatibility. ?However, since the need for it will be rare and it
>>> will generate patch noise for not much real benefit,
>>> I haven't proposed this.
>>>
>>> Updated patch below.
>>
>> I tested the updated patch on top of your "dirty" branch I tested with
>> last week, and now see off-mode working just fine.
>
> Thanks for testing-- that's great news.
>
> I will have a think about whether the patch can be tidied up to revert
> most of the code back to Thumb, though that isn't essential.  If I've
> understood what's going on correctly, I think only the restore entry
> points, SMC call sites and the entry to omap3_sram_configure_core_dpll
> could need to be ARM; the rest shouldn't really make any difference...

Yes, that sounds right.

Kevin
