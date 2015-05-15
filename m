From: slash.tmp@free.fr (Mason)
Date: Fri, 15 May 2015 12:11:18 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150515041632.GG6348@linux>
References: <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
 <555218C7.5050602@free.fr> <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <5554B5C1.2070402@free.fr> <20150515041632.GG6348@linux>
Message-ID: <5555C646.5030504@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/2015 06:16, Viresh Kumar wrote:

> On 14-05-15, 16:48, Mason wrote:
>
>> How do I run the TWD in one-shot mode?
> 
> I haven't refreshed my memory for the earlier reply, but I have tried
> to go through the code again.
> 
> The logic is this:
> - Oneshot mode is only useful if we are going to support NO_HZ mode.
>   i.e. we can disable the clkevt device during CPU idle ..
> - For that to work, or in other words for the CPU to wake up from the
>   idle state, we need a broadcast timer. Which will wake up the idle
>   cpu and its clkevt device.
> 
>   You don't have this 'broadcast' timer in your case and so we aren't
>   able to switch to oneshot mode.
> 
>   Even if you do that, you will be stuck in LOW resolution mode. And
>   so you probably leave this timer as is and use a out-of-CPU-domain
>   timer for this work, which can support high resolution mode.

For the record, my kernel config contains:
(There are some BROADCAST-related options enabled.)

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_KTIME_SCALAR=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_ARCH_HAS_TICK_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set


Full config (and platform patch) provided in <555380F8.5050306@free.fr>
http://article.gmane.org/gmane.linux.power-management.general/60164

Regards.
