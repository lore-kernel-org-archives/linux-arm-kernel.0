From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Apr 2013 15:36:06 -0400 (EDT)
Subject: [PATCH v6 4/4] xen/arm: introduce xen_early_init, use PSCI on xen
In-Reply-To: <alpine.DEB.2.02.1304051725580.21065@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-4-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1304051217560.1171@syhkavp.arg>
 <alpine.DEB.2.02.1304051725580.21065@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1304051324190.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Stefano Stabellini wrote:

> This is what happens:
> 
> - No Xen
> Xen is not running on the platform and a Xen hypervisor node is not
> available on device tree.
> Everything keeps working seamlessly, this patch doesn't change anything.
> 
> - we are running on Xen
> Xen is running on the platform, we are running as a guest on Xen and an
> hypervisor node is available on device tree.
> Let's also assume that there aren't any "arm,cci" compatible nodes on
> device tree because Xen wouldn't export this kind of information to any
> guests right now. Therefore PSCI should be used to boot secondary cpus.
> Because the versatile express machine sets smp_init to
> vexpress_smp_init_ops, vexpress_smp_init_ops will be called.
> vexpress_smp_init_ops sets smp_ops to vexpress_smp_ops, that *break*
> Xen.

OK I see.

> With this patch, xen_smp_init will be called instead of
> vexpress_smp_init_ops, and smp_ops will be set to psci_smp_ops,
> therefore *unbreaking* Xen.

However that breaks MCPM.

> In fact what makes this patch really necessary is smp_init together with
> the MCPM series.

Yes.

> Do you agree with me?

On the Xen issue, yes.


Nicolas
