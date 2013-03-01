From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Mar 2013 18:05:10 +0000
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <5130E757.6090500@wwwdotorg.org>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
 <20130226181114.GU17833@n2100.arm.linux.org.uk>
 <5130E757.6090500@wwwdotorg.org>
Message-ID: <20130301180510.GG17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 10:37:27AM -0700, Stephen Warren wrote:
> I have one question on this case though: For erratum 751472 (An
> interrupted ICIALLUIS operation may prevent the completion of a
> following broadcasted operation), one of our engineers asserts:
> 
> This is valid only for SMP configurations and since bootloader has only
> one CPU (CPU0) up and running, this is not valid for Bootloader.
> 
> Is that assertion correct? I assume that the WAR can be enabled
> irrespective of whether SMP is actively in use, and shouldn't negatively
> affect single-CPU operation in the bootloader. Hence, the bootloader or
> secure monitor should always apply this WAR.

I'd say no, for three reasons:

1. It requires no run-time workaround - by that I mean, it doesn't require
   software modification of the ICIALLUIS operation.

2. It only requires a bit set in a secure-only-accessible diagnostic
   register before the MMU is brought online.

3. This is the cruncher for this erratum - when we bring up a SMP system,
   we need this erratum applied before the caches and MMU are enabled.
   Why?  Because when we enable the caches and MMU, we have to then be
   able to reliably issue the ICIALLUIS operation.

   We know that we can't run platform specific code before these are
   brought up, so we can't go running SMC instructions this early on
   from the kernel code.

   As previously pointed out, having the work-around enabled in the
   kernel may not be appropriate for other platforms because even though
   they have a pre-r3p0 CPU, they may have fixed the problem in their
   silicon.

Therefore, for all of the above reasons, we _can't_ have this in a kernel
designed to run on multiple different platforms.

> Now on to other scenarios: What about booting secondary CPUs, in cases
> such as: initial kernel boot, CPU hotplug, CPU power saving.
> 
> Since some of the bits that enable WARs are banked per CPU, the WAR
> needs to be enabled by code running on each individual CPU, each time
> it's powered on. When a secure monitor exists, the CPU will boot through
> it (at least on Tegra, there is a single register that defines the boot
> vector for all CPUs; I don't know if that fact is ARM-architectural or
> not), so the secure monitor can apply the WAR if needed. However, when
> there is no secure monitor and the kernel runs in secure world, the
> kernel would have to apply those WARs, since the only code that runs is
> in the kernel.
> 
> But that leads to the question: How does the secondary CPU boot vector
> code in the kernel know whether it can/should apply the WARs? It only
> can if the kernel is running in secure mode, and that isn't always the
> case, and there's no easy way to detect this at run-time. (It usually is
> with any upstream SW, but we presumably want to support running the
> upstream kernel on boards that were repurposed and have a secure monitor).
> 
> Apparently, the solution we have downstream is a Kconfig option that
> selects whether the kernel should support running in secure world or
> normal world, and hence whether to apply the WARs or not. Obviously that
> won't work well with a multi-platform kernel.

I think what you're digging up here is one of the biggest obstacles we
still have, created through a "freedom of design" and the desire by
distros to have a single kernel image booting on multiple platforms.

> The solutions that come to mind are:
> 
> 1)
> 
> Assume that Tegra kernels always run in secure world, and so the WARs
> can be applied in the Tegra-specific secondary CPU boot code. The
> bootloader would still have to apply WARs for the initial CPU0 boot,
> since the kernel code for that is common, so we can't assume we're
> running in secure mode there. I guess that upstream we have no support
> for running under a secure monitor on Tegra yet though, so perhaps this
> isn't so bad (e.g. we don't make an SMC call to set the CPU boot vector,
> but rather just write to the register directly). Still, making this
> assumption would only be a temporary solution until we actually do
> support running under a secure monitor upstream.

This has the advantage that you (in theory) know which work-arounds are
appropriate for the revisions of CPU cores that you have on your platform.
So, although this would mean duplicating the erratum throughout the
platform code (which is distasteful) it would nevertheless work.

> 2)
> 
> Assume that we're always running in normal world, and mandate that a
> secure monitor must exist, and push the WARs into it. That would require
> implementing a simple secure monitor and using it for the cases where
> one otherwise wouldn't exist.

I think that's a very complex solution, and more fragile than just
duplicating the errata.

> Perhaps one more option: I wonder if we can play games like reading the
> CPU boot vector register; if it's equal to the kernel's value then we
> must have been running in secure mode since we wrote it, but otherwise
> we must have booted through a secure monitor?

That sounds platform specific again... I know that OMAP has to talk to
the secure world to tell it how to boot the secondary CPUs, so this
solution is specific to Tegra.
