From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 6 Apr 2017 14:25:10 +0200
Subject: [PATCH v2 02/22] asm-generic/io.h: add ioremap_nopost remap
 interface
In-Reply-To: <20170406121157.GD17774@n2100.armlinux.org.uk>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon> <20170406102636.GA9623@red-moon>
 <20170406105312.GE28800@wotan.suse.de>
 <20170406121157.GD17774@n2100.armlinux.org.uk>
Message-ID: <20170406122510.GH28800@wotan.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 01:11:57PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 06, 2017 at 12:53:12PM +0200, Luis R. Rodriguez wrote:
> > On Thu, Apr 06, 2017 at 11:26:36AM +0100, Lorenzo Pieralisi wrote:
> > > Indeed, the static inline ioremap_nocache() fallback does not work
> > > on all arches (whether I add the fallback in linux/io.h or
> > > asm-generic/io.h is irrelevant), I bump into issues such as the one
> > > reported above.
> > 
> > Its also not *safe* to assume on behalf of all architectures a new ioremap
> > call is both a good idea and proper.
> 
> You may be right in general, but not in this case.
> 
> Currently, many drivers use plain ioremap() to map this resource.  We
> are replacing that existing call - which is known to work in the majority
> of cases - with a new call to cater for different semantics required by
> an architecture.
> 
> Doing a replace of these ioremap() calls with ioremap_nopost() in this
> situation, and then having ioremap_nopost() fail is a recipe for causing
> lots and lots of regressions.
> 
> The only sane approach is to have ioremap_post() default to modelling the
> _existing_ behaviour everywhere that it is used.
> 
> Requiring it to fail until architecture folk trip over the failure is
> totally insane, and I very strongly disagree with you on this.

Ah yes, what if with this modulo rule of thumb:

The litmus test then is if an existing set of calls are changed to
use a new ioremap then all archs that support those drivers where the new
call is being added must be modified to also have a correct corresponding
API call ?

This is more work on the new person introducing the new API, and should require
review still on arch maintainers but it seems like a fair compromise.

Then if an API is *new* though then things can move forward without requiring
all archs to add the respective call.

  Luis
