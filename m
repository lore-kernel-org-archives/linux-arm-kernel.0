From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 26 Mar 2013 15:25:55 +0000
Subject: [PATCH v2 6/6] [RFC] arm: use PSCI if available
In-Reply-To: <20130326150444.GI20252@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
 <1364308875-26484-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130326150444.GI20252@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1303261509080.4430@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013, Will Deacon wrote:
> Hi Stefano,
> 
> On Tue, Mar 26, 2013 at 02:41:15PM +0000, Stefano Stabellini wrote:
> > Check for the presence of PSCI before setting smp_ops, use PSCI if it is
> > available.
> > 
> > This is useful because at least when running on Xen it's possible to have a
> > PSCI node for example on a Versatile Express or an Exynos5 machine. In these
> > cases the PSCI SMP calls should be the ones to be called.
> > 
> > Remove virt_smp_ops and platsmp.c from mach-virt because they aren't needed
> > anymore.
> 
> [...]
> 
> > +struct smp_operations __initdata psci_smp_ops = {
> > +	.smp_init_cpus		= psci_smp_init_cpus,
> > +	.smp_prepare_cpus	= psci_smp_prepare_cpus,
> > +	.smp_secondary_init	= psci_secondary_init,
> > +	.smp_boot_secondary	= psci_boot_secondary,
> > +};
> 
> Whilst I like the idea of this, I don't think things will pan out this
> nicely in practice. There will almost always be a level of indirection
> required between the internal Linux SMP operations and the expectations of
> the PSCI firmware, whether this is in CPU numbering or other,
> platform-specific fields in various parameters.
> 
> Tying these two things together like this confuses the layering in my
> opinion and will likely lead to potentially subtle breakages if platforms
> start trying to adopt this.

What you are saying is that psci could either be used directly, like we
are doing, or it could just be the base of some higher level platform
specific smp_ops.

Honestly I think that psci is already high level enough that I would
worry if somebody started to wrap it around something else.

However we still support that use case just fine:  they can just avoid
having a psci node on device tree and just keep using their machine
specific smp_ops. It's up to them really.
They can even base the implementation of their smp_ops on the current
psci code, in order to facilitate that I could get rid of psci_ops
(which initialization is based on device tree) and export the psci_cpu_*
functions instead, so that they can be called directly by other smp_ops.


> If this can indeed work for the virtual platforms (Xen and KVM), then I
> think it would be better expressed using `virt' smp_ops, which map directly
> to PSCI, rather than putting them here. Even then, it's tying KVM and Xen
> together on the firmware side of things...

Keep in mind that dom0 on Xen boots as a native machine (versatile
express or exynos5 for example) with a Xen hypervisor node on it.  We
would need to find a way to override the default machine smp_ops with
a set of xen_smp_ops early at boot.
I don't like this option very much, I think is fragile.
