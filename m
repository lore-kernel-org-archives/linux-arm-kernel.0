From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Mar 2013 10:37:27 -0700
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <20130226181114.GU17833@n2100.arm.linux.org.uk>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
 <20130226181114.GU17833@n2100.arm.linux.org.uk>
Message-ID: <5130E757.6090500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 11:11 AM, Russell King - ARM Linux wrote:
...
> The whole errata business is a total nightmare - and it gets much worse
> with the advent of multi-SoC kernels.  We don't have an answer to this
> other than disabling these troublesome errata and requiring the code
> which comes before the kernel to do whatever is necessary.

So for the initial boot, I can see that the bootloader can apply any
WARs that are required, irrespective of whether the code that comes
before the kernel is a secure monitor, a regular bootloader and/or
whether the kernel ends up running in secure or normal world.

I have one question on this case though: For erratum 751472 (An
interrupted ICIALLUIS operation may prevent the completion of a
following broadcasted operation), one of our engineers asserts:

This is valid only for SMP configurations and since bootloader has only
one CPU (CPU0) up and running, this is not valid for Bootloader.

Is that assertion correct? I assume that the WAR can be enabled
irrespective of whether SMP is actively in use, and shouldn't negatively
affect single-CPU operation in the bootloader. Hence, the bootloader or
secure monitor should always apply this WAR.

Now on to other scenarios: What about booting secondary CPUs, in cases
such as: initial kernel boot, CPU hotplug, CPU power saving.

Since some of the bits that enable WARs are banked per CPU, the WAR
needs to be enabled by code running on each individual CPU, each time
it's powered on. When a secure monitor exists, the CPU will boot through
it (at least on Tegra, there is a single register that defines the boot
vector for all CPUs; I don't know if that fact is ARM-architectural or
not), so the secure monitor can apply the WAR if needed. However, when
there is no secure monitor and the kernel runs in secure world, the
kernel would have to apply those WARs, since the only code that runs is
in the kernel.

But that leads to the question: How does the secondary CPU boot vector
code in the kernel know whether it can/should apply the WARs? It only
can if the kernel is running in secure mode, and that isn't always the
case, and there's no easy way to detect this at run-time. (It usually is
with any upstream SW, but we presumably want to support running the
upstream kernel on boards that were repurposed and have a secure monitor).

Apparently, the solution we have downstream is a Kconfig option that
selects whether the kernel should support running in secure world or
normal world, and hence whether to apply the WARs or not. Obviously that
won't work well with a multi-platform kernel.

The solutions that come to mind are:

1)

Assume that Tegra kernels always run in secure world, and so the WARs
can be applied in the Tegra-specific secondary CPU boot code. The
bootloader would still have to apply WARs for the initial CPU0 boot,
since the kernel code for that is common, so we can't assume we're
running in secure mode there. I guess that upstream we have no support
for running under a secure monitor on Tegra yet though, so perhaps this
isn't so bad (e.g. we don't make an SMC call to set the CPU boot vector,
but rather just write to the register directly). Still, making this
assumption would only be a temporary solution until we actually do
support running under a secure monitor upstream.

2)

Assume that we're always running in normal world, and mandate that a
secure monitor must exist, and push the WARs into it. That would require
implementing a simple secure monitor and using it for the cases where
one otherwise wouldn't exist.

Neither seems entirely ideal.

Perhaps one more option: I wonder if we can play games like reading the
CPU boot vector register; if it's equal to the kernel's value then we
must have been running in secure mode since we wrote it, but otherwise
we must have booted through a secure monitor?
