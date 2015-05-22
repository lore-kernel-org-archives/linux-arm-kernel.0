From: stefan@agner.ch (Stefan Agner)
Date: Fri, 22 May 2015 18:28:16 +0200
Subject: [PATCH soc] ARM: use =?UTF-8?Q?ARM=5FSINGLE=5FARMV=37M=20for?=
 =?UTF-8?Q?=20ARMv=37-M=20platforms?=
In-Reply-To: <555F5194.4040309@linaro.org>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <15864413.ed8EFg1NLl@wuerfel>
 <CALszF6D-3pXHtyVMwhO0JkT-dCSSB98UNDHNN7-LD04Wdgd2cA@mail.gmail.com>
 <555F5194.4040309@linaro.org>
Message-ID: <1a7d1161d007f0aff2a36ce8d30f14c3@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-22 17:56, Daniel Thompson wrote:
> On 22/05/15 16:29, Maxime Coquelin wrote:
>> 2015-05-22 16:50 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>> [one small request as I have four armv7-m folks on Cc already:
>>>   could one of you try to fix the warning that I get with every
>>>   single build: "/git/arm-soc/arch/arm/kernel/head-nommu.S: Assembler
>>> messages: /git/arm-soc/arch/arm/kernel/head-nommu.S:167: Warning:
>>> Use of r13 as a source register is deprecated when r15 is the
>>> destination register."]
>>
>> Moving r13 to r12 and returning r12 seems to do the job (see below).
>> But I don't know if there is a more elegant way, and if it is also
>> valid for other architectures than armv7-m.
> 
> Why not just s/r13/r11/?
> 
> (works for me but I'm only working on single core system)

For ARMv7-M this works, since r11 is not used in the processors
PROCINFO_INITFUNC function (__cpu_flush in struct proc_info_list, which
is __v7m_setup in proc-v7m.S).

However, afaik, head-nommu.S can be used by different processors too,
hence that register needs to be free to use for all possible __cpu_flush
implementations.

That said, proc-v7.S stores r11 on the stack, so it really seems that
r11 is ok to use?

--
Stefan
