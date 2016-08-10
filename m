From: s-anna@ti.com (Suman Anna)
Date: Wed, 10 Aug 2016 14:37:04 -0500
Subject: [PATCH 1/2] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <20160810174049.GO26240@tuxbot>
References: <20160719154905.23344-1-lee.jones@linaro.org>
 <20160810174049.GO26240@tuxbot>
Message-ID: <7650e5fa-f52c-1ab5-e197-8630fd7d0322@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee, Bjorn,

On 08/10/2016 12:40 PM, Bjorn Andersson wrote:
> On Tue 19 Jul 08:49 PDT 2016, Lee Jones wrote:
> 
>> - of_rproc_by_index(): look-up and obtain a reference to a rproc
>>                        using the DT phandle "rprocs" and a index.
>>
>> - of_rproc_by_name():  lookup and obtain a reference to a rproc
>>                        using the DT phandle "rprocs" and "rproc-names".
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
> 
> I'm happy with this, so I whipped up a binding document describing our
> two new properties. Waiting for an opinion on that before I merge this.

Yeah, I like the two new API too, I have just about run into the need
for the same on my product trees. We can probably make it less
complicated than what the current series is. The wkup_m3_ipc usage was
before there was any standardization on the property names, so we went
with a ti, prefixed property specific to the wkup_m3_ipc node and a
general API that is agnostic of property name. We don't have all the
pieces for PM on AM335x/AM437x SoCs on upstream kernel yet, so we should
be able to switch over to using the new property as we cannot achieve
the desired functionality even though we can boot the wkup_m3.

Here's what I propose:
1. Let's not burden the new of_get_rproc_by_index() API with having to
fall-back and look for ti,rprocs. The rproc_get_by_phandle() core logic
of looking up against the rproc list is self-contained, and the API
usage is limited to just the wkup_m3_ipc driver at the moment.
2. Keep the rproc_get_by_phandle API as is but mark it as deprecated.
IMHO, the rename of this API to of_get_rproc_by_phandle() in Patch 2 but
using a device node pointer as input argument doesn't add any value.
3. Provide a fallback in wkup_m3_ipc driver to look for both rprocs and
ti,rproc property, while switching over the node to use rprocs property.
4. We can get rid of the rproc_get_by_phandle() API after the
wkup_m3_ipc transition is done to use of_get_rproc_by_index() API.

Thoughts?

regards
Suman


> 
> Regards,
> Bjorn
> 
>>  drivers/remoteproc/remoteproc_core.c | 78 +++++++++++++++++++++++++++++++++++-
>>  include/linux/remoteproc.h           | 25 +++++++++++-
>>  2 files changed, 101 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index db3958b..6a0d158 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -41,6 +41,8 @@
>>  #include <linux/virtio_ids.h>
>>  #include <linux/virtio_ring.h>
>>  #include <asm/byteorder.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>>  
>>  #include "remoteproc_internal.h"
>>  
>> @@ -1191,6 +1193,81 @@ out:
>>  }
>>  EXPORT_SYMBOL(rproc_shutdown);
>>  
>> +#ifdef CONFIG_OF
>> +/**
>> + * of_get_rproc_by_index() - lookup and obtain a reference to an rproc
>> + * @np: node to search for rproc phandle
>> + * @index: index into the phandle list
>> + *
>> + * This function increments the remote processor's refcount, so always
>> + * use rproc_put() to decrement it back once rproc isn't needed anymore.
>> + *
>> + * Returns a pointer to the rproc struct on success or an appropriate error
>> + * code otherwise.
>> + */
>> +struct rproc *of_get_rproc_by_index(struct device_node *np, int index)
>> +{
>> +	struct rproc *rproc = NULL, *r;
>> +	struct device_node *rproc_np;
>> +
>> +	if (index < 0) {
>> +		pr_err("Invalid index: %d\n", index);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	rproc_np = of_parse_phandle(np, "rprocs", index);
>> +	if (!rproc_np) {
>> +		/* Unfortunately we have to support this, at least for now */
>> +		rproc_np = of_parse_phandle(np, "ti,rprocs", index);
>> +		if (!rproc_np) {
>> +			pr_err("Failed to obtain phandle\n");
>> +			return ERR_PTR(-ENODEV);
>> +		}
>> +	}
>> +
>> +	mutex_lock(&rproc_list_mutex);
>> +	list_for_each_entry(r, &rproc_list, node) {
>> +		if (r->dev.parent && r->dev.parent->of_node == rproc_np) {
>> +			get_device(&r->dev);
>> +			rproc = r;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&rproc_list_mutex);
>> +
>> +	of_node_put(rproc_np);
>> +
>> +	if (!rproc)
>> +		pr_err("Could not find rproc, deferring\n");
>> +
>> +	return rproc ?: ERR_PTR(-EPROBE_DEFER);
>> +}
>> +EXPORT_SYMBOL(of_get_rproc_by_index);
>> +
>> +/**
>> + * of_get_rproc_by_name() - lookup and obtain a reference to an rproc
>> + * @np: node to search for rproc
>> + * @name: name of the remoteproc from device's point of view
>> + *
>> + * This function increments the remote processor's refcount, so always
>> + * use rproc_put() to decrement it back once rproc isn't needed anymore.
>> + *
>> + * Returns a pointer to the rproc struct on success or an appropriate error
>> + * code otherwise.
>> + */
>> +struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
>> +{
>> +	int index;
>> +
>> +	if (unlikely(!name))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	index = of_property_match_string(np, "rproc-names", name);
>> +
>> +	return of_get_rproc_by_index(np, index);
>> +}
>> +EXPORT_SYMBOL(of_get_rproc_by_name);
>> +
>>  /**
>>   * rproc_get_by_phandle() - find a remote processor by phandle
>>   * @phandle: phandle to the rproc
>> @@ -1203,7 +1280,6 @@ EXPORT_SYMBOL(rproc_shutdown);
>>   *
>>   * Returns the rproc handle on success, and NULL on failure.
>>   */
>> -#ifdef CONFIG_OF
>>  struct rproc *rproc_get_by_phandle(phandle phandle)
>>  {
>>  	struct rproc *rproc = NULL, *r;
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 1c457a8..f130938 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -487,7 +487,6 @@ struct rproc_vdev {
>>  	u32 rsc_offset;
>>  };
>>  
>> -struct rproc *rproc_get_by_phandle(phandle phandle);
>>  struct rproc *rproc_alloc(struct device *dev, const char *name,
>>  				const struct rproc_ops *ops,
>>  				const char *firmware, int len);
>> @@ -511,4 +510,28 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
>>  	return rvdev->rproc;
>>  }
>>  
>> +#ifdef CONFIG_OF
>> +extern struct rproc *of_get_rproc_by_index(struct device_node *np,
>> +					   int index);
>> +extern struct rproc *of_get_rproc_by_name(struct device_node *np,
>> +					  const char *name);
>> +extern struct rproc *rproc_get_by_phandle(phandle phandle);
>> +#else
>> +static inline
>> +struct rproc *of_get_rproc_by_index(struct device_node *np, int index)
>> +{
>> +	return NULL;
>> +}
>> +static inline
>> +struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
>> +{
>> +	return NULL;
>> +}
>> +static inline
>> +struct rproc *rproc_get_by_phandle(phandle phandle)
>> +{
>> +	return NULL;
>> +}
>> +#endif /* CONFIG_OF */
>> +
>>  #endif /* REMOTEPROC_H */
>> -- 
>> 2.9.0
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
