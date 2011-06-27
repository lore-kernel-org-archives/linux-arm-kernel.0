From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2011 11:38:32 +0100
Subject: how to suspend on arm smp platform
In-Reply-To: <BANLkTimYxi2rUwp+pkRxNWAXKhob7AJHmQ@mail.gmail.com>
References: <BANLkTimYxi2rUwp+pkRxNWAXKhob7AJHmQ@mail.gmail.com>
Message-ID: <20110627103832.GB16103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 06:14:13PM +0800, JiSheng Zhang wrote:
> I need your help about suspend on SMP.
> 
> I notice that there's some smp support code in
> arch/arm/kernel/sleep.S. cpu hotplug code is similar as realview
> platform--just put the non-boot cpu into WFI state. So how do non-boot
> cpu resume back to the hotplug code path? If resume doesn't make use
> of the hotplug, then how to resume non-boot cpus? Currently, UP kernel
> suspend works perfectly on my SoC, I need your help about SMP suspend.

You're mixing two different things together.

System suspend to RAM support works by hot-unplugging the secondary
CPUs, thereby placing the system in a UP environment.  Suspend then
happens as per UP systems, which should be using or moving over to use
arch/arm/kernel/sleep.S.

arch/arm/kernel/sleep.S supports two things: uniprocessor suspend, and
cpuidle based suspend of multiple CPUs.  It does *not* handle hotplug.

Now, to move on to hotplug.  Those platforms which support hotplug don't
support hotplug very well - many of them have taken a copy of the Realview
or Versatile Express hotplug code as their implementation.  These platforms
support _no_ power management, and so their hotplug code is implemented
in such a way to emulate what's required to be able to test the hotplug
paths.  (Their original implementation was to spin in a loop external to
the main idle loop waiting to be brought back up, at which point they
returned to the idle loop.)

In effect, a hot unplug of a CPU should cause the CPU to be placed into
a low power mode.  Hot-plugging the CPU should cause the CPU to be reset
and enter the kernel in exactly the same way as it would do during normal
system boot.

Note that the system expects (or should expect) complete loss of state on
an unplugged CPU, which is another reason why the cpu_suspend paths in
arch/arm/kernel/sleep.S are not appropriate for CPU hotplug.
