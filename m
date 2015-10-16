From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 16 Oct 2015 16:41:26 +0100
Subject: [Xen-devel] xen,arm: enable cpu_hotplug
In-Reply-To: <1444898398.1607.18.camel@citrix.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
 <561EE3E5.2000105@citrix.com> <1444898398.1607.18.camel@citrix.com>
Message-ID: <alpine.DEB.2.02.1510161635520.27957@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Oct 2015, Ian Campbell wrote:
> On Thu, 2015-10-15 at 00:23 +0100, Julien Grall wrote:
> > My second point is related to how Xen is handling interrupt with vCPU. 
> > When PSCI off is called, we will set the _VFP_down flag. This flag is 
> > used in vgic_vcpu_inject_irq and when it's set the interrupt will be 
> > ignored and stay active on the HW GIC forever. If the vCPU is coming 
> > back online, this interrupt will never be received. AFAIU the spec, the 
> > interrupt is expected to stay pending on the distributor side and will 
> > be receive when the vCPU will come back or migrate to another vCPU. A 
> > similar problem can happen when the vCPU is powered on again because we 
> > clear all the interrupt state related to vCPU (see
> > vgic_clear_pending_irqs).
> 
> Is there also an interaction with our implementation of ITARGETSR of
> picking the lowest set bit? e.g. if an IRQ has target 0x6 (targeting CPU 1
> and CPU2) we will choose CPU 1. If CPU 1 is then unplugged, will we end up
> targeting CPU 2 or the now-offline CPU 1? In the latter case the lack of
> interrupts might be considered surprising?
> 
> Or maybe the way CPU hotplug is arranged we never end up with holes in the
> online cpu space, i.e it is not possible to take down CPU1 and leave CPU2
> up?

Keep in mind that there is a distinction between a cpu being online (on
or off, this is triggered by psci operations) and being present (this is
what cpu-hotplug does). See /sys/devices/system/cpu/online,
/sys/devices/system/cpu/present and /sys/devices/system/cpu/possible.

It is possible to shut down cpu1 (psci->cpu_off, which pauses the vcpu)
but it is not possible to remove cpu1 without removing cpu2 first.

If the user configures the target to be cpu 2-4, then shuts down cpu2, it
won't receive any interrupts any more. This is not a cpu-hotplug bug.
Maybe is a do_psci_cpu_off bug, which should be improved to handle this
case.
