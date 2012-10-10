From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 10 Oct 2012 17:01:26 +0100
Subject: [Xen-devel] [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <1349880826.10070.41.camel@zakaz.uk.xensource.com>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-6-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.02.1210091630170.29539@kaball.uk.xensource.com>
 <201210091821.27818.arnd@arndb.de>
 <1349855687.6952.75.camel@dagon.hellion.org.uk>
 <alpine.DEB.2.02.1210101544500.2689@kaball.uk.xensource.com>
 <1349880826.10070.41.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1210101655360.2689@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Oct 2012, Ian Campbell wrote:
> On Wed, 2012-10-10 at 15:47 +0100, Stefano Stabellini wrote:
> > On Wed, 10 Oct 2012, Ian Campbell wrote:
> > > On Tue, 2012-10-09 at 19:21 +0100, Arnd Bergmann wrote:
> > > > On Tuesday 09 October 2012, Stefano Stabellini wrote:
> > > > > >  config XEN
> > > > > >       bool "Xen guest support on ARM (EXPERIMENTAL)"
> > > > > >       depends on EXPERIMENTAL && ARM && OF
> > > > > > +     depends on !CPU_V6
> > > > > >       help
> > > > > >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> > > > > 
> > > > > Considering that we rely on the virtualization extensions, this one can
> > > > > be:
> > > > > 
> > > > >     depends on CPU_V7
> > > > > 
> > > > > The rest looks fine. I can submit a second patch to change !CPU_V6 into
> > > > > CPU_V7 later, if you prefer.
> > > > 
> > > > CPU_V6 and CPU_V7 are not exclusive, I saw the problem when building a
> > > > combined kernel for both V6 and V7. The code also needs to depend on ARMv7
> > > > with virtualization extensions, but that is a different issue. We don't
> > > > actually have a configuration symbol for that yet, as far as I can tell.
> > > 
> > > I don't think the guest kernels (including dom0) need the extensions to
> > > run under Xen, they are only need by Xen itself. The guests should just
> > > see a relatively normal v7 processor. 
> > > 
> > > Stefano, does that sound right?
> > 
> > Keep in mind that we are using HVC to issue hypercalls, and HVC has been
> > introduced with the virtualization extensions, if I am not mistaken.
> 
> I think we can ignore that in this context since it is only used by bits
> which are already virtualisation aware -- i.e. you wouldn't want to add
> it to the Kconfig as a dependency for Xen.

Considering that ARM CPU_V* symbols are not mutually exclusive, if Linux
had a CPU_V7_VIRTEXT symbol I don't see why we shouldn't add it to our
list of dependencies. It is more accurate than CPU_V7 after all.

But I don't think that it is necessary to introduce one now only for
Xen, because like you said, we only need HVC and that is only used in
virtualization aware code.
