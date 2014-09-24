From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 20:40:18 +0200
Subject: [PATCH 5/6] arm64, defconfig: Enable PCI
In-Reply-To: <20140924171047.GO15842@e104818-lin.cambridge.arm.com>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <20140924162631.GI31556@rric.localhost>
 <20140924171047.GO15842@e104818-lin.cambridge.arm.com>
Message-ID: <3120493.DIoQFCi5Am@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 18:10:48 Catalin Marinas wrote:
> On Wed, Sep 24, 2014 at 05:26:31PM +0100, Robert Richter wrote:
> > On 24.09.14 18:14:11, Arnd Bergmann wrote:
> > > On Wednesday 24 September 2014 17:37:47 Robert Richter wrote:
> > > >  config PCI
> > > >         bool "PCI support"
> > > > +       default y
> > > >         help
> > > >           This feature enables support for PCIe bus system. If you say Y
> > > >           here, the kernel will include drivers and infrastructure code
> > > >           to support PCIe bus devices.
> > > >  
> > > > +config PCI_MSI
> > > > +       def_bool PCI
> > > > +
> > > >  config PCI_DOMAINS
> > > >         def_bool PCI
> > > 
> > > There is already a PCI_MSI symbol in drivers/pci/Kconfig. Just select that
> > > from the PCI symbol above rather than defining a second one.
> > 
> > The intention is not to have a second definition, instead this should
> > enable the default value just for arm64. Thus I put it to
> > arch/arm64/Kconfig. Otherwise it would be enabled per default on all
> > archs.

I don't think other architectures actually see the PCI symbol that is
defined in the arm64 Kconfig file, but I might be wrong.

> > We could have used select in config ARM64, but I tried to avoid using
> > select due to the dependency issue and instead implement this with
> > default-y/depends-on. Doing so it can be manually disabled too.

How about adding a new symbol like

config ARM64_PCI
	def_bool PCI
	select PCI_MSI


> It may be better to simply set PCI and PCI_MSI as defaults in defconfig
> rather than "default y" and an additional config PCI_MSI entry.

Selecting PCI_MSI unconditionally seems fine to me. We won't have any
ARM64 systems that only do classic PCI, and MSI is mandatory for PCIe.

	Arnd
