From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 3 Jan 2014 14:49:54 +0000
Subject: [PATCH] arm64/xen: redefine xen_remap on arm64
In-Reply-To: <20140103143104.GN7383@n2100.arm.linux.org.uk>
References: <1388386511-32276-1-git-send-email-baozich@gmail.com>
 <1388431259.2564.15.camel@deneb.redhat.com>
 <alpine.DEB.2.02.1401031310100.8667@kaball.uk.xensource.com>
 <20140103143104.GN7383@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1401031444550.8667@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jan 2014, Russell King - ARM Linux wrote:
> On Fri, Jan 03, 2014 at 01:13:57PM +0000, Stefano Stabellini wrote:
> > On Mon, 30 Dec 2013, Mark Salter wrote:
> > > On Mon, 2013-12-30 at 14:55 +0800, Chen Baozi wrote:
> > > > xen_remap used to be defined as ioremap_cached on arm64. In commit
> > > > c04e8e2fe, a new ioremap_cache was implemented, and ioremap_cached
> > > > was deleted, while xen_remap stays the same. This would lead to
> > > > the failure when building with CONFIG_HVC_XEN. Redefined xen_remap
> > > > on arm64 as ioremap_cache on arm64 to fix it.
> > > > 
> > > 
> > > I missed that include of arm header by arm64 when looking for users
> > > of arm64's ioremap_cached() when working on commit c04e8e2fe. Anyway,
> > > grepping the kernel tree, I see:
> > > 
> > >   ioremap_cached()
> > >     defined by: arm, metag, unicore32
> > >     used by: arch/arm/include/asm/xen/page.h
> > >              drivers/mtd/maps/pxa2xx-flash.c
> > > 
> > >   ioremap_cache()
> > >     defined by: arm64, sh, xtensa, ia64, x86
> > >     used by: drivers/video/vesafb.c
> > >              drivers/char/toshiba.c
> > >              drivers/acpi/apei
> > >              drivers/lguest/lguest_device.c
> > >              drivers/sfi/sfi_core.c
> > >              include/linux/acpi_io.h
> > > 
> > > I think it would be better to just avoid the confusion and the ifdef in
> > > asm/xen/page.h by globally changing ioremap_cached to ioremap_cache.
> > 
> > While I welcome the suggestion, this is a critical fix for a regression
> > that I think should go in as soon as possible, maybe 3.13-rc7, while I
> > don't think that a global s/ioremap_cached/ioremap_cache would be
> > acceptable at this stage.
> 
> Since it's just one driver, just make the change for ARM (provided the
> grep is accurate.)  pxa2xx-flash is only used on ARM and not the other
> two listed there, so looks like metag and unicore just decided to copy
> ARM.
> 
> My grep concurs with yours.
> 
> So... just change ioremap_cached -> ioremap_cache in
> arch/arm/include/asm/io.h
> arch/arm/include/asm/xen/page.h
> drivers/mtd/maps/pxa2xx-flash.c
> 
> to fix the problem.

OK. That would be Rob's patch below.
Are you going to take care of sending it to Linus?

Thanks for the quick reply.
