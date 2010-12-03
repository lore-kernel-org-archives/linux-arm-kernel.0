From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 3 Dec 2010 17:35:45 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <20101203165105.GD30898@n2100.arm.linux.org.uk>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<20101203165105.GD30898@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 3, 2010 at 4:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 03, 2010 at 04:28:27PM +0000, Dave Martin wrote:
>> For on-SoC peripherals, this can be managed through the driver
>> framework in the kernel, but for functional blocks of the CPU itself
>> which are used by instruction set extensions, such as NEON or other
>> media accelerators, it would be interesting if processes could adapt
>> to these units appearing and disappearing at runtime. ?This would mean
>> that user processes would need to select dynamically between different
>> implementations of accelerated functionality at runtime.
>
> The ELF hwcaps are used by the linker to determine what facilities
> are available, and therefore which dynamic libraries to link in.
>
> For instance, if you have a selection of C libraries on your platform
> built for different features - eg, lets say you have a VFP based
> library and a soft-VFP based library.
>
> If the linker sees - at application startup - that HWCAP_VFP is set,
> it will select the VFP based library. ?If HWCAP_VFP is not set, it
> will select the soft-VFP based library instead.
>
> A VFP-based library is likely to contain VFP instructions, sometimes
> in the most unlikely of places - eg, printf/scanf is likely to invoke
> VFP instructions even when they aren't dealing with floating point in
> their format string.

True... this is most likely to be useful for specialised functional
units which are used in specific places (such as NEON), and which
aren't distributed throughout the code.  As you say, in
general-purpose code built with -mfpu=vfp*, VFP is distributed all
over the place, so you'd probably see a net cost as you thrash turning
VFP on and off.  The point may be moot-- I'm not aware of a SoC which
can power-manage VFP; but NEON might be different.

What you describe is one of two mechanisms currently in use--- the
other is for a single library to contain two implementations of
certain functions and to choose between them based on the hwcaps.
Typically, one set of functions is chosen a library initialisation
time.  Some libraries, such as libpixman, are implementated this way;
and it's often preferable since the the proportion of functions in a
library which get significant benefit from special instruction set
extensions is often pretty small.  So you avoid having duplicate
copies of libraries in the filesystem.  (Of course, if the distro's
packager was intelligent enough, it could avoid installing the
duplicate, but that's a separate issue.)

Unfortunately, glibc does a good job of hiding not only the hwcaps
passed on the initial stack but also the derived information which
drives shared library selection (or at least frustrates reliable
access to this information); so generally code which wants to check
the hwcaps must read /proc/self/auxv (or parse /proc/cpuinfo ... but
that's more laborious).  However, the cost isn't too problematic if
this only happens once, when a library is initialised.

In the near future, STT_IFUNC support in the tools and ld.so may add
to the mix, by allowing the dynamic linker to select different
implementations of code at the function level, not just the
whole-library level.  If so, this will provide a better way to
implement the optimised function selection challenge outlined above.

>
> The problem comes is if you take away HWCAP_VFP after an application
> has been bound to the hard-VFP library, there is no way, sort of
> killing and re-exec'ing the program, to change the libraries that it
> is bound to.

Agreed--- the application has to be aware in order for this to become
really useful.

However, to be clear, I'm not suggesting that the kernel should _ever_
break the contract embodied in /proc/cpuinfo, or the hwcaps passed at
process startup.  If the hwcaps say NEON is supported then it must be
supported (though this is allowed to involve a fault and a possible
SoC-specific delay while the functional unit is brought back online).

Rather, the dynamic status would indicate whether or not the
functional unit is in a "ready" state or not.

>
>> In order for this to work, some dynamic status information would need
>> to be visible to each user process, and polled each time a function
>> with a dynamically switchable choice of implementations gets called.
>> You probably don't need to worry about race conditions either-- if the
>> process accidentally tries to use a turned-off feature, you will take
>> a fault which gives the kernel the chance to turn the feature back on.
>
> Yes, you can use a fault to re-enable some features such as VFP.
>
>> The dynamic feature status information should ideally be per-CPU
>> global, though we could have a separate copy per thread, at the cost
>> of more memory.
>
> Threads are migrated across CPUs so you can't rely on saying CPU0 has
> VFP powered up and CPU1 has VFP powered down, and then expect that
> threads using VFP will remain on CPU0. ?The system will spontaneously
> move that thread to CPU1 if CPU1 is less loaded than CPU0.

My theory was that this wouldn't matter -- the dynamic status contains
hints that this or that functional unit is likely to be in a "ready"
state.  It's stastically unlikely that the thread will be suspended or
migrated during a single execution of a particular function in most
cases; though of course it may happen sometimes.

If a thread tries to execute an instruction and and finds that
functional unit turned off, the kernel then makes a desicision about
whether to sleep the process for a bit, turn the feature on locally,
or migrate the thread.

> I think what may be possible is to hook VFP power state into the code
> which enables/disables access to VFP.

Indeed; I believe in some implementations that the SoC is clever
enough to save some power automatically when these features are
disabled (provided that the saving is non-destructive).

>
> However, I'm not aware of any platforms or CPUs where (eg) VFP is
> powered or clocked independently to the main CPU.
>

As I said above, the main use case I'm aware of would be NEON; it's
possible other vendors' extensions such as iwmmxt can also be managed
in similar, but this is outside my field of knowledge.

Cheers
---Dave
