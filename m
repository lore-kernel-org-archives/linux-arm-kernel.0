From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 5 Apr 2011 17:49:28 +0100
Subject: RFC: Status of kernel/fiq.c
In-Reply-To: <20110405162443.GA11737@n2100.arm.linux.org.uk>
References: <20110405160546.GA7976@arm.com>
	<20110405162443.GA11737@n2100.arm.linux.org.uk>
Message-ID: <BANLkTine4UQjcDNDa_ECBbFQL+2RD0tXmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 5, 2011 at 5:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 05, 2011 at 05:05:47PM +0100, Dave Martin wrote:
>> Hi all,
>>
>> I've hit a Thumb-2 compatibility issue in the assembler functions
>> in kernel/fiq.c, and I'm wondering how to proceed.
>>
>> With regard to set_fiq_regs() and get_fiq_regs(), does anyone know:
>>
>> ? * whether we still need the stack frame manipulation code in this
>> ? ? ? leaf function, e.g.
>>
>> ? ? ? ? "mov ? ?ip, sp\n\
>> ? ? ? ? stmfd ?sp!, {fp, ip, lr, pc}\n\
>> ? ? ? ? sub ? ?fp, ip, #4\n\
>
> That's the standard APCS stack frame. ?Look at the function closely
> and you'll notice that its declared NAKED, so the compiler doesn't
> generate anything for it. ?So we have to do this by hand.

I guess my question was more whether it's necessary to generate the
stack frame at all for a leaf function such as this -- partly because
the instruction forms involved are themselves deprecated in v7 (lr and
pc in the same ldm/stm, stm of the pc).  We can code around that, but
it gets increasingly ugly.

I guess it we get a fault while transferring the registers, the stack
frame might be needed in order to get an intelligible crash dump, but
otherwise... ?

For Thumb-2 it's not applicable of course, since we don't have
APCS-style stack frames there; and since coding the equivalent code in
Thumb would be painful my preference would be to #ifdef it out.

>
>> ? * what the nop (mov r0,r0) after the CPSR writes is for
>> ? ? ? ? (I'm guessing there may have been some 1-instruction hazard
>> ? ? ? ? here for some old processors, but I'm not aware of a need
>> ? ? ? ? for this in anything current.)
>
> You're correct, and its for ARMv3 CPUs. ?After writing the CPSR you
> have to wait one cycle before accessing the banked registers. ?On
> other platforms that has been solved so the nop is harmless even
> though it's not necessary. ?Simplification of code dictates that we
> don't try to ifdef it.

OK; it's harmless to leave that instruction in there, but it's
interesting to know.

>
>> ? * should anyone be using fiq.c on v7 platforms?
>
> Is the FIQ wired to anything useful on ARMv7.

FIQ gets used by TrustZone on platforms which use it, so I think it's
becoming less common to use it for normal peripherals.  The latency
difference between IRC and FIQ is also less important in more recent
platforms, so I think it's generally seeing less use.

I need to check my config -- maybe CONFIG_FIQ is getting pulled in
inappropriately.

set_fiq_regs() for example isn't used by much...

linux$ git grep set_fiq_regs
arch/arm/include/asm/fiq.h:extern void set_fiq_regs(struct pt_regs *regs);
arch/arm/kernel/fiq.c:void __naked set_fiq_regs(struct pt_regs *regs)
arch/arm/kernel/fiq.c:EXPORT_SYMBOL(set_fiq_regs);
arch/arm/mach-omap1/ams-delta-fiq.c:	set_fiq_regs(&FIQ_regs);
arch/arm/mach-rpc/dma.c:	set_fiq_regs(&regs);
drivers/media/video/mx1_camera.c:	set_fiq_regs(&regs);
drivers/spi/spi_s3c24xx.c:	set_fiq_regs(&regs);
sound/soc/imx/imx-pcm-fiq.c:	set_fiq_regs(&regs);

>
>> As the code stands, it could also go wrong if the compiler
>> happens to allocate r8-r12 or lr for one of the inline asm
>> constraints -- though this is pretty unlikely to happen, and
>> I doubt if it ever has happened in practice.
>
> Actually, that goes for r8 to r14 inclusive - as we switch the CPU mode to
> FIQ, we lose access to any values held in those registers prior to the
> assembly block being started.

True -- I was assuming that the compiler won't touch sp for register
allocation purposes, though the fact that we temporarily switch out
this register provides yet another reason why the compiler shouldn't
touch it (albeit a reason the compiler doesn't know about).

>
> The only possibility of it being unsafe is if the compiler allocates 'ip'
> for 'tmp'. ?We could work around that by getting rid of 'tmp' or telling
> the compiler that 'tmp' is a register variable and it will be r3.
>

That was basically my fix too.  Using the same style as the existing
code but using register variables with explicit register assignments
keeps things pretty clear.

I find it hard to imagine the compiler being so crazy in its register
allocation, but there are occasional surprises...

Cheers
---Dave
