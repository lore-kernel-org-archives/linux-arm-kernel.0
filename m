From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 17:17:17 +0800
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <20120427075544.GV17184@pengutronix.de>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <20120427075544.GV17184@pengutronix.de>
Message-ID: <20120427091716.GR28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 09:55:44AM +0200, Sascha Hauer wrote:
> On Fri, Apr 27, 2012 at 03:02:55PM +0800, Richard Zhao wrote:
> > device_prep_dma_cyclic may be call in audio trigger function which is
> > atomic context, so we make it atomic too.
> > 
> >  - change channel0 lock to spinlock.
> >  - Use polling to wait for channel0 finish running.
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  drivers/dma/imx-sdma.c |   57 +++++++++++++++++++++++++++--------------------
> >  1 files changed, 33 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index fddccae..fc49ffa 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -24,7 +24,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/clk.h>
> > -#include <linux/wait.h>
> > +#include <linux/delay.h>
> >  #include <linux/sched.h>
> >  #include <linux/semaphore.h>
> >  #include <linux/spinlock.h>
> > @@ -324,7 +324,7 @@ struct sdma_engine {
> >  	struct dma_device		dma_device;
> >  	struct clk			*clk_ipg;
> >  	struct clk			*clk_ahb;
> > -	struct mutex			channel_0_lock;
> > +	spinlock_t		channel_0_lock;
> >  	struct sdma_script_start_addrs	*script_addrs;
> >  };
> >  
> > @@ -402,19 +402,31 @@ static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
> >  }
> >  
> >  /*
> > - * sdma_run_channel - run a channel and wait till it's done
> > + * sdma_run_channel0 - run a channel and wait till it's done
> >   */
> > -static int sdma_run_channel(struct sdma_channel *sdmac)
> > +static int sdma_run_channel0(struct sdma_channel *sdmac)
> 
> Renaming this to sdma_run_channel0 is fine, but then the argument should
> be changed to struct sdma_engine. It makes no sense to say in the
> function name that this function is channel 0 only and at the same time
> allow to pass in an arbitrary other channel.
Correct. Thanks.

Richard
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
