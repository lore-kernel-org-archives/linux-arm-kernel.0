From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 May 2015 12:54:52 +0100
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <5559CC01.9040306@free.fr>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk>
 <5555CC1A.5040604@free.fr>
 <20150515115852.GJ2067@n2100.arm.linux.org.uk>
 <5555EA68.7030006@free.fr>
 <20150515131521.GK2067@n2100.arm.linux.org.uk>
 <5555FB7F.901@free.fr> <55563C63.8090504@free.fr>
 <5559CC01.9040306@free.fr>
Message-ID: <20150518115452.GV2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 01:24:49PM +0200, Mason wrote:
> On your platform, where TWD works in one-shot mode with hrtimers
> enabled, I assume you registered a tick broadcast device?

It is iMX6, and yes, there is a broadcast device, which appears to be
disabled:

Tick Device: mode:     1
Broadcast device
Clock Event Device: mxc_timer1
 max_delta_ns:   1431655752223
 min_delta_ns:   85000
 mult:           6442451
 shift:          31
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: v2_set_next_event
 set_mode:       mxc_set_mode
 event_handler:  tick_handle_oneshot_broadcast
 retries:        0

tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000

> I didn't register a tick broadcast device, and this may be the root
> of my problems.

Possibly, I wouldn't know without reading the code.

> Questions for the ARM devs:
> 
> Is there an architected / standard tick broadcast device on ARM,
> equivalent to x86's HPET?
> 
> Russell's 2010 patch (5388a6b266) states
> 
>   The TWD local timers are unable to wake up the CPU when it is placed
>   into a low power mode, eg. C3.  Therefore, we need to adapt things
>   such that the TWD code can cope with this.
> 
> What exactly is meant by "low power modes".
> Does the idle loop calling WFI send the system into low power mode?

That depends on your hardware!  Some SoCs program the low power mode
via a register, and then you need to issue a WFI to enter that power
mode.

Low power modes are not really part of the architecture.  The
architecture defines what low power modes are available at CPU level,
but does not completely define how those low power modes are to be
tnetered.  It's up to the SoC vendor to determine what low power modes
are available, and how they are entered, and how fine-grained they are.

For a SoC where WFI is not programmed to cause anything other than the
architecture specified dormant behaviour, WFI will not cause the TWD
to stop.

> Are there several low power modes?

There can be.  Up to the SoC vendor to define.

> How are these modes entered and exited?

Up to the SoC vendor to define.

> Is this documented in the ARM reference manual?

No.  This documents the power modes that are (possibly) provided by the
CPU architecture for use by the SoC.

> or in the Cortex A9 technical manual?

No.

To give an example, a SoC vendor _may_ decide that CPU states below
"dormant" are entered by writing to a SoC specific power mode register,
and then executing a WFI instruction.

Another SoC vendor may decode that a CPU can be completely powered down
by merely writing to a register, which causes the hardware to assert a
CPU core specific reset and then remove power from the CPU core.

It's entirely up to the SoC vendor.  Therefore, you need to read the SoC
specific documentation.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
