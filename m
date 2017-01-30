From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jan 2017 17:49:59 +0000
Subject: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
In-Reply-To: <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej>
 <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <20170125172505.GB29027@leverpostej>
 <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
Message-ID: <20170130174958.GA3496@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 01:49:03PM +0800, Fu Wei wrote:
> On 26 January 2017 at 01:25, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jan 25, 2017 at 02:46:12PM +0800, Fu Wei wrote:
> >> On 25 January 2017 at 01:24, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Jan 18, 2017 at 09:25:32PM +0800, fu.wei at linaro.org wrote:
> >> >> From: Fu Wei <fu.wei@linaro.org>

> > For CNT{,EL0}BaseN.CNTFRQ, I am very concerned by the wording in the
> > current ARMv8 ARM ARM. This does not match my understanding, nor does it
> > match the description in the ARMv7 ARM. I believe this may be a
> > documentation error, and I'm chasing that up internally.
> >
> > Either the currently logic in the driver which attempts to read
> > CNT{,EL0}BaseN.CNTFRQ is flawed, or the description in the ARM ARM is
> > erroneous.
> 
> Yes, those description did confuse me. :-(
> 
> But according to another document(ARMv8-A Foundation Platform User
> Guide  ARM DUI0677K),
> Table 3-2 ARMv8-A Foundation Platform memory map (continued)
> 
> AP_REFCLK CNTBase0, Generic Timer 64KB   S
> AP_REFCLK CNTBase1, Generic Timer 64KB   S/NS
> 
> Dose it means the timer frame 0 can be accessed in SECURE status  only,
> and the timer frame 1 can be accessed in both status?

That does appear to be what it says.

I assume in this case CNTCTLBase.CNTSAR<0> is RES0.

> And because Linux kernel is running on Non-secure EL1, so should we
> skip "SECURE" timer in Linux?

I guess you mean by checking the GTx Common flags, to see if the timer
is secure? Yes, we must skip those.

Looking further at this, the ACPI spec is sorely lacking any statement
as to the configuration of CNTCTLBase.{CNTSAR,CNTTIDR,CNTACR}, so it's
not clear if we can access anything in a frame, even if it is listed as
being a non-secure timer.

I think we need a stronger statement here. Otherwise, we will encounter
problems. Linux currently assumes that CNTCTLBase.CNTACR<N> is
writeable, given a non-secure frame N. This is only the case if
CNTCTLBase.CNTSAR.NS<N> == 1.

Thanks,
Mark.
