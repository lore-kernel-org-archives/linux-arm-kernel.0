From: stanleymiao@gmail.com (Stanley.Miao)
Date: Wed, 19 Jan 2011 14:21:00 +0800
Subject: [PATCH 1/3] Support BE8 mode kernel modules relocation
In-Reply-To: <AANLkTi=F8_Zmm4OM2=JPMzSWbm0-Nyr4mxSPUNpdBg3N@mail.gmail.com>
References: <1295253729-23153-1-git-send-email-stanley.miao@windriver.com>
	<1295253729-23153-2-git-send-email-stanley.miao@windriver.com>
	<AANLkTi=RSpXHRpoZJsGLhVgQ=E=tcNGm8GXYC9UPaDrA@mail.gmail.com>
	<AANLkTi=q=e03GhmNZypGa5na2OiAr8SAOtiXm=+NPq5t@mail.gmail.com>
	<AANLkTi=F8_Zmm4OM2=JPMzSWbm0-Nyr4mxSPUNpdBg3N@mail.gmail.com>
Message-ID: <AANLkTiktrCOxOH30ooM_Z=ct=cR5z49DiB+P4mqzi55E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/18 Catalin Marinas <catalin.marinas@arm.com>:
> On 18 January 2011 01:22, Stanley.Miao <stanleymiao@gmail.com> wrote:
>> 2011/1/17 Catalin Marinas <catalin.marinas@arm.com>:
>>> On 17 January 2011 08:42, Stanley.Miao <stanley.miao@windriver.com> wrote:
>>>> The code section in BE8 kernel modules is in little-endian while data
>>>> section is in big-endian. When reading code from memory in the relocation
>>>> procedure, these instructions are read according to big-endian, so they
>>>> need to be inverted before writing to memory and after reading from memory.
>>> [...]
>>>> --- a/arch/arm/include/asm/io.h
>>>> +++ b/arch/arm/include/asm/io.h
>>>> @@ -233,6 +233,18 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>>>>
>>>> ?#endif /* __mem_pci */
>>>>
>>>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>>>> +#define read_instr32(c) ? ? ? ? ? ? ? ? ? ? ? ?__swab32(*(u32 *)c)
>>>> +#define read_instr16(c) ? ? ? ? ? ? ? ? ? ? ? ?__swab16(*(u16 *)c)
>>>> +#define write_instr32(v,a) ? ? ? ? ? ? (*(u32 *)(a) = __swab32((__force __u32)(v)))
>>>> +#define write_instr16(v,a) ? ? ? ? ? ? (*(u16 *)(a) = __swab16((__force __u16)(v)))
>>>> +#else
>>>> +#define read_instr32(c) ? ? ? ? ? ? ? ? ? ? ? ?(*(u32 *)c)
>>>> +#define read_instr16(c) ? ? ? ? ? ? ? ? ? ? ? ?(*(u16 *)c)
>>>> +#define write_instr32(v,a) ? ? ? ? ? ? (*(u32 *)(a) = (v))
>>>> +#define write_instr16(v,a) ? ? ? ? ? ? (*(u16 *)(a) = (v))
>>>> +#endif
>>>
>>> Can we not use cpu_to_le32 etc in here (and as Russell said, they are
>>> not really IO)?
>>
>> Except moving these definition to arch/arm/kernel/module.c, do I need
>> to do other modifications ?
>
> Just personal preference (not important), I'd rather have a "u32
> instr" variable set by read_instr32() than this kind of functional
> style (in C code, I'm fine with it otherwise):

upper, lower and offset are used. It looks we don't need another "instr".

>
>> + ? ? ? ? ? ? ? ? ? ? ? write_instr32((read_instr32(loc) & 0xff000000) |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (offset & 0x00ffffff), loc);
>
> BTW (not related to modules, but since you are looking at this), when
> we copy the sigreturn_codes to the vectors page in early_trap_init(),
> do they get there in little endian form (as required by BE8)?

No, they get there in big endian.They are read as data in the function
setup_return().

retcode = KERN_SIGRETURN_CODE + (idx << 2) + thumb;


Stanley.

>
> --
> Catalin
>
