From: junxiao.bi@windriver.com (Bi Junxiao)
Date: Wed, 23 Nov 2011 11:30:58 +0800
Subject: [PATCH 6/6] ARM: support kernel modules in BE8 mode
In-Reply-To: <20111122104700.GC2066@localhost.localdomain>
References: <20111122104700.GC2066@localhost.localdomain>
Message-ID: <4ECC68F2.5030803@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on 11/22/2011 06:47 PM Dave Martin wrote:
> On Tue, Nov 22, 2011 at 09:32:16AM +0800, Bi Junxiao wrote:
>    
>> on 11/22/2011 03:29 AM Nicolas Pitre wrote:
>>      
>>> On Tue, 15 Nov 2011, Junxiao Bi wrote:
>>>
>>>        
>>>> From: Stanley.Miao<stanley.miao@windriver.com>
>>>>
>>>> In BE8 mode, data must be manipulated in big endian format while
>>>> text must be little endian. Therefore, when relocating the text
>>>> section of module in BE8 mode, we must convert the location offset
>>>> of the text to big endian from the native little endian. After
>>>> the relocation is complete, the location offset value is re-written
>>>> as little endian.
>>>>
>>>> Since only BE8 mode has such special requirement while other big endian
>>>> mode not, cpu_to_le32 and le32_to_cpu can not be used to relocate the
>>>> text. We introduce write_instr* and read_instr* to do it.
>>>>
>>>> Signed-off-by: Stanley.Miao<stanley.miao@windriver.com>
>>>> Signed-off-by: Junxiao Bi<junxiao.bi@windriver.com>
>>>> ---
>>>>   arch/arm/Makefile         |    1 +
>>>>   arch/arm/include/asm/io.h |   12 ++++++++++
>>>>   arch/arm/kernel/module.c  |   51 +++++++++++++++++++++++----------------------
>>>>   3 files changed, 39 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>>>> index dfcf3b0..c858184 100644
>>>> --- a/arch/arm/Makefile
>>>> +++ b/arch/arm/Makefile
>>>> @@ -13,6 +13,7 @@
>>>>   LDFLAGS_vmlinux	:=-p --no-undefined -X
>>>>   ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>>>>   LDFLAGS_vmlinux	+= --be8
>>>> +LDFLAGS_MODULE	+= --be8
>>>>   endif
>>>>
>>>>   OBJCOPYFLAGS	:=-O binary -R .comment -S
>>>> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
>>>> index 065d100..4b6c7de 100644
>>>> --- a/arch/arm/include/asm/io.h
>>>> +++ b/arch/arm/include/asm/io.h
>>>> @@ -210,6 +210,18 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>>>>    * Again, this are defined to perform little endian accesses.  See the
>>>>    * IO port primitives for more information.
>>>>    */
>>>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>>>> +#define read_instr32(c)		__swab32(*(u32 *)(c))
>>>> +#define read_instr16(c)		__swab16(*(u16 *)(c))
>>>> +#define write_instr32(v, a)	(*(u32 *)(a) = __swab32((__force __u32)(v)))
>>>> +#define write_instr16(v, a)	(*(u16 *)(a) = __swab16((__force __u16)(v)))
>>>> +#else
>>>> +#define read_instr32(c)		(*(u32 *)(c))
>>>> +#define read_instr16(c)		(*(u16 *)(c))
>>>> +#define write_instr32(v, a)	(*(u32 *)(a) = (v))
>>>> +#define write_instr16(v, a)	(*(u16 *)(a) = (v))
>>>> +#endif
>>>>          
>>> NAK.  This has nothing to do with IO.
>>>
>>> If only module.c requires this, please move those definitions there.
>>>        
>> Not only modules, all components that needs to read and write text
>> segment like kprobes also needs this. As it is special to arm be8,
>> how about define it in arch/arm/include/asm/swab.h?
>>      
> I'm not sure where the correct place is, but I think having macros
> doing something along these lines would be useful.  The module loader
> is one relevant place, but there is also kprobes, and Rabin's recent
> ftrace series highlights the potential usefulness too.
>
> There are a lot of #ifdefs and swab hacks spread around various places
> wherever we need to load/store/relocate instructions.  Abstracting this
> properly so we don't need a load of fragile #ifdefs for the big-endian
> case is clearly a good idea.
>
> Because the Thumb 32-bit case is different from the ARM case, I would
> also recommend having three macro variants instead of two:
>
> *_instr_arm()
> *_instr_thumb16()
> *_instr_thumb32()
>    
These name makes more sense than mine.  I will use them. But it seems 
that we don't need all the three. It is enough with the first two.
For reading and writing thumb code, there is no difference as 32-bit 
thumb code is organized as two 16-bit parts. To read a 32-bit thumb 
code, we need using read_instr16 to read the first part, then check if 
it's a 32-bit thumb, if so then use read_instr16 to read the second part.
> Cheers
> ---Dave
>
>    
