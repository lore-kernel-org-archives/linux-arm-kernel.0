From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 2 Mar 2017 08:39:19 +0800
Subject: [PATCH v2 2/3] coresight: refactor with function
 of_coresight_get_cpu
In-Reply-To: <20170301160233.GB4009@linaro.org>
References: <1488294420-14188-1-git-send-email-leo.yan@linaro.org>
 <1488294420-14188-3-git-send-email-leo.yan@linaro.org>
 <20170301160233.GB4009@linaro.org>
Message-ID: <20170302003919.GC1906@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 09:02:33AM -0700, Mathieu Poirier wrote:
> On Tue, Feb 28, 2017 at 11:06:59PM +0800, Leo Yan wrote:
> > This is refactor to add function of_coresight_get_cpu(), so it's used to
> > retrieve CPU id for coresight component. Finally can use it as a common
> > function for multiple places.
> > 
> > Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/of_coresight.c | 35 ++++++++++++++++++++----------
> >  include/linux/coresight.h                  |  2 ++
> >  2 files changed, 25 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> > index 629e031..2e7bbe2 100644
> > --- a/drivers/hwtracing/coresight/of_coresight.c
> > +++ b/drivers/hwtracing/coresight/of_coresight.c
> > @@ -101,14 +101,34 @@ static int of_coresight_alloc_memory(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +int of_coresight_get_cpu(struct device_node *node)
> > +{
> > +	int cpu;
> > +	struct device_node *dn;
> > +
> > +	dn = of_parse_phandle(node, "cpu", 0);
> > +
> > +	/* Affinity defaults to CPU0 */
> > +	if (!dn)
> > +		return 0;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		if (dn == of_get_cpu_node(cpu, NULL))
> > +			break;
> > +	}
> > +	of_node_put(dn);
> 
> In the case where no CPU nodes are found this function will return the number
> of the last CPU that was probed instead of '0'.

Sure, will fix this.

> > +
> > +	return cpu;
> > +}
> > +EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
> 
> Any reason you exported this - the fact that is it declared in corsight.h should
> be enough.

Will remove it.

Thanks,
Leo Yan

> > +
> >  struct coresight_platform_data *of_get_coresight_platform_data(
> >  				struct device *dev, struct device_node *node)
> >  {
> > -	int i = 0, ret = 0, cpu;
> > +	int i = 0, ret = 0;
> >  	struct coresight_platform_data *pdata;
> >  	struct of_endpoint endpoint, rendpoint;
> >  	struct device *rdev;
> > -	struct device_node *dn;
> >  	struct device_node *ep = NULL;
> >  	struct device_node *rparent = NULL;
> >  	struct device_node *rport = NULL;
> > @@ -175,16 +195,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
> >  		} while (ep);
> >  	}
> >  
> > -	/* Affinity defaults to CPU0 */
> > -	pdata->cpu = 0;
> > -	dn = of_parse_phandle(node, "cpu", 0);
> > -	for (cpu = 0; dn && cpu < nr_cpu_ids; cpu++) {
> > -		if (dn == of_get_cpu_node(cpu, NULL)) {
> > -			pdata->cpu = cpu;
> > -			break;
> > -		}
> > -	}
> > -	of_node_put(dn);
> > +	pdata->cpu = of_coresight_get_cpu(node);
> >  
> >  	return pdata;
> >  }
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 2a5982c..6709561 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -263,11 +263,13 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
> >  #endif
> >  
> >  #ifdef CONFIG_OF
> > +extern int of_coresight_get_cpu(struct device_node *node);
> >  extern struct coresight_platform_data *of_get_coresight_platform_data(
> >  				struct device *dev, struct device_node *node);
> >  #else
> >  static inline struct coresight_platform_data *of_get_coresight_platform_data(
> >  	struct device *dev, struct device_node *node) { return NULL; }
> > +static int of_coresight_get_cpu(struct device_node *node) { return 0; }
> >  #endif
> >  
> >  #ifdef CONFIG_PID_NS
> > -- 
> > 2.7.4
> > 
