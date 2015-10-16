From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 16 Oct 2015 16:45:43 +0100
Subject: xen,arm: enable cpu_hotplug
In-Reply-To: <561EE3E5.2000105@citrix.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
 <561EE3E5.2000105@citrix.com>
Message-ID: <alpine.DEB.2.02.1510161632040.27957@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Oct 2015, Julien Grall wrote:
> On 14/10/2015 18:49, Stefano Stabellini wrote:
> > Hi all,
> 
> Hi Stefano,
> 
> > this small patch series enable cpu_hotplug in ARM and ARM64 guests,
> > using the PV path to plug and unplug the cpus and psci to enable/disable
> > them.
> 
> That's a cool things to have on ARM!
> 
> I've got few questions related to CPU hotplug on Xen side.
> 
> Firstly, when we create the device tree we are using max_vcpus to populate the
> "/cpus" node. AFAIU, Linux will always start all the vCPU because they are
> marked present. That means that it would not be possible to honor vcpus="N"
> where N is < max_vcpus. Did I miss something?

I think that's OK, it is the intended behaviour. See
cpu-hotplug.c:setup_cpu_watcher in Linux, in particular the
for_each_possible_cpu loop. The guest boots with all vcpus and turns off
the ones which are marked as not available on xenstore.


> My second point is related to how Xen is handling interrupt with vCPU. When
> PSCI off is called, we will set the _VFP_down flag. This flag is used in
> vgic_vcpu_inject_irq and when it's set the interrupt will be ignored and stay
> active on the HW GIC forever. If the vCPU is coming back online, this
> interrupt will never be received. AFAIU the spec, the interrupt is expected to
> stay pending on the distributor side and will be receive when the vCPU will
> come back or migrate to another vCPU. A similar problem can happen when the
> vCPU is powered on again because we clear all the interrupt state related to
> vCPU (see vgic_clear_pending_irqs).
>
> That brings me a third one related to migration (and not to this series
> specifically). If the interrupt is edge type, it means that same interrupt can
> come while it's still active in the LR register. If the guest has to migrate
> the IRQ it won't happen because the interrupt is already active and in the LR,
> so we will set the pending bit on the current vCPU.

These might be valid concerns but they don't have much to do with
hotplug: PSCI can be used to turn on/off vcpus from within the guest
independently from cpu-hotplug. The only thing cpu-hotplug does is
marking as present/non-present some cpus in the guest, which can be
taken online/offline independently using psci.
