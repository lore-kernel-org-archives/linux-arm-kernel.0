From: mporter@linaro.org (Matt Porter)
Date: Mon, 28 Apr 2014 10:37:09 -0400
Subject: [PATCH] ARM: l2c: prima2: only call l2x0_of_init() on matching
 nodes
In-Reply-To: <20140428142950.GB30292@saruman.home>
References: <1398644860-22973-1-git-send-email-mporter@linaro.org>
 <20140428142950.GB30292@saruman.home>
Message-ID: <20140428143709.GC7719@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 09:29:51AM -0500, Felipe Balbi wrote:
> On Sun, Apr 27, 2014 at 08:27:40PM -0400, Matt Porter wrote:
> > l2x0_of_init() is executed unconditionally within the sirfsoc_l2x0_init()
> > early initcall. In a multi v7 kernel this causes bcm281xx and bcm21664
> > platform to fail boot since they have their own pre l2x0 init sequence
> > that is required. Fix this by checking that a matching OF ID is present
> > before calling l2x0_of_init().
> > 
> > Reported-by: Kevin Hilman <khilman@linaro.org>
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > ---
> > Applies against next-20140424 to fix the issue introduced in
> > 50655e6 ARM: l2c: prima2: remove cache size override
> > 
> >  arch/arm/mach-prima2/l2x0.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
> > index 09f68f0..1c2ed15 100644
> > --- a/arch/arm/mach-prima2/l2x0.c
> > +++ b/arch/arm/mach-prima2/l2x0.c
> > @@ -8,10 +8,24 @@
> >  
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/of.h>
> >  #include <asm/hardware/cache-l2x0.h>
> >  
> > +static const struct of_device_id sirf_l2x0_ids[] __initconst = {
> > +	{ .compatible = "sirf,prima2-pl310-cache" },
> > +	{ .compatible = "sirf,marco-pl310-cache" },
> 
> that same commit removed these two from DTS, did you test with old DTS,
> btw any chance ?

The "fix" is tested against bcm281xx and bcm21664 as that is what the
l2c cleanup breaks in -next. As mentioned, I don't have the sirfsoc h/w
so this first attempt at a fix also breaks their platform. It can be
addressed by adding those platform specific compatibles back to the dts,
of course.

I'd much prefer that the sirfsoc folks fix this...it's going to break
other platforms in a multi v7 build.

-Matt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/70393dfc/attachment.sig>
