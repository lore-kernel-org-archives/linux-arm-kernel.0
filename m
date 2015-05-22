From: stefan@agner.ch (Stefan Agner)
Date: Fri, 22 May 2015 21:34:00 +0200
Subject: [PATCH soc] ARM: use =?UTF-8?Q?ARM=5FSINGLE=5FARMV=37M=20for?=
 =?UTF-8?Q?=20ARMv=37-M=20platforms?=
In-Reply-To: <20150522180647.GM2067@n2100.arm.linux.org.uk>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <15864413.ed8EFg1NLl@wuerfel>
 <CALszF6D-3pXHtyVMwhO0JkT-dCSSB98UNDHNN7-LD04Wdgd2cA@mail.gmail.com>
 <555F5194.4040309@linaro.org> <1a7d1161d007f0aff2a36ce8d30f14c3@agner.ch>
 <20150522180647.GM2067@n2100.arm.linux.org.uk>
Message-ID: <be5e1827041b67c8d6d37511af8d5505@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-22 20:06, Russell King - ARM Linux wrote:
> On Fri, May 22, 2015 at 06:28:16PM +0200, Stefan Agner wrote:
>> On 2015-05-22 17:56, Daniel Thompson wrote:
>> > On 22/05/15 16:29, Maxime Coquelin wrote:
>> >> 2015-05-22 16:50 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> >>> [one small request as I have four armv7-m folks on Cc already:
>> >>>   could one of you try to fix the warning that I get with every
>> >>>   single build: "/git/arm-soc/arch/arm/kernel/head-nommu.S: Assembler
>> >>> messages: /git/arm-soc/arch/arm/kernel/head-nommu.S:167: Warning:
>> >>> Use of r13 as a source register is deprecated when r15 is the
>> >>> destination register."]
>> >>
>> >> Moving r13 to r12 and returning r12 seems to do the job (see below).
>> >> But I don't know if there is a more elegant way, and if it is also
>> >> valid for other architectures than armv7-m.
>> >
>> > Why not just s/r13/r11/?
>> >
>> > (works for me but I'm only working on single core system)
>>
>> For ARMv7-M this works, since r11 is not used in the processors
>> PROCINFO_INITFUNC function (__cpu_flush in struct proc_info_list, which
>> is __v7m_setup in proc-v7m.S).
>>
>> However, afaik, head-nommu.S can be used by different processors too,
>> hence that register needs to be free to use for all possible __cpu_flush
>> implementations.
>>
>> That said, proc-v7.S stores r11 on the stack, so it really seems that
>> r11 is ok to use?
> 
> Please use r3 (as I just said).  We don't need random deviations between
> MMU and noMMU stuff - that just makes maintanence of other code more
> difficult.
> 
> You can also avoid the issues of having it passed through the processor
> specific init function (which isn't guaranteed to preserve r13) by
> doing this:
> 
> -	ldr	r13, =__mmap_switched		@ address to jump to after
> -						@ initialising sctlr
> 	badr	lr, 1f				@ return (PIC) address
> 	ldr	r12, [r10, #PROCINFO_INITFUNC]
> 	add	r12, r12, r10
> 	ret	r12
> - 1:	b	__after_proc_init
> +1:	ldr	r13, =__mmap_switched		@ address to jump to after
> +						@ initialising sctlr
> 	b	__after_proc_init

Hm, this is looks sensible, could also be used for head.S I guess...
secondary_startup would need a similar approach then.

> 
> However, because you have no MMU to turn on, and no address switch,
> you actually don't need any of this.  __after_proc_init can become
> a "function" which returns via the link register.
> 
> You can then do:
> 
> 1:	bl	__after_proc_init
> 	b	__mmap_switched
> 
> You'll need to fix secondary_startup in there as well:
> 
> -	adr	r4, __secondary_data
> -	ldmia	r4, {r7, r12}
> 	ldr	r7, __secondary_data
> 
> #ifdef CONFIG_ARM_MPU
> 	/* Use MPU region info supplied by __cpu_up */
> 	ldr	r6, [r7]			@ get secondary_data.mpu_szr
> 	bl	__setup_mpu			@ Initialize the MPU
> #endif
> 
> -	badr	lr, __after_proc_init		@ return address
> -	mov	r13, r12			@ __secondary_switched address
> +	badr	lr, 1f				@ return (PIC) address
> 	ldr	r12, [r10, #PROCINFO_INITFUNC]
> 	add	r12, r12, r10
> 	ret	r12
> -ENDPROC(secondary_startup)
> -
> -ENTRY(__secondary_switched)
> +1:	bl	__after_proc_init
> 	ldr	sp, [r7, #12]			@ set up the stack pointer
> 	mov	fp, #0
> 	b	secondary_start_kernel
> -ENDPROC(__secondary_switched)
> +ENDPROC(secondary_startup)

Sounds like a much simpler approach. Will test that and send out a patch
in case it works here.

--
Stefan
