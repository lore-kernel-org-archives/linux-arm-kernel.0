From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Dec 2010 16:28:27 -0000
Subject: Forced HW_BREAKPOINT
In-Reply-To: <4CF67525.2010304@ti.com>
References: <4CF58F22.6070803@ti.com>
	<004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
	<4CF67525.2010304@ti.com>
Message-ID: <004d01cb9174$c8d83ec0$5a88bc40$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> I am running an ARM1176JZ-S based SoC, on which HW breakpoints do not
> >> seem to function for some reason.
> >
> > What are the symptoms that you are seeing? The 1176 has debug architecture
> > v6.1 so it should be supported by the code.
> >
> 
> Yes, this CPU has a trustzone capable v6.1 debug (DIDR reads
> 0x15121004).  The problem I am facing is that DSCR bit 15 (monitor
> debug-mode enable bit) cannot be set, it always reads back 0x2.  As a
> result the hw_breakpoint code spews a WARN_ON() at boot.

That's unfortunate. Is there a hardware debugger connected, or does
the core disallow monitor debug full-stop?

> I understand hw_breakpoint's dependency on perf, as well as oprofile's
> dependency on perf.  However, if perf does not depend on hw_breakpoint
> (on v6/v7), isn't the select above incorrect?

I was hoping not to give people the option to turn this off in Kconfig
because it will inevitably lead to GDB bug reports complaining that
hardware breakpoints don't work because the option has been misconfigured
in a distro kernel. How about I fix the initcall so that it always succeeds
and prints a helpful message instead of WARNing?

Russell, do you have any thoughts on this (Kconfig vs runtime detection)?

Will
