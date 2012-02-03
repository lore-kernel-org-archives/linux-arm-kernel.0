From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 3 Feb 2012 14:32:14 +0100
Subject: [PATCH 1/1] arm: vfp: Raising SIGFPE on invalid floating point
 operation
In-Reply-To: <1328258184-23082-1-git-send-email-consul.kautuk@gmail.com>
References: <1328258184-23082-1-git-send-email-consul.kautuk@gmail.com>
Message-ID: <20267.57822.537801.969721@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kautuk Consul writes:
 > There is a lot of ARM/VFP hardware which does not invoke the
 > undefined instruction exception handler (i.e. __und_usr) at all
 > even in case of an invalid floating point operation in usermode.
 > For example, 100.0 divided by 0.0 will not lead to the undefined
 > instruction exception being called by the processor although the
 > hardware does reliably set the DZC bit in the FPSCR.

There is hardware that pretends to support FP exceptions but
fails to actually do so?  That's awful.  What manufacturers
and CPU models are affected?

 > Currently, the usermode code will simply proceed to execute without
 > the SIGFPE signal being raised on that process thus limiting the
 > developer's knowledge of what really went wrong in his code logic.
 > 
 > This patch enables the kernel to raise the SIGFPE signal when the
 > faulting thread next calls schedule() in any of the following ways:
 > - When the thread is interrupted by IRQ
 > - When the thread calls a system call
 > - When the thread encounters exception
 > 
 > Although the SIGFPE is not delivered at the exact faulting instruction,
 > this patch at least allows the system to handle FPU exception scenarios
 > in a more generic "Linux/Unix" manner.

No, a SIGFPE delivered at the wrong point in time with the wrong
context in its sigframe is MUCH worse than not getting a SIGFPE
at all.  (And likewise for all other trap signals, SEGV, ILL, etc.)

I do agree that the application developer must be informed about
the breakage, but a fake SIGFPE is not appropriate.  Options:

1. a rate-limited printk KERN_WARN that application X tried to
receive FP exceptions but hardware Y failed to do so

2. a tunable knob somehwere that optionally kills the application
in the above case

/Mikael
