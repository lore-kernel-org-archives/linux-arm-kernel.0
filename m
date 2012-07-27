From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 27 Jul 2012 17:11:19 +0100
Subject: [PATCH 12/24] xen/arm: Introduce xen_guest_init
In-Reply-To: <alpine.DEB.2.02.1207271613200.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-12-git-send-email-stefano.stabellini@eu.citrix.com>
 <1343382151.6812.124.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1207271613200.26163@kaball.uk.xensource.com>
Message-ID: <1343405479.25096.25.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-27 at 16:54 +0100, Stefano Stabellini wrote:
> On Fri, 27 Jul 2012, Ian Campbell wrote:
> > On Thu, 2012-07-26 at 16:33 +0100, Stefano Stabellini wrote:
> > > We used to rely on a core_initcall to initialize Xen on ARM, however
> > > core_initcalls are actually called after early consoles are initialized.
> > > That means that hvc_xen.c is going to be initialized before Xen.
> > > 
> > > Given the lack of a better alternative, just call a new Xen
> > > initialization function (xen_guest_init) from xen_cons_init.
> > 
> > Can't we just arrange for this to be called super early on from
> > setup_arch? That's got to be better than calling it from some random
> > function which happens to get called early enough.
> 
> While I agree with you that an explicit call to xen_guest_init from
> generic code might be better, xen_cons_init is not just a random
> function: it is a console_initcall and therefore we know for sure that
> it is going be the first one to be called.

Initialising something != console in a console_initcall just because it
happens to be called early enough meets my definition of calling it from
a random place.

> In fact if we didn't want the PV console to work so early we could just
> rely on a core_initcall to initialize everything and we wouldn't have
> any issues.
> 
> 
> In any case if the ARM maintainers agree I could add a generic
> hypervisor initialization call the end of setup_arch.
> 
> 
> 
> > I presume that KVM is going to want some similarly early init hooks etc
> > and therefore ARM could benefit from the same sort of infrastructure as
> > is in arch/x86/include/asm/hypervisor.h?
