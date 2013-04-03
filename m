From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 3 Apr 2013 10:00:02 -0400 (EDT)
Subject: [PATCH v5 3/3] xen/arm: introduce xen_early_init, use PSCI on xen
In-Reply-To: <alpine.DEB.2.02.1304031217310.5078@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304021700380.5078@kaball.uk.xensource.com>
 <1364919374-7836-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1304021325230.1171@syhkavp.arg>
 <alpine.DEB.2.02.1304031217310.5078@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1304030955180.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Apr 2013, Stefano Stabellini wrote:

> On Tue, 2 Apr 2013, Nicolas Pitre wrote:
> > On Tue, 2 Apr 2013, Stefano Stabellini wrote:
> > 
> > > @@ -176,27 +178,30 @@ static int __init xen_secondary_init(unsigned int cpu)
> > >  	return 0;
> > >  }
> > >  
> > > +static void __init xen_smp_init(void)
> > > +{
> > > +	if (psci_smp_available())
> > > +		smp_set_ops(&psci_smp_ops);
> > > +}
> > > +
> > 
> > I still don't understand why you need to do this.  Why can't you just 
> > rely on the next priority which is to set PSCI ops by default if 
> > available?  Using this hook for Xen doesn't look justified. As it is, 
> > you break MCPM.
> > 
> > As I explained to you, MCPM will end up using PSCI as well when 
> > available, which I think should be sufficient for your concern.
> 
> The smp_init hook is not limited to MCPM or the versatile express
> platform. It's a generic hook that can be used by any platform and can
> override the platform smp_ops or the psci_smp_ops depending on platform
> specific configurations.
> 
> Configurations that I am pretty sure won't be available on Xen anyway,
> while I am certain that using psci_smp_ops would work.
> 
> It seems to me that relying on the fact that only versatile express and
> only MCPM use smp_init, even though it might work today, it's very
> fragile and could break tomorrow without any of us noticing.

I claim: this breaks MCPM today.

You claim: the alternative _could_ break with Xen tomorrow.

Could we please wait until there is an actual problem with Xen before 
being overly defensive in the code?


Nicolas
