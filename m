From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jun 2014 20:39:37 +0100
Subject: Some SMP related questions
In-Reply-To: <CALU2kfkrpoSSpRB-XGeKS5DOGRCKapRT_qhZW+u4MOsviOx3QQ@mail.gmail.com>
References: <CALU2kfkrpoSSpRB-XGeKS5DOGRCKapRT_qhZW+u4MOsviOx3QQ@mail.gmail.com>
Message-ID: <20140609193937.GV23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 11:44:29AM -0700, Mathew Li wrote:
> Just trying to understand SMP arm Linux. I have following questions:
> 
> 1. On any ARM board, all the devices raise SPIs. Is that correct?

Most devices raise SPIs, some raise per-CPU interrupts (such as CPU local
timers.)

> 2. On an SMP system, how does Linux configure SPIs? I mean the routing
> of the interrupts. For example, when a device raises an interrupt,
> does it get seen by all the cpus or is it seen only by the boot cpu,
> who handles the interrupt eventually if it is seen by all the cpus?
> Could you also please point me to the code?

By default, SPIs are routed to the boot CPU.  The kernel does not do any
load balancing of interrupts - it merely selects the first CPU in the
affinity mask for each IRQ.

I tried a long time ago to implement kernel-based IRQ load balancing and
found it to be /very/ sub-optimal to try and design some kind of algorithm
for the kernel - and any algorithm you put into the kernel will not be
satisfactory for everyone.  It's policy, and policy is best kept out of
the kernel.

Luckily, the work has already been done for us on x86, though irqbalanced
needs a few tweaks to make it work.

http://www.home.arm.linux.org.uk/~rmk/cubox/irqbalance/

contains code which allows the load balancing to work on iMX6.  Due to
our different driver implementations, irqbalance needs people to adjust
it so that it can correctly identify each interrupt and apply an
appropriate policy to each.

> 3. On an SMP system, how does Linux do scheduling? What is used for
> scheduling, I believe it is the timer interrupt. Right? Is timer
> device and its interrupt private to the cpu or is it also global? If
> global then which cpu gets to serve the timer interrupt?

In any high quality OS, the answer to that is "it's complicated".  If
local timers are available, then they will be used.  If not, then a
global tick may be broadcast (by whichever CPU the timer interrupt is
routed to), or an IPI may be sent from one CPU to another CPU.

> 4. In an SMP system, is it possible to run a process on a given cpu
> and never schedule it out until the process itself makes some blocking
> call, leading to a call into schedule() in kernel? Essentially I am
> saying to assign infinite time quantum to the process and only
> schedule it out when it does a blocking call.

What you're really asking has nothing to do with SMP at all.  You're
asking for a process which has exclusive access to the CPU until it
blocks for some reason.  That's an RT process, and Linux supports
those even on UP.  man sched_setscheduler

> 5. Is it possible to configure and build linux in an ASMP way? For
> example, so that whole kernel logic runs on boot cpu and remaining
> cpus would be used only and only for processes?

No, and doing that would be incredibly inefficient to forward every
syscall across, bouncing all the cache lines between CPUs.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
