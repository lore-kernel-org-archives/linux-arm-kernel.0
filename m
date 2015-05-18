From: slash.tmp@free.fr (Mason)
Date: Mon, 18 May 2015 13:24:49 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <55563C63.8090504@free.fr>
References: <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk> <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk> <5555CC1A.5040604@free.fr>
 <20150515115852.GJ2067@n2100.arm.linux.org.uk> <5555EA68.7030006@free.fr>
 <20150515131521.GK2067@n2100.arm.linux.org.uk> <5555FB7F.901@free.fr>
 <55563C63.8090504@free.fr>
Message-ID: <5559CC01.9040306@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/2015 20:35, Mason wrote:

> On 15/05/2015 15:58, Mason wrote:
> 
>> Thanks for providing evidence that it does work. I am
>> now hopeful to get it working. I'll start by applying
>> my patch to a more recent kernel.
> 
> Could you provide the full output of /proc/timer_list for
> the platform where TWD is running in one-shot mode?
> 
> Also what kernel version is that platform running?

Hello Russell,

On your platform, where TWD works in one-shot mode with hrtimers
enabled, I assume you registered a tick broadcast device?

(AFAIU, one is required since TWD is tagged CLOCK_EVT_FEAT_C3STOP.)
https://lwn.net/Articles/574962/

I didn't register a tick broadcast device, and this may be the root
of my problems.

Here's the relevant part of /proc/timer_list

Tick Device: mode:     0
Broadcast device
Clock Event Device: <NULL>
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000

What does your timer_list show?


Questions for the ARM devs:

Is there an architected / standard tick broadcast device on ARM,
equivalent to x86's HPET?

Russell's 2010 patch (5388a6b266) states

  The TWD local timers are unable to wake up the CPU when it is placed
  into a low power mode, eg. C3.  Therefore, we need to adapt things
  such that the TWD code can cope with this.

What exactly is meant by "low power modes".
Does the idle loop calling WFI send the system into low power mode?
Are there several low power modes?
How are these modes entered and exited?
Is this documented in the ARM reference manual?
or in the Cortex A9 technical manual?

The technical manual states

5.3.1  Individual Cortex-A9 processor power management
[...]
Each Cortex-A9 processor can be in one of the following modes:
Run mode     = Everything is clocked and powered-up
Standby mode = The CPU clock is stopped. Only logic required for wake-up is still active.
Dormant mode = Everything is powered off except RAM arrays that are in retention mode.
Shutdown     = Everything is powered-off.
[...]
Standby modes
WFI and WFE Standby modes disable most of the clocks in a processor, while keeping its logic
powered up. This reduces the power drawn to the static leakage current, leaving a tiny clock
power overhead requirement to enable the device to wake up.
[...]
Dormant mode
Dormant mode is designed to enable the Cortex-A9 processor to be powered down, while
leaving the caches powered up and maintaining their state.

Does the "low power mode" in Russell's commit message refer to Dormant mode?
Because it seems the TWD should still work in Standby mode, right?


Regards.
