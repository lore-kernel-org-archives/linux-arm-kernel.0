From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 26 Mar 2013 15:09:02 +0000
Subject: [PATCH v2 6/6] [RFC] arm: use PSCI if available
In-Reply-To: <201303261458.55183.arnd@arndb.de>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
 <1364308875-26484-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <201303261458.55183.arnd@arndb.de>
Message-ID: <alpine.DEB.2.02.1303261508370.4430@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Stefano Stabellini wrote:
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
> Very nice, I had a similar idea but had not gotten around to write a patch.
> This fits in nicely with my plans to make all fields of machine_desc optional.
> 
> >  void __init smp_set_ops(struct smp_operations *ops)
> >  {
> > -       if (ops)
> > +       int rc = -ENODEV;
> > +#ifdef CONFIG_ARM_PSCI
> > +       rc = psci_init(&smp_ops);
> > +#endif
> > +       if (rc && ops)
> >                smp_ops = *ops;
> >  };
> 
> Could you move this into the caller, i.e. setup_arch() so we call smp_set_ops
> either for psci_smp_ops or for machine_desc->smp?

Sure, I can do that.
