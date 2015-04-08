From: horms@verge.net.au (Simon Horman)
Date: Wed, 8 Apr 2015 10:06:11 +0900
Subject: [PATCH v4] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <20150407145635.GI12732@n2100.arm.linux.org.uk>
References: <1428351853-5844-1-git-send-email-sboyd@codeaurora.org>
 <20150407145635.GI12732@n2100.arm.linux.org.uk>
Message-ID: <20150408010610.GA29030@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 03:56:35PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 06, 2015 at 01:24:13PM -0700, Stephen Boyd wrote:
> > Writes to /sys/.../cpuX/online fail if we determine the platform
> > doesn't support hotplug for that CPU. Furthermore, if the cpu_die
> > op isn't specified the system hangs when we try to offline a CPU
> > and it comes right back online unexpectedly. Let's figure this
> > stuff out before we make the sysfs nodes so that the online file
> > doesn't even exist if it isn't (at least sometimes) possible to
> > hotplug the CPU.
> > 
> > Add a new 'cpu_can_disable' op and repoint all 'cpu_disable'
> > implementations at it because all implementers use the op to
> > indicate if a CPU can be hotplugged or not in a static fashion.
> > With PSCI we may need to add a 'cpu_disable' op so that the
> > secure OS can be migrated off the CPU we're trying to hotplug.
> > In this case, the 'cpu_can_disable' op will indicate that all
> > CPUs are hotpluggable by returning true, but the 'cpu_disable' op
> > will make a PSCI migration call and occasionally fail, denying
> > the hotplug of a CPU. This shouldn't be any worse than x86 where
> > we may indicate that all CPUs are hotpluggable but occasionally
> > we can't offline a CPU due to check_irq_vectors_for_cpu_disable()
> > failing to find a CPU to move vectors to.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: Dave Martin <Dave.Martin@arm.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: <linux-sh@vger.kernel.org>
> > Cc: Tyler Baker <tyler.baker@linaro.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I think this is fine, but I'd like to see some acks for it.  As it's
> mostly core ARM stuff, it should be merged through my tree unless there
> is a known conflict with arm-soc.  Thanks.

I'm happy with the shmobile portions and have verified that
they don't conflict with anything I have queued up for v4.1.

So in the context of that release, for the shmobile portion:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

I also tested, and the effected shmobile boards still seem to boot
with this patch applied.

Tested-by: Simon Horman <horms+renesas@verge.net.au>
