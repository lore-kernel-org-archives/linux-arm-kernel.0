From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 May 2017 13:43:51 +0100
Subject: separate softirq/irq stack on arm
In-Reply-To: <CAHmME9r2C64ZZg6kEzZgAPwm56_LoohKjUcvC_sMrpqBZSHVNw@mail.gmail.com>
References: <CAHmME9r2C64ZZg6kEzZgAPwm56_LoohKjUcvC_sMrpqBZSHVNw@mail.gmail.com>
Message-ID: <20170530124351.GP22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 02:20:36PM +0200, Jason A. Donenfeld wrote:
> I've been under the assumption that Linux on ARM had a separate stack
> for IRQ/SoftIRQ processing. However, in trying to look for how this is
> implemented, I've only found that ARM64 has a separate IRQ stack, but
> ARM32 does not. Is this correct, that ARM32 does not use a separate
> stack? In that case, is this something on the table to add at some
> point, just as MIPS did recently?

I'm aware of it, there was some discussion in January 2016 about this.

The problem here is that we have the thread info structure at the base
of the kernel stack, which contains the essential per-thread information.
We would need to copy this thread info structure from one stack to
another, as this is expected to be present and correct during all
exception handling.  To do this would be expensive, increasing interrupt
latency.

Moving the thread info is problematical as:

1. We can't put it in per-cpu data, because per-cpu data is accessed
   using the logical CPU number, which is stored in thread-info.

2. We don't have a per-CPU register that we can save a pointer to this
   structure.

The only way around this is to replace the thread info structure with a
pointer at the base of the stack (or maybe the top of the stack), which
would mean we're only copying one word, but that means that the thread
info structure becomes more expensive to access, meaning extra CPU
cycles all over the kernel - the thread info contains critical data
which is very regularly used (eg, every user accessor has to fetch the
thread_info addr_limit member.)

Nothing about this appeals.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
