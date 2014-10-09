From: lanchon@gmail.com (Lanchon)
Date: Thu, 09 Oct 2014 19:36:31 -0300
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <CAKv+Gu_=5=qA0S171s6ipofnBLcVTMT0xaDOGuhzuXZG=-BXDg@mail.gmail.com>
References: <54345FA7.9030606@gmail.com>	<20141007221515.GY5182@n2100.arm.linux.org.uk>	<5434F387.804@gmail.com>	<20141008083509.GD5182@n2100.arm.linux.org.uk>	<CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
 <CAKv+Gu_=5=qA0S171s6ipofnBLcVTMT0xaDOGuhzuXZG=-BXDg@mail.gmail.com>
Message-ID: <54370DEF.8010706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/08/2014 06:22 AM, Ard Biesheuvel wrote:
> On 8 October 2014 10:53, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>> Indeed. As part of the kernel mode NEON support (which landed in 3.12
>> I think?), the VFP trap handling now checks whether it occurred in
>> kernel mode or user mode.
>> Check arch/arm/vfp/vfphw.S:84 in your kernel tree for
>>
>> """
>> ldr r3, [sp, #S_PSR] @ Neither lazy restore nor FP exceptions
>> and r3, r3, #MODE_MASK @ are supported in kernel mode
>> teq r3, #USR_MODE
>> bne vfp_kmode_exception @ Returns through lr
>> """
>>
>> Without these lines, the lazy restore machinery may kick in during the
>> execution of an ISR that uses NEON registers inadvertently, and
>> overwrite your VFP state with that of the process that happens to be
>> active when the interrupt is taken.
>>
> Ehm ... maybe this is not entirely true. In order for the userland VFP
> state of some process to be clobbered, an ISR being executed while
> another process is active (which itself may not use the VFP at all)
> would not be sufficient, as it would be /that/ process's VFP state
> getting clobbered. So it is more likely (if you suspect the kernel)
> that the register is getting clobbered while the storage process has
> already 'unlocked' the VFP by accessing it from userland, which seems
> to be in agreement with your scenario of a syscall being performed,
> i.e., if no task switch occurs, the VFP would be unlocked during the
> execution of that syscall.

absolutely. this is the kind of fine detail i was asking in my first 
message. yes, 99% of the pread64s in question would happen with the FPU 
enabled. this is at the heart of question 1) i originally made, which 
for which i still didn't get a straight answer:

1) What is the FPU enable state while executing a kernel thread in ARM
arch? Which of these answers is correct?

1a) the FPU is always disabled in kernel threads.
1b) the FPU might be enabled or disabled in a kernel thread, depending
on the FPU enable state of the userland context that executed before
and/or some other factors.

(maybe i should have used 'kernel mode' instead.)

you are clearly assuming 1b) in your text. (maybe because you know 1a) 
to be false or maybe because you don't have the information.)


>
> So the question is, where does the VFP register write come from? Are
> there any out of tree modules in use, and if so, can you verify the
> CFLAGS? Note that merely using -O3 combined with -mfloat-abi=softfp
> may result in GCC emitting NEON instructions when it detects loops it
> can vectorize.
>

the flags are ok and the kernel works fine on other SoCs. there are 
several KOs but i can't find FPU instructions in them.

-mfloat-abi=softfp lets GCC use the FPU at its leisure. -mfloat-abi=soft 
is used everywhere.
