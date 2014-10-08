From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 8 Oct 2014 11:22:32 +0200
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk>
 <5434F387.804@gmail.com>
 <20141008083509.GD5182@n2100.arm.linux.org.uk>
 <CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
Message-ID: <CAKv+Gu_=5=qA0S171s6ipofnBLcVTMT0xaDOGuhzuXZG=-BXDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2014 10:53, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 8 October 2014 10:35, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Oct 08, 2014 at 05:19:19AM -0300, Lanchon wrote:
>>> for instance, you say that if an ISR uses the FPU it would corrupt user
>>> FP state. fine, but it is not that simple. what if the FPU was disabled
>>> at the time of interrupt? (ie: lazy restore did not yet happen in this
>>> time-slice.)
>>
>> At that point, it depends on which kernel version you are using.  Yes,
>> older kernels will just restore the state.  Newer kernels will trap this
>> and complain.
>>
>
> Indeed. As part of the kernel mode NEON support (which landed in 3.12
> I think?), the VFP trap handling now checks whether it occurred in
> kernel mode or user mode.
> Check arch/arm/vfp/vfphw.S:84 in your kernel tree for
>
> """
> ldr r3, [sp, #S_PSR] @ Neither lazy restore nor FP exceptions
> and r3, r3, #MODE_MASK @ are supported in kernel mode
> teq r3, #USR_MODE
> bne vfp_kmode_exception @ Returns through lr
> """
>
> Without these lines, the lazy restore machinery may kick in during the
> execution of an ISR that uses NEON registers inadvertently, and
> overwrite your VFP state with that of the process that happens to be
> active when the interrupt is taken.
>

Ehm ... maybe this is not entirely true. In order for the userland VFP
state of some process to be clobbered, an ISR being executed while
another process is active (which itself may not use the VFP at all)
would not be sufficient, as it would be /that/ process's VFP state
getting clobbered. So it is more likely (if you suspect the kernel)
that the register is getting clobbered while the storage process has
already 'unlocked' the VFP by accessing it from userland, which seems
to be in agreement with your scenario of a syscall being performed,
i.e., if no task switch occurs, the VFP would be unlocked during the
execution of that syscall.

So the question is, where does the VFP register write come from? Are
there any out of tree modules in use, and if so, can you verify the
CFLAGS? Note that merely using -O3 combined with -mfloat-abi=softfp
may result in GCC emitting NEON instructions when it detects loops it
can vectorize.

-- 
Ard.



> You should also be aware that q4 is an alias of d8-d9, so grep'ing
> your objdump for d8 is not sufficient.
>
> --
> Ard.
>
>
>>> a plausible answer (which i am making up out of the blue) would be:
>>
>> If you want to continue asking questions and getting answers, change
>> your attitude; I am not a child.
>>
>> You should also consider *not* writing essays, but instead ask clear,
>> direct and to the point questions - in other words, short emails.  Not
>> everyone has the time or the patience to read huge long emails, or
>> huge rambling threads of 50+ pages on web forums.
>>
>> --
>> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
>> according to speedtest.net.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
