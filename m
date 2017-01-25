From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Jan 2017 17:25:06 +0000
Subject: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
In-Reply-To: <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej>
 <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
Message-ID: <20170125172505.GB29027@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 02:46:12PM +0800, Fu Wei wrote:
> Hi Mark,

Hi,

> On 25 January 2017 at 01:24, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei at linaro.org wrote:
> >> From: Fu Wei <fu.wei@linaro.org>
> >>
> >> The counter frequency detection call(arch_timer_detect_rate) combines two
> >> ways to get counter frequency: system coprocessor register and MMIO timer.
> >> But in a specific timer init code, we only need one way to try:
> >> getting frequency from MMIO timer register will be needed only when we
> >> init MMIO timer; getting frequency from system coprocessor register will
> >> be needed only when we init arch timer.
> >
> > When I mentioned this splitting before, I had mean that we'd completely
> > separate the two, with separate mmio_rate and sysreg_rate variables.
> 
> sorry for misunderstanding.
> 
> Are you saying :
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c
> b/drivers/clocksource/arm_arch_timer.c
> index 663a57a..eec92f6 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -65,7 +65,8 @@ struct arch_timer {
> 
>  #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
> 
> -static u32 arch_timer_rate;
> +static u32 arch_timer_sysreg_rate ;
> +static u32 arch_timer_mmio_rate;
>  static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
> 
>  static struct clock_event_device __percpu *arch_timer_evt;
> 
> 
> But what have I learned From ARMv8 ARM is
> AArch64 System register CNTFRQ_EL0 is provided so that software can
> discover the frequency of the system counter.
> CNTFRQ(in CNTCTLBase and CNTBaseN) is provided so that software can
> discover the frequency of the system counter.
> The bit assignments of the registers are identical in the System
> register interface and in the memory-mapped system level interface.

This means that the bits in the registers have the same meaning.

However, they are separate registers, and must be written separately. A
write to one does not propagate to the other, and they are not
guaranteed to contain the same value.

> So I think they both contain the same value : the frequency of the
> system counter, just in different view, and can be accessed in
> different ways.

Certainly, in theory, these *should* contain the same value.

Unfortunately, in practice, on several systems, they do not. It is very
easy to forget to initialise one of these registers correctly, and it's
possible for some software to work (masking the issue), while other
software will fail very quickly. I very much suspect we will see the
same class of issue on ACPI systems.

Consider a system where the sysreg CNTFRQ was correct, but the MMIO
CNTFRQ contains an erroneous non-zero value.

If we get the frequency out of CNTFRQ_EL0 first, and assign this to
arch_timer_rate, we won't bother to look at the MMIO registers (which
could contain erroneous values). If we read an erroneous CNTBaseN.CNTFRQ
value first, and assign this to arch_timer_rate, we won't look at
CNTFRQ_EL0.

This is *very* fragile w.r.t. probe order. I don't like the fragility of
setting a common arch_timer_rate depending on which gets probed first,
as this masks a bug, which will adversely affect us later.

This is already a problem for DT systems, and I do not want this problem
to spread to ACPI systems.

For ACPI, the approach I'd personally like to take is to keep the two
rates separate. Probe the sysreg timer first and subsequently probe the
MMIO timers. If the MMIO CNTFRQ (of all frames) does not match the
sysreg CNTFRQ, we log a warning and give up probing the MMIO timers.

For legacy reasons, DT is going to be more complicated, but I believe we
can apply that approach to ACPI.
 
> So do we really need to separate mmio_rate and sysreg_rate variables?
> 
> And for CNTFRQ(in CNTCTLBase and CNTBaseN) , we can NOT access it in
> Linux kernel (EL1),
> Because ARMv8 ARM says:
> In a system that implements both Secure and Non-secure states, this
> register is only accessible by Secure accesses.

CNTCTLBase.CNTFRQ can only be accessed in secure states. That is clear
from Table I1-3 in ARM DDI 0487A.k_iss10775). I agree that we cannot
access this.

For CNT{,EL0}BaseN.CNTFRQ, I am very concerned by the wording in the
current ARMv8 ARM ARM. This does not match my understanding, nor does it
match the description in the ARMv7 ARM. I believe this may be a
documentation error, and I'm chasing that up internally.

Either the currently logic in the driver which attempts to read
CNT{,EL0}BaseN.CNTFRQ is flawed, or the description in the ARM ARM is
erroneous.

> That means we still need to get the frequency of the system counter
> from CNTFRQ_EL0 in MMIO timer code.
> This have been proved when I tested this driver on foundation model, I
> got "0" when I access CNTFRQ from Linux kernel (Non-secure EL1)

As mentioned in I3.5.7, the CNTBase{,EL0}N.CNTFRQ values are UNKNOWN out
of reset, and require configuration by FW.

> So I guess the logic of the original code is
>  static u32 arch_timer_rate keeps the frequency of the system counter,
>  no matter where the value comes from.
> Because  they should be the same value. if we have got the frequency
> of the system counter(arch_timer_rate != 0), then we don't need to get
> it again, even in anther way.

Unfortunately, in practice this is not the case. :(

Thanks,
Mark.
