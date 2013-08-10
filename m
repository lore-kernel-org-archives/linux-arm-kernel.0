From: joe@perches.com (Joe Perches)
Date: Sat, 10 Aug 2013 08:59:46 -0700
Subject: [PATCH] arch/arm/mach-pxa/stargate2.c: use ARRAY_AND_SIZE
 consistently
In-Reply-To: <alpine.DEB.2.02.1308101735060.2076@localhost6.localdomain6>
References: <1376148353-9699-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376148738.2083.17.camel@joe-AO722>
 <alpine.DEB.2.02.1308101735060.2076@localhost6.localdomain6>
Message-ID: <1376150386.2083.26.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-08-10 at 17:38 +0200, Julia Lawall wrote:
> On Sat, 10 Aug 2013, Joe Perches wrote:
> > On Sat, 2013-08-10 at 17:25 +0200, Julia Lawall wrote:
> > > From: Julia Lawall <Julia.Lawall@lip6.fr>
> > > Because ARRAY_AND_SIZE changes the apparent arity of a function, if it is
> > > used for one call to a given function, it would be better, if possible, to
> > > use it for all of them.
> > I think it'd be better to remove ARRAY_AND_SIZE instead.
> 
> I can do that, if it is wanted, but there are over 200 uses, and I think 
> it is a little bit positive in that it ensures that the array is passed 
> along with its own size.

Maybe, but if it's generally accepted that it's useful,
and I'm a little dubious because it does hide argument
count in functions where it's used, the 6 #defines should
be centralized in kernel.h

$ git grep "define.*ARRAY_AND_SIZE"
arch/arm/mach-kirkwood/common.h:#define ARRAY_AND_SIZE(x)       (x), ARRAY_SIZE(x)
arch/arm/mach-mmp/common.h:#define ARRAY_AND_SIZE(x)    (x), ARRAY_SIZE(x)
arch/arm/mach-pxa/generic.h:#define ARRAY_AND_SIZE(x)   (x), ARRAY_SIZE(x)
arch/arm/mach-ux500/db8500-regs.h:#define ARRAY_AND_SIZE(x)     (x), ARRAY_SIZE(x)
drivers/pinctrl/pinctrl-lantiq.h:#define ARRAY_AND_SIZE(x)      (x), ARRAY_SIZE(x)
sound/soc/pxa/mioa701_wm9713.c:#define ARRAY_AND_SIZE(x)        (x), ARRAY_SIZE(x)

A small counter-argument against using ARRAY_AND_SIZE:

clkdev_add_table has 60+ uses, only 6 of those with
ARRAY_AND_SIZE.

I think it makes it difficult to do some cocinelle/spatch
transform on clkdev_add_table.
