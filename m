From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 3 Apr 2013 12:29:31 +0100
Subject: [PATCH v5 1/3] arm: introduce psci_smp_ops
In-Reply-To: <alpine.LFD.2.03.1304021336270.1171@syhkavp.arg>
References: <alpine.DEB.2.02.1304021700380.5078@kaball.uk.xensource.com>
 <1364919374-7836-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1304021336270.1171@syhkavp.arg>
Message-ID: <alpine.DEB.2.02.1304031218520.5078@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Apr 2013, Nicolas Pitre wrote:
> On Tue, 2 Apr 2013, Stefano Stabellini wrote:
> 
> > Rename virt_smp_ops to psci_smp_ops and move them to arch/arm/kernel/psci_smp.c.
> > Remove mach-virt/platsmp.c, now unused.
> > Compile psci_smp if CONFIG_ARM_PSCI and CONFIG_SMP.
> > 
> > Add a cpu_die smp_op based on psci_ops.cpu_off.
> > 
> > Initialize PSCI before setting smp_ops in setup_arch.
> > Use psci_smp_ops if the platform doesn't provide its own smp_ops.
> 
> [...]
> 
> > @@ -766,9 +767,13 @@ void __init setup_arch(char **cmdline_p)
> >  	unflatten_device_tree();
> >  
> >  	arm_dt_init_cpu_maps();
> > +	psci_init();
> >  #ifdef CONFIG_SMP
> >  	if (is_smp()) {
> > -		smp_set_ops(mdesc->smp);
> > +		if (mdesc->smp)
> > +			smp_set_ops(mdesc->smp);
> > +		else if (psci_smp_available())
> > +			smp_set_ops(&psci_smp_ops);
> 
> Didn't we agree to do this the other way around, i.e. 
> 
> 	if (psci_smp_available())
> 		smp_set_ops(&psci_smp_ops);
> 	else if (mdesc->smp)
> 		smp_set_ops(mdesc->smp);
> 
> ?

Yes, we agreed about it.
However that change was in a separate patch that I have dropped from
this version of the series, that is why it is missing.

I'll add back the change but I'll keep it in a separate patch to leave
the original one, now acked twice and reviewed once, untouched.


> This way you won't need the ->smp_init for Xen and that won't conflict 
> with MCPM.

See my other reply on the subject.
