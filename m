From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 3 Aug 2017 10:03:55 -0700
Subject: [PATCH 1/2] bitops: Avoid integer overflow warning in GENMASK_ULL
In-Reply-To: <20170803132456.mwrt6yspkbqxcffw@yury-thinkpad>
References: <20170802225159.159536-1-mka@chromium.org>
 <20170803132456.mwrt6yspkbqxcffw@yury-thinkpad>
Message-ID: <20170803170355.GJ84665@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Aug 03, 2017 at 04:24:56PM +0300 Yury Norov ha dit:

> On Wed, Aug 02, 2017 at 03:51:58PM -0700, Matthias Kaehlcke wrote:
> > GENMASK_ULL performs a left-shift of (~0ULL), which technically
> > results in an integer overflow. clang raises a warning about
> > this if the overflow occurs in a preprocessor expression. To
> > avoid the overflow first perform a right-shift to clear the
> > bits that are shifted out.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  include/linux/bitops.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index a83c822c35c2..21dfe63001e3 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -22,7 +22,7 @@
> >  	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> 
> Once you touche GENMASK_ULL, why not to fix also GENMASK.

Will do, thanks.

Even though GENMASK_ULL can't be used (as is) to define the arm64
PAGE_OFFSET as initially intended it seems the change is still
worthwhile since there are a few other preprocessor expressions using
GENMASK_ULL.
