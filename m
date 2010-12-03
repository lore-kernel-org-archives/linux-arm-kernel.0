From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 16:51:05 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
Message-ID: <20101203165105.GD30898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 04:28:27PM +0000, Dave Martin wrote:
> For on-SoC peripherals, this can be managed through the driver
> framework in the kernel, but for functional blocks of the CPU itself
> which are used by instruction set extensions, such as NEON or other
> media accelerators, it would be interesting if processes could adapt
> to these units appearing and disappearing at runtime.  This would mean
> that user processes would need to select dynamically between different
> implementations of accelerated functionality at runtime.

The ELF hwcaps are used by the linker to determine what facilities
are available, and therefore which dynamic libraries to link in.

For instance, if you have a selection of C libraries on your platform
built for different features - eg, lets say you have a VFP based
library and a soft-VFP based library.

If the linker sees - at application startup - that HWCAP_VFP is set,
it will select the VFP based library.  If HWCAP_VFP is not set, it
will select the soft-VFP based library instead.

A VFP-based library is likely to contain VFP instructions, sometimes
in the most unlikely of places - eg, printf/scanf is likely to invoke
VFP instructions even when they aren't dealing with floating point in
their format string.

The problem comes is if you take away HWCAP_VFP after an application
has been bound to the hard-VFP library, there is no way, sort of
killing and re-exec'ing the program, to change the libraries that it
is bound to.

> In order for this to work, some dynamic status information would need
> to be visible to each user process, and polled each time a function
> with a dynamically switchable choice of implementations gets called.
> You probably don't need to worry about race conditions either-- if the
> process accidentally tries to use a turned-off feature, you will take
> a fault which gives the kernel the chance to turn the feature back on.

Yes, you can use a fault to re-enable some features such as VFP.

> The dynamic feature status information should ideally be per-CPU
> global, though we could have a separate copy per thread, at the cost
> of more memory.

Threads are migrated across CPUs so you can't rely on saying CPU0 has
VFP powered up and CPU1 has VFP powered down, and then expect that
threads using VFP will remain on CPU0.  The system will spontaneously
move that thread to CPU1 if CPU1 is less loaded than CPU0.

I think what may be possible is to hook VFP power state into the code
which enables/disables access to VFP.

However, I'm not aware of any platforms or CPUs where (eg) VFP is
powered or clocked independently to the main CPU.
