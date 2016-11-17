From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 17 Nov 2016 09:07:48 +0100
Subject: [PATCH] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <1722218.eZlGktOxfL@tauon.atsec.com>
References: <1476794067-28563-1-git-send-email-clabbe.montjoie@gmail.com>
 <1722218.eZlGktOxfL@tauon.atsec.com>
Message-ID: <20161117080748.GB25394@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 04:24:22PM +0200, Stephan Mueller wrote:
> Am Dienstag, 18. Oktober 2016, 14:34:27 CEST schrieb Corentin Labbe:
> 
> Hi Corentin,
> 
> > diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hwrng.c
> > b/drivers/crypto/sunxi-ss/sun4i-ss-hwrng.c new file mode 100644
> > index 0000000..95fadb7
> > --- /dev/null
> > +++ b/drivers/crypto/sunxi-ss/sun4i-ss-hwrng.c
> > @@ -0,0 +1,70 @@
> > +#include "sun4i-ss.h"
> > +
> > +static int sun4i_ss_hwrng_init(struct hwrng *hwrng)
> > +{
> > +	struct sun4i_ss_ctx *ss;
> > +
> > +	ss = container_of(hwrng, struct sun4i_ss_ctx, hwrng);
> > +	get_random_bytes(ss->seed, SS_SEED_LEN);
> 
> Is it wise to call get_random_bytes once in the init function and never 
> thereafter?
> 
> This init function may be called during boot time of the kernel at which the 
> input_pool may not yet have received sufficient amounts of entropy.
> 
> What about registering a callback with add_random_ready_callback and seed 
> again when sufficient entropy was collected?
> 

Seed again, or just do not seed (and so return -EAGAIN for read() function) until ready_callback ?

Thanks

Corentin Labbe
