From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 8 Oct 2014 12:32:11 +0200
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <20141008095549.GF5182@n2100.arm.linux.org.uk>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk>
 <5434F387.804@gmail.com>
 <20141008083509.GD5182@n2100.arm.linux.org.uk>
 <CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
 <CAKv+Gu_=5=qA0S171s6ipofnBLcVTMT0xaDOGuhzuXZG=-BXDg@mail.gmail.com>
 <20141008095549.GF5182@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8XsDvKBVFO5BOcKdWUshqh8imuvpKE3oL_jRuGhP8jSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2014 11:55, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Ard,
>
> Note that you sent this message To: me, therefore you are addressing
> me in your message when you use "you".
>

My apologies. The Gmail interface obfuscates the To and Cc fields a bit.
I was indeed addressing Lanchon.

-- 
Ard.

> On Wed, Oct 08, 2014 at 11:22:32AM +0200, Ard Biesheuvel wrote:
>> On 8 October 2014 10:53, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 8 October 2014 10:35, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >> On Wed, Oct 08, 2014 at 05:19:19AM -0300, Lanchon wrote:
>> >>> for instance, you say that if an ISR uses the FPU it would corrupt user
>> >>> FP state. fine, but it is not that simple. what if the FPU was disabled
>> >>> at the time of interrupt? (ie: lazy restore did not yet happen in this
>> >>> time-slice.)
>> >>
>> >> At that point, it depends on which kernel version you are using.  Yes,
>> >> older kernels will just restore the state.  Newer kernels will trap this
>> >> and complain.
>> >>
>> >
>> > Indeed. As part of the kernel mode NEON support (which landed in 3.12
>> > I think?), the VFP trap handling now checks whether it occurred in
>> > kernel mode or user mode.
>> > Check arch/arm/vfp/vfphw.S:84 in your kernel tree for
>> >
>> > """
>> > ldr r3, [sp, #S_PSR] @ Neither lazy restore nor FP exceptions
>> > and r3, r3, #MODE_MASK @ are supported in kernel mode
>> > teq r3, #USR_MODE
>> > bne vfp_kmode_exception @ Returns through lr
>> > """
>> >
>> > Without these lines, the lazy restore machinery may kick in during the
>> > execution of an ISR that uses NEON registers inadvertently, and
>> > overwrite your VFP state with that of the process that happens to be
>> > active when the interrupt is taken.
>> >
>>
>> Ehm ... maybe this is not entirely true.
>
> It is true if VFP access was disabled, which is the scenario which
> Lanchon was asking about.  The answer to that is "it depends on the
> kernel version", and whether it has your patch as part of the kernel
> mode neon in place which traps these.
>
> Sure, if VFP access was enabled, then it is as I have already explained
> several times - kernel mode VFP usage will change the VFP state, and
> lead to userspace VFP state corruption.
>
> Given the reported scenario, it depends when the VFP access is happening.
> If it's happening before any scheduling, then VFP access will still be
> enabled and corruption will be silent.  If it happens after a scheduling
> event, then VFP access will have been disabled, and we should get a trap
> into the VFP support code.
>
> It should be noted that if it happens in a separate kernel thread, it
> will be independent of userland as it will have its own private and
> independent VFP state (but that doesn't mean we permit it.)
>
>> So the question is, where does the VFP register write come from? Are
>> there any out of tree modules in use, and if so, can you verify the
>> CFLAGS? Note that merely using -O3 combined with -mfloat-abi=softfp
>> may result in GCC emitting NEON instructions when it detects loops it
>> can vectorize.
>
> I can't :)  I assume you mean Lanchon... please address your messages a
> bit better!
>
> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
