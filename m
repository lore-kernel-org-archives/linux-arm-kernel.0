From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 6 Aug 2012 11:46:14 +0100
Subject: [Xen-devel] [PATCH 01/24] arm: initial Xen support
In-Reply-To: <20120802141341.GE16749@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <50197527.3070007@gmail.com> <1343892951.7571.50.camel@dagon.hellion.org.uk>
 <20120802141341.GE16749@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1208061142070.4645@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Aug 2012, Konrad Rzeszutek Wilk wrote:
> On Thu, Aug 02, 2012 at 08:35:51AM +0100, Ian Campbell wrote:
> > On Wed, 2012-08-01 at 19:27 +0100, Rob Herring wrote:
> > > On 07/26/2012 10:33 AM, Stefano Stabellini wrote:
> > > > - Basic hypervisor.h and interface.h definitions.
> > > > - Skelethon enlighten.c, set xen_start_info to an empty struct.
> > > > - Do not limit xen_initial_domain to PV guests.
> > > > 
> > > > The new code only compiles when CONFIG_XEN is set, that is going to be
> > > > added to arch/arm/Kconfig in a later patch.
> > > > 
> > > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > > ---
> > > >  arch/arm/Makefile                     |    1 +
> > > >  arch/arm/include/asm/hypervisor.h     |    6 +++
> > > >  arch/arm/include/asm/xen/hypervisor.h |   19 ++++++++++
> > > >  arch/arm/include/asm/xen/interface.h  |   64 +++++++++++++++++++++++++++++++++
> > > 
> > > These headers don't seem particularly ARM specific. Could they be moved
> > > to asm-generic or include/linux?
> > 
> > Or perhaps include/xen.
> > 
> > A bunch of it also looks like x86 specific stuff which has crept in.
> > e.g. PARAVIRT_LAZY_FOO and paravirt_get_lazy_mode() are arch/x86
> > specific and shouldn't be called from common code (and aren't, AFAICT).
> 
> The could be moved out..
> 

they are called from grant-table.c; sigh, I was the one to add them there :-(

interface.h is ARM specific, except for the pvclock structs, that in
fact are marked "XXX".

hypervisor.h is almost empty but I guess I could move out the following two
lines:

extern struct shared_info *HYPERVISOR_shared_info;
extern struct start_info *xen_start_info;

Considering that each arch is free to map them (or not) the way it
wants, I don't think is a good idea.
