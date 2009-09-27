From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Sep 2009 20:09:53 +0100
Subject: Solving section mismatches
In-Reply-To: <20090927184645.GA10454@merkur.ravnborg.org>
References: <20090927164115.GB20093@n2100.arm.linux.org.uk>
	<20090927182707.GA10405@merkur.ravnborg.org>
	<20090927183904.GD20093@n2100.arm.linux.org.uk>
	<20090927184645.GA10454@merkur.ravnborg.org>
Message-ID: <20090927190953.GE20093@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 08:46:45PM +0200, Sam Ravnborg wrote:
> Please look at the above and realise that cpu_die() is only ever defined
> in case that HOTPLUG_CPU is defined. So there is nothing to discard if
> HOTPLUG_CPU equals to n.
> 
> And just to repeat myself....
> The only correct use of __cpu* annotation is for function/data that is
> used with or without HOTPLUG_CPU equals to y.
> Which is NOT the case for cpu_die().
> 
> The __cpu* annotation is not a replacement for ifdeffed out code that is
> not relevant for the non-HOTPLUG_CPU case.

Ok.  But that still doesn't solve:

WARNING: arch/arm/kernel/built-in.o(.text+0x6274): Section mismatch in reference from the function cpu_die() to the function .cpuinit.text:secondary_start_kernel()
The function cpu_die() references
the function __cpuinit secondary_start_kernel().
This is often because cpu_die lacks a __cpuinit 
annotation or the annotation of secondary_start_kernel is wrong.

So are you saying secondary_start_kernel should not have __cpuinit?

That seems wrong, since we do want it to be discarded as __init in the
non-hotplug case, but we do want it kept around in the hotplug cpu
case.  I guess something like the following could be used instead:

#ifdef CONFIG_HOTPLUG_CPU
asmlinkage void secondary_start_kernel(void)
#else
asmlinkage void __init secondary_start_kernel(void)
#endif
{
...
}

but my understanding was that's what __cpuinit was supposed to be
doing for us in the first place.
