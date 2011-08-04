From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 04 Aug 2011 11:06:25 +0530
Subject: [PATCH V2 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <4E3A2BFC.3070907@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<bc59bbd3709a7af1723d37ab846bf44c6867c00e.1312190881.git.viresh.kumar@st.com>
	<20110803123953.GB23953@n2100.arm.linux.org.uk>
	<4E3A2BFC.3070907@st.com>
Message-ID: <1312436185.1536.570.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-04 at 10:49 +0530, viresh kumar wrote:
> On 08/03/2011 06:09 PM, Russell King - ARM Linux wrote:
> > On Mon, Aug 01, 2011 at 03:07:18PM +0530, Viresh Kumar wrote:
> >> Insert notifiers for the runtime PM API. With this the runtime PM layer kicks in
> >> to action where used. This will also handle enabling/disabling of interface
> >> clock (Code will be added in amba/bus.c by Russell King).
> > 
> > I don't think this is correct...
> 
> Sorry, but i couldn't get this comment completely. Mentioning clock
> stuff here is incorrect or mentioning about your code? Or both?
> Or something else?
> 
> >> +	pm_runtime_resume(&pl08x->adev->dev);
> > 
> > Shouldn't this be pm_runtime_get_sync() ?
> 
> >> +	pm_runtime_suspend(&pl08x->adev->dev);
> > 
> > And pm_runtime_put() ?
> 
> >> +	pm_runtime_suspend(&adev->dev);
> > 
> > And pm_runtime_put() ?
> 
> I have already fixed above in V3.
> 
> > Lastly, we may want to make this even tighter to the actual period that
> > the DMA is being used, rather than just the period that a driver has
> > been allocated a channel.  I'd rather have it done that way now (and
> > tested) so that we achieve maximal effect from runtime PM, rather than
> > having something which needs to be revisited again.
> > 
> > IOW, if this is worth doing, then its worth doing properly first time.
> 
> Correct. What about this one:
> 
> ---
>  drivers/dma/amba-pl08x.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 3fbaf0e..24353df 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -84,6 +84,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <asm/hardware/pl080.h>
> @@ -405,6 +406,7 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
>  		return NULL;
>  	}
>  
> +	pm_runtime_get_sync(&pl08x->adev->dev);
this should be ideally one of the first things you would do not last.
get_sync will ensure your .runtime_resume callback is called before it
returns (if its suspended)
>  	return ch;
>  }
>  
> @@ -418,6 +420,8 @@ static inline void pl08x_put_phy_channel(struct pl08x_driver_data *pl08x,
>  	/* Stop the channel and clear its interrupts */
>  	pl08x_terminate_phy_chan(pl08x, ch);
>  
> +	pm_runtime_put(&pl08x->adev->dev);
> +
>  	/* Mark it as free */
>  	ch->serving = NULL;
>  	spin_unlock_irqrestore(&ch->lock, flags);
> @@ -1855,6 +1859,9 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto out_no_pl08x;
>  	}
>  
> +	pm_runtime_set_active(&adev->dev);
> +	pm_runtime_enable(&adev->dev);
> +
>  	/* Initialize memcpy engine */
>  	dma_cap_set(DMA_MEMCPY, pl08x->memcpy.cap_mask);
>  	pl08x->memcpy.dev = &adev->dev;
> @@ -1993,6 +2000,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev_info(&pl08x->adev->dev, "DMA: PL%03x rev%u at 0x%08llx irq %d\n",
>  		 amba_part(adev), amba_rev(adev),
>  		 (unsigned long long)adev->res.start, adev->irq[0]);
> +
> +	pm_runtime_put(&adev->dev);
_put is probe looks suspect, why do you need this here as you are
already setting the status as active, this _put will decrement your
usage count and possibly call your runtime_suspend
>  	return 0;
>  
>  out_no_slave_reg:
> @@ -2011,6 +2020,9 @@ out_no_ioremap:
>  	dma_pool_destroy(pl08x->pool);
>  out_no_lli_pool:
>  out_no_platdata:
> +	pm_runtime_put(&adev->dev);
> +	pm_runtime_disable(&adev->dev);
> +
>  	kfree(pl08x);
>  out_no_pl08x:
>  	amba_release_regions(adev);
> 
> 


-- 
~Vinod
