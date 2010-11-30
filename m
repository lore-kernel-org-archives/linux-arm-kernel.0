From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 30 Nov 2010 16:17:32 +0530
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu
	hotplug
In-Reply-To: <20101129192407.GA20761@n2100.arm.linux.org.uk>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
	<20101129104149.GA10703@n2100.arm.linux.org.uk>
	<AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>
	<20101129192407.GA20761@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimZfnmVMDZ2faUPpDHHv3oAhM9ZcVEpM0_MyHbq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 12:54 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Mon, Nov 29, 2010 at 06:27:02PM +0100, Vincent Guittot wrote:
> > The goal of this patch is to remove as much duplicated code as
> > possible in each platform hotplug file. I have also tried to keep in
> > mind that current platform upstreamed code make nearly no power
> > management in their current implementation. I have added a new
> > interface and a new file in order to
> > ?-Keep the current interface as it is. So each platform could move to
> > common code when they want
> > ?-Have a dedicated file for arm hotplug function in which we can add
> > all code that must be executed on an arm core whatever the platform
> > (flushing cache, SCU disabling and handling spurious wake up as a
> > staring ?point). I agree that the current code is quite small for now
> > and we can wonder if a dedicated file is useful, code might be put in
> > kernel/smp.c file.
> > The next step is also to add some hotplug tracepoints and I would
> > prefer to add the tracepoints only in a platform independent code.
> >
> > With the common code, a new arm platform can have the hotplug feature
> > with less than 20 lines (power management not included) and can be
> > sure that minimal actions will be handled by the common Arm code.
> >
> > We can also keep the platform_cpu_die has the platform entry point and
> > move the common part into kernel/smp.c file. We still have few
> > duplicated code (spurious wake-up) but this seems to be acceptable.
> >
> > I have taken your example into account and have updated the patch accordingly
>
> No you haven't because you don't understand the point of keeping the
> existing interfaces. ?I'm not going to cripple the flexibility of the
> current interface just in the name of merging them all together.
>

To bring into context your reply to an earlier submission of a similar
patch [1], you stated

"So what if a platform wants to completely power down a CPU?

You'd want to implement it such that platform_cpu_die() does all
the shutdown of the CPU except for power-off, and platform_cpu_kill()
waits for that to complete before turning power off.

With platform_cpu_kill() and platform_cpu_die() moved into generic
code, you can no longer do this."

Since the main aim here is to consolidate as much code here as
possible while still allowing platforms to override the defaults,
would you have an objection to the introduction of a struct smp_ops
that'll allow a platform to override the defaults? This seems to be
done on other platforms I've briefly looked at.

$ git grep "\.cpu_die"
arch/mips/cavium-octeon/smp.c:  .cpu_die                = octeon_cpu_die,
arch/mips/kernel/smp-up.c:      .cpu_die                = up_cpu_die,
arch/powerpc/kernel/smp.c:      if (ppc_md.cpu_die)
arch/powerpc/kernel/smp.c:              ppc_md.cpu_die();
arch/powerpc/kernel/sysfs.c:            if (ppc_md.cpu_die)
arch/powerpc/platforms/powermac/setup.c:        .cpu_die
 = pmac64_cpu_die,
arch/powerpc/platforms/powermac/setup.c:        .cpu_die
 = pmac32_cpu_die,
arch/powerpc/platforms/powermac/setup.c:        .cpu_die
 = generic_mach_cpu_die,
arch/powerpc/platforms/powermac/smp.c:  .cpu_die        = smp_core99_cpu_die,
arch/powerpc/platforms/powermac/smp.c:  .cpu_die        = generic_cpu_die,
arch/powerpc/platforms/pseries/hotplug-cpu.c:   ppc_md.cpu_die =
pseries_mach_cpu_die;
arch/sh/kernel/cpu/sh4a/smp-shx3.c:     .cpu_die                =
native_cpu_die,
arch/x86/include/asm/smp.h:     smp_ops.cpu_die(cpu);
arch/x86/kernel/smp.c:  .cpu_die                = native_cpu_die,
arch/x86/xen/smp.c:     .cpu_die = xen_cpu_die,



[1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/89542
