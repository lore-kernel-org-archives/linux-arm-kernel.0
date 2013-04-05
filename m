From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 5 Apr 2013 18:16:45 +0100
Subject: [PATCH v6 4/4] xen/arm: introduce xen_early_init, use PSCI on xen
In-Reply-To: <alpine.LFD.2.03.1304051217560.1171@syhkavp.arg>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1304051217560.1171@syhkavp.arg>
Message-ID: <alpine.DEB.2.02.1304051725580.21065@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Nicolas Pitre wrote:
> On Fri, 5 Apr 2013, Stefano Stabellini wrote:
> 
> > Split xen_guest_init in two functions, one of them (xen_early_init) is
> > going to be called very early from setup_arch.
> > 
> > Change machine_desc->smp_init to xen_smp_init if Xen is present on the
> > platform. xen_smp_init just sets smp_ops to psci_smp_ops.
> 
> I still think the above is redundant, especially since psci_smp_ops has 
> priority over default mdesc->smp_ops.  And doing so does break MCPM. But 
> we're apparently going in circle over this issue.

Did you read my last email on this issue?

http://marc.info/?l=linux-arm-kernel&m=136500098703317&w=2


Let's examine the use cases here, assuming that your MCPM patch series
has been applied.


This is what happens:

- No Xen
Xen is not running on the platform and a Xen hypervisor node is not
available on device tree.
Everything keeps working seamlessly, this patch doesn't change anything.

- we are running on Xen
Xen is running on the platform, we are running as a guest on Xen and an
hypervisor node is available on device tree.
Let's also assume that there aren't any "arm,cci" compatible nodes on
device tree because Xen wouldn't export this kind of information to any
guests right now. Therefore PSCI should be used to boot secondary cpus.
Because the versatile express machine sets smp_init to
vexpress_smp_init_ops, vexpress_smp_init_ops will be called.
vexpress_smp_init_ops sets smp_ops to vexpress_smp_ops, that *break*
Xen.

With this patch, xen_smp_init will be called instead of
vexpress_smp_init_ops, and smp_ops will be set to psci_smp_ops,
therefore *unbreaking* Xen.

In fact what makes this patch really necessary is smp_init together with
the MCPM series.


Do you agree with me?
