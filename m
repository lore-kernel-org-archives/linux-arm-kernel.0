From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Aug 2013 18:15:01 +0100
Subject: [PATCH 0/3] Interrupt priority patch set
In-Reply-To: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <20130826171501.GD6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 05:36:22PM +0200, Tomasz Nowicki wrote:
> ACPI spec is x86 oriented thus it use NMI for error reporting as low latency
> error signalling way. Fast response to error occurrence is what ARM trying to
> satisfy using interrupt prioritization since there is no NMI direct equivalent
> for ARM architecture. 
> 
> Patch set are divided into three step:
> 1. Create generic code responsible for setting interrupt priority.
> 2. Use it in interrupt setup.
> 3. Example of interrupt controller priority mapping for GIC platform dependent
>    code.
> 
> Patch set tries to meet requirements like:
> - not breaking existing code
> - easy to expand to new priority levels
> - easy to map generic priority levels to platform dependent priority values

Using the GIC interrupt priority mapping is rather sub-optimal for this -
on the face of it, it sounds like a sensible solution, and would be with
an OS which didn't insist on running all interrupt handlers with IRQs
disabled.

Unfortunately, Linux decided that this would be the case for various
reasons - not only the issue of kernel stack overflow, but also because
of lockdep requirements.  What this means is that the best you can do is
to control which interrupt of many pending at the same time gets serviced
first.

So... the general principle here is that IRQ priority levels are pretty
useless in Linux.

In other words, the error reporting won't work while any interrupt
handler is running irrespective of how you program the GIC or indeed
any interrupt disabled region.

The closest we have to NMI is the FIQ, but having the FIQ call kernel
C code and take locks is very problematic: you end up needing the
locks and such like to disable FIQs in addition to IRQs, which reduces
FIQs down to the same level as IRQs.  The other stumbling block here
is that the FIQ may only be available to the secure world, and not the
non-secure world.
