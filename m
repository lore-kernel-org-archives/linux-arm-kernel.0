From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 31 Mar 2016 12:12:58 +0100
Subject: [Xen-devel] [PATCH v7 11/17] ARM: XEN: Move xen_early_init()
 before efi_init()
In-Reply-To: <20160329160756.GG6745@arm.com>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
 <1458830676-27075-12-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1603261252510.18380@kaball.uk.xensource.com>
 <20160329160756.GG6745@arm.com>
Message-ID: <alpine.DEB.2.02.1603311207460.11739@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2016, Will Deacon wrote:
> On Sat, Mar 26, 2016 at 12:54:09PM +0000, Stefano Stabellini wrote:
> > are you OK with this patch?
> 
> Nothing against it, but the only arm64 bit is:
> 
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index 450987d..6cf5051 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -313,6 +313,7 @@ void __init setup_arch(char **cmdline_p)
> > >  	 */
> > >  	local_async_enable();
> > >  
> > > +	xen_early_init();
> > >  	efi_init();
> > >  	arm64_memblock_init();
> > >  
> > > @@ -334,7 +335,6 @@ void __init setup_arch(char **cmdline_p)
> > >  	} else {
> > >  		psci_acpi_init();
> > >  	}
> > > -	xen_early_init();
> 
> so it's difficult to care too much ;)

Understood :-)


> I do hope that there won't be a
> need to split up efi_init() in future because some of it has to happen
> before xen_early_init, but that doesn't sound likely at the moment.

Right.

The series is almost fully acked, if you are OK with it, as soon as the
last couple of remaining comments are resolved, I'll queue it up in the
xentip tree for 4.7 (now it is too late for 4.6).
