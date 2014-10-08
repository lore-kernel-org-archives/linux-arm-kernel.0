From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 8 Oct 2014 10:53:52 +0200
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <20141008083509.GD5182@n2100.arm.linux.org.uk>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk>
 <5434F387.804@gmail.com>
 <20141008083509.GD5182@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2014 10:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Oct 08, 2014 at 05:19:19AM -0300, Lanchon wrote:
>> for instance, you say that if an ISR uses the FPU it would corrupt user
>> FP state. fine, but it is not that simple. what if the FPU was disabled
>> at the time of interrupt? (ie: lazy restore did not yet happen in this
>> time-slice.)
>
> At that point, it depends on which kernel version you are using.  Yes,
> older kernels will just restore the state.  Newer kernels will trap this
> and complain.
>

Indeed. As part of the kernel mode NEON support (which landed in 3.12
I think?), the VFP trap handling now checks whether it occurred in
kernel mode or user mode.
Check arch/arm/vfp/vfphw.S:84 in your kernel tree for

"""
ldr r3, [sp, #S_PSR] @ Neither lazy restore nor FP exceptions
and r3, r3, #MODE_MASK @ are supported in kernel mode
teq r3, #USR_MODE
bne vfp_kmode_exception @ Returns through lr
"""

Without these lines, the lazy restore machinery may kick in during the
execution of an ISR that uses NEON registers inadvertently, and
overwrite your VFP state with that of the process that happens to be
active when the interrupt is taken.

You should also be aware that q4 is an alias of d8-d9, so grep'ing
your objdump for d8 is not sufficient.

-- 
Ard.


>> a plausible answer (which i am making up out of the blue) would be:
>
> If you want to continue asking questions and getting answers, change
> your attitude; I am not a child.
>
> You should also consider *not* writing essays, but instead ask clear,
> direct and to the point questions - in other words, short emails.  Not
> everyone has the time or the patience to read huge long emails, or
> huge rambling threads of 50+ pages on web forums.
>
> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
