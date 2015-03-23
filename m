From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 23 Mar 2015 18:47:53 +0000
Subject: [RFC PATCH 0/7] Pseudo-NMI for arm64 using ICC_PMR_EL1 (GICv3)
In-Reply-To: <20150320154544.GC4725@e103592.cambridge.arm.com>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <20150320154544.GC4725@e103592.cambridge.arm.com>
Message-ID: <55105FD9.5010909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/15 15:45, Dave Martin wrote:
> On Wed, Mar 18, 2015 at 02:20:21PM +0000, Daniel Thompson wrote:
>> This patchset provides a pseudo-NMI for arm64 kernels by reimplementing
>> the irqflags macros to modify the GIC PMR (the priority mask register is
>> accessible as a system register on GICv3 and later) rather than the
>> PSR. The pseudo-NMI changes are support by a prototype implementation of
>> arch_trigger_all_cpu_backtrace that allows the new code to be exercised.
>
> Hi there,
>
> Interesting series -- I've not gone into all the code in detail yet,
> but I have some high-level comments and questions first.
>
>>
>> In addition to the arm64 changes I've bundled in a few patches from
>> other patchsets to make the patchset self-contained. Of particular note
>> of the serial break emulation patch which allows ^B^R^K to be used
>> instead of a serial break to trigger SysRq-L (FVP UART sockets don't
>> seem to support serial breaks). This makes it easy to run
>> arch_trigger_all_cpu_backtrace from an IRQ handler (i.e. somewhere with
>> interrupts masked so we are forced to preempt and take the NMI).
>>
>> The code works-for-me (tm) but there are currently some pretty serious
>> limitations.
>>
>>   1. Exercised only on the foundation model with gicv3 support. It has
>>      not been exercised on real silicon or even on the more advanced
>>      ARM models.
>>
>>   2. It has been written without any documentation describing GICv3
>>      architecture (which has not yet been released by ARM). I've been
>>      guessing about the behaviour based on the ARMv8 and GICv2
>>      architecture specs. The code works on the foundation model but
>>      I cannot check that it conforms architecturally.
>
> Review is the best way to approact that for now.  If the code can be
> demonstrated on the model, that's a good start.
>
>>   3. Requires GICv3+ hardware together with firmware support to enable
>>      GICv3 features at EL3. If CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS is
>>      enabled the kernel will not boot on older hardware. It will be hard
>>      to diagnose because we will crash very early in the boot (i.e.
>>      before the call to start_kernel). Auto-detection might be possible
>>      but the performance and code size cost of adding conditional code to
>>      the irqflags macros probably makes it impractical. As such it may
>>      never be possible to remove this limitation (although it might be
>>      possible to find a way to survive long enough to panic and show the
>>      results on the console).
>
> This can (and should) be done via patching -- otherwise we risk breaking
> single kernel image for GICv2+v3.

Do you mean real patching (hunting down all those inlines and rewrite 
them) or simply implementing irqflags with an ops table? If the former I 
didn't look at this because I didn't release we could do that...


>>   4. No benchmarking (see #1 above). Unlike the PSR, updates to the PMR
>>      do not self synchronize which requires me to sprinkle isb
>>      instructions fairly liberally. I've been told the cost of isb varies
>>      from almost-free (A53) to somewhat costly (A57) thus we export this
>>      code to reduce kernel performance. However this needs to be
>>      quantified and I am currently unable to do this. I'd really like to
>>      but don't have any suitable hardware.
>>
>>   5. There is no code in el1_irq to detect NMI and switch from IRQ to NMI
>>      handling. This means all the irq handling machinary is re-entered in
>>      order to handle the NMI. This not safe and deadlocks are likely.
>>      This is a severe limitation although, in this proof-of-concept
>>      work, NMI can only be triggered by SysRq-L or severe kernel damage.
>>      This means we just about get away with it for simple test (lockdep
>>      detects that we are doing wrong and shows a backtrace). This is
>>      definitely the first thing that needs to be tackled to take this
>>      code further.
>
> Indeed, and this does look a bit weird at present... it took me a
> while to figure out where NMIs could possibly be coming from in
> this series.

My plan was to check the running priority register early in el1_irq and 
branch to a handler specific to NMI when the priority indicates we are 
handling a pseudo-NMI.


>> Note also that alternative approaches to implementing a pseudo-NMI on
>> arm64 are possible but only through runtime cooperation with other
>> software components in the system, potentially both those running at EL3
>> and at secure EL1. I should like to explore these options in future but,
>
> For the KVM case, vFIQ is an obvious choice, but you're correct that
> all other scenarios would require cooperation from a separate hypervisor/
> firmware etc.
>
> Ideally, we should avoid having multiple ways of implementing the same
> thing.
>
>> as far as I know, this is the only sane way to provide NMI-like features
>> whilst being implementable entirely in non-secure EL1[1]
>>
>> [1] Except for a single register write to ICC_SRE_EL3 by the EL3
>>      firmware (and already implemented by ARM trusted firmware).
>
> Even that would require more of the memory-mapped GIC CPU interface
> to be NS-accessible than is likely to be the case on product
> platforms.  Note also that the memory-mapped interface is not
> mandated for GICv3, so some platforms may simply not have it.

Perhaps I used clumsy phrasing here.

There is a main difference I care about is between runtime cooperation 
and boot-time cooperation. The approach I have taken in the patchset 
requires boot time cooperation (to configure GIC appropriately) but no 
runtime cooperation.

> Some other generalities that don't seem to be addressed yet:
>
> 	* How are NMIs prioritised with respect to other interrupts and
> 	  exceptions?  This needs to be concretely specified.  A sensible
> 	  answer would probably be that the effect is to split the
> 	  existing single-priority IRQ into two bands: ordinary IRQs
> 	  and NMIs.  Prioritisation against FIQ and other exceptions
> 	  would be unaffected.
>
> 	  I think this is effectively what you've implemented so far.

Pretty much. Normal interrupts run at the default priority and NMIs run 
at default priority but with bit 6 cleared.

In addition I would expect most kernel exception handlers to unmask the 
I-bit as soon as the context has been saved. This allows them to be 
pre-empted by an NMI.

>
> 	* Should it be possible to map SPIs as NMIs?  How would they
> 	  be configured/registed?  Should it be possible to register
> 	  multiple interrupts as NMIs?

Yes, although not quite yet.

The work on arm64 is following in the footsteps of similar work for arm.

My initial ideas are here (although as you can see from the review I've 
got a *long* way to go):
   http://thread.gmane.org/gmane.linux.kernel/1871163

However the basic theme is:

1. Use existing interrupt API to register NMI handlers (with special
    flag).

2. Flag makes callback to irqchip driver. In case of GICv3 this would
    alter the priority of interrupt (for ARMv7+FIQ it would also change
    interrupt group but this is not needed on ARMv8+GICv3).

3. "Simple" demux. We cannot traverse all the IRQ data structures from
    NMI due to locks within the structures so we need some simplifying
    assumptions. My initial simplifying assumptions were:

    a) NMI only for first level interrupt controller (i.e. peripherals
       directly attached to this controller).

    b) No shared interrupt lines.


Based on tglx's review I'm working on the basis that b) above is
simplication too many but I've not yet had the chance to go back and 
have anyother go.


As you can see from the reviews I have a bit of work to do in orde

> 	* What about interrupt affinity?

It should "just work" as normal if I can get the rest of the interrupt 
system right. Do you foresee a specific problem?


> Some other points:
>
> 	* I feel uneasy about using reserved SPSR fields to store
> 	  information.  This is probably OK for now, but it might
> 	  be cleaner simply to save/restore the PMR directly.
>
> 	  Providing that the affected bit is cleared before writing
> 	  to the SPSR (as you do already in kernel_exit) looks
> 	  workable, but wonder whether the choice of bit should be
> 	  UAPI -- it may have to change in the future.

I agree we ought to keep this out of the uapi.

Regarding stealing a bit from the SPSR this was mostly an implementation 
convenience. It might be interesting (eventually) to benchmark it 
against a more obvious approach.

> 	* You can probably thin out the ISBs.
>
> 	  I believe that the via the system register interface,
> 	  the GICC PMR is intended to be self-synchronising.

That sounds great. I've just found the relevant line in the ARMv8 
manual... I'd overlooked that before.

> 	* The value BPR resets to is implementation-dependent.
> 	  It should be initialised on each CPU if we are going to rely
> 	  on its value, on all platforms.  This isn't specific to FVP.

Really? As mentioned I only have a GICv2 spec but on that revision the 
reset value is the minimum supported value (i.e. the same effect as 
attempting to set it to zero). In other words it is technically 
implementation-dependent but nevertheless defaults to a setting that 
avoids any weird "globbing" effect on the interrupt priorities.

On FVP something has reached in and changed the BPR for CPU0 from its 
proper reset value (all oter CPUs have correct reset value). Of course 
that could be the firmware rather than the FVP itself that has caused this.

I guess it is good practice for a driver to re-establish the reset value 
for register it owns and cares about but nevertheles I still expect this 
register to as-reset when we handover to the kernel.

> 	* Is ICC_CTLR_EL1.CBPR set correctly?

I've never checked. On GICv2 that would be secure state so to be honest 
I didn't think its value is any of my business.

>
> Cheers
> ---Dave
>
