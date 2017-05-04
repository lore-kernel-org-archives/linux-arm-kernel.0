From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 4 May 2017 08:40:59 +0800
Subject: [PATCH] coresight: use const for device_node structures
In-Reply-To: <20170503202136.GA7860@linaro.org>
References: <1493712903-16726-1-git-send-email-leo.yan@linaro.org>
 <20170503202136.GA7860@linaro.org>
Message-ID: <20170504004058.GE17974@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 02:21:36PM -0600, Mathieu Poirier wrote:
> Hi Leo,
> 
> On Tue, May 02, 2017 at 04:15:03PM +0800, Leo Yan wrote:
> > Almost low level functions from open firmware have used const to
> > qualify device_node structures, so add const for device_node
> > parameters in of_coresight related functions.
> > 
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/of_coresight.c | 4 ++--
> >  include/linux/coresight.h                  | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> > index 629e031..859ad49 100644
> > --- a/drivers/hwtracing/coresight/of_coresight.c
> > +++ b/drivers/hwtracing/coresight/of_coresight.c
> > @@ -52,7 +52,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
> >  			       endpoint, of_dev_node_match);
> >  }
> >  
> > -static void of_coresight_get_ports(struct device_node *node,
> > +static void of_coresight_get_ports(const struct device_node *node,
> >  				   int *nr_inport, int *nr_outport)
> >  {
> >  	struct device_node *ep = NULL;
> > @@ -102,7 +102,7 @@ static int of_coresight_alloc_memory(struct device *dev,
> >  }
> >  
> >  struct coresight_platform_data *of_get_coresight_platform_data(
> > -				struct device *dev, struct device_node *node)
> > +			struct device *dev, const struct device_node *node)
> 
> The original code didn't do things right.  I suggest:
> 
> struct coresight_platform_data *
> of_get_coresight_platform_data(struct device *dev,
>                                const struct device_node *node)
> 
> 
> >  {
> >  	int i = 0, ret = 0, cpu;
> >  	struct coresight_platform_data *pdata;
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 2a5982c..769f2c8 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -264,10 +264,10 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
> >  
> >  #ifdef CONFIG_OF
> >  extern struct coresight_platform_data *of_get_coresight_platform_data(
> > -				struct device *dev, struct device_node *node);
> > +	struct device *dev, const struct device_node *node);
> 
> Same as above.
> 
> Please send me another revision and I'll pick this up for the next cycle.

Sure, have sent out.

Thanks,
Leo Yan
