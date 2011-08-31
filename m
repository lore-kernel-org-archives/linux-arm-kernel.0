From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Aug 2011 07:51:02 -0500
Subject: [PATCH 4/6] DMA: PL330: Add device tree support
In-Reply-To: <CAJuYYwT5HGy9b06AyrLJv5hFCFf_YRA4md9N=m+cwcJNTqRDWg@mail.gmail.com>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>	<1314348014-2481-2-git-send-email-thomas.abraham@linaro.org>	<1314348014-2481-3-git-send-email-thomas.abraham@linaro.org>	<1314348014-2481-4-git-send-email-thomas.abraham@linaro.org>	<1314348014-2481-5-git-send-email-thomas.abraham@linaro.org>	<4E579C9B.7030807@gmail.com>	<CAJuYYwR5GqqKjbMngQqorLuka4XN0jin5s6O66orTtSQg5eKRw@mail.gmail.com>	<4E5CE37E.1050104@gmail.com>
	<CAJuYYwT5HGy9b06AyrLJv5hFCFf_YRA4md9N=m+cwcJNTqRDWg@mail.gmail.com>
Message-ID: <4E5E2E36.1070006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On 08/31/2011 01:46 AM, Thomas Abraham wrote:
> Hi Rob,
> 
> On 30 August 2011 18:49, Rob Herring <robherring2@gmail.com> wrote:
>> Thomas,
>>
>> On 08/30/2011 07:18 AM, Thomas Abraham wrote:
>>> Hi Rob,
>>>
>>> On 26 August 2011 18:46, Rob Herring <robherring2@gmail.com
>>> <mailto:robherring2@gmail.com>> wrote:
>>>
>>>     Thomas,
>>>
>>>     On 08/26/2011 03:40 AM, Thomas Abraham wrote:
>>>     > For PL330 dma controllers instantiated from device tree, the channel
>>>     > lookup is based on phandle of the dma controller and dma request id
>>>     > specified by the client node. During probe, the private data of each
>>>     > channel of the controller is set to point to the device node of the
>>>     > dma controller. The 'chan_id' of the each channel is used as the
>>>     > dma request id.
>>>     >
>>>     > Client driver requesting dma channels specify the phandle of the
>>>     > dma controller and the request id. The pl330 filter function
>>>     > converts the phandle to the device node pointer and matches that
>>>     > with channel's private data. If a match is found, the request id
>>>     > from the client node and the 'chan_id' of the channel is matched.
>>>     > A channel is found if both the values match.
>>>     >
>>>     > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org
>>>     <mailto:thomas.abraham@linaro.org>>
>>>     > ---
>>>     >  .../devicetree/bindings/dma/arm-pl330.txt          |   42
>>>     +++++++++++++
>>>     >  drivers/dma/pl330.c                                |   63
>>>     +++++++++++++++++++-
>>>     >  2 files changed, 103 insertions(+), 2 deletions(-)
>>>     >  create mode 100644
>>>     Documentation/devicetree/bindings/dma/arm-pl330.txt
>>>     >
>>>     > diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt
>>>     b/Documentation/devicetree/bindings/dma/arm-pl330.txt
>>>     > new file mode 100644
>>>     > index 0000000..46a8307
>>>     > --- /dev/null
>>>     > +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
>>>     > @@ -0,0 +1,42 @@
>>>     > +* ARM PrimeCell PL330 DMA Controller
>>>     > +
>>>     > +The ARM PrimeCell PL330 DMA controller can move blocks of memory
>>>     contents
>>>     > +between memory and peripherals or memory to memory.
>>>     > +
>>>     > +Required properties:
>>>     > +  - compatible: should one or more of the following
>>>     > +    - arm,pl330-pdma - For controllers that support mem-to-dev
>>>     and dev-to-mem
>>>     > +      transfers.
>>>     > +    - arm,pl330-mdma - For controllers that support mem-to-mem
>>>     transfers only.
>>>
>>>     And if they support both? I would think all controllers can support
>>>     mem-to-mem. If so, the distinction can be made with the number of
>>>     requests.
>>>
>>>
>>> If a controller supports both types of transfer, the device node should
>>> not claim compatibility for "arm,pl330-pdma" or "arm,pl330-mdma".
>>> Compatible should be "arm,primecell".
>>
>> No, every Primecell peripheral has "arm,primecell", so it is not
>> specific enough for a driver to use.
>>
>> Is there a case that a controller with peripheral requests cannot
>> support mem-to-mem transfers? I don't think there is. You could decide
>> you don't want to for other reasons like you don't have enough free
>> channels, but that's really a s/w decision, not a h/w description.
> 
> Ok. The driver has now been changed in a way that DMA_MEMCPY
> capability is assigned by default to a pl330 dma controller. The
> DMA_SLAVE and DMA_CYCLIC capability are assigned if the controller
> supports peripheral request interface. For mem-to-mem transfer channel
> requests, the filter function specified for the request should check
> for the right match.
> 
>>
>>>
>>>
>>>     > +    - arm,primecell - should be included for all pl330 dma
>>>     controller nodes.
>>>     > +
>>>     > +  - reg: physical base address of the controller and length of
>>>     memory mapped
>>>     > +    region.
>>>     > +
>>>     > +  - interrupts: interrupt number to the cpu.
>>>     > +
>>>     > +  - arm,primecell-periphid: should be 0x00041330.
>>>
>>>     Should be optional. It's only needed when the h/w value is wrong. This
>>>     is already documented in primecell.txt.
>>>
>>>
>>> Ok. This will be made optional.
>>>
>>>
>>>
>>>     > +
>>>     > +  - arm,pl330-peri-reqs: number of actual peripheral requests
>>>     connected to the
>>>     > +    dma controller. Maximum value is 32.
>>>
>>>     Perhaps could be a bitmask for sparsely populated requests. May not
>>>     matter since phandles will define the connections.
>>>
>>>     Can be optional and not present means 00 requests (mem-to-mem only).
>>>
>>>
>>> As suggested by Russell, this property will be removed and its value
>>> will be read from the configuration register.
>>>
>>
>> Good. Reading a value of 0 requests can still be used to determine the
>> controller is mem-to-mem only.
>>
>>>
>>>     > +
>>>     > +Example: (from Samsung's Exynos4 processor dtsi file)
>>>     > +
>>>     > +     pdma0: pdma at 12680000 {
>>>     > +             compatible = "arm,pl330-pdma", "arm,primecell";
>>>     > +             reg = <0x12680000 0x1000>;
>>>     > +             interrupts = <99>;
>>>     > +             arm,primecell-periphid = <0x00041330>;
>>>     > +             arm,pl330-peri-reqs = <30>;
>>>     > +     };
>>>     > +
>>>     > +Client drivers (device nodes requiring dma transfers from
>>>     dev-to-mem or
>>>     > +mem-to-dev) should specify the DMA channel numbers using a
>>>     two-value pair
>>>     > +as shown below.
>>>     > +
>>>     > +  [property name]  = <[phandle of the dma controller] [dma
>>>     request id]>;
>>>     > +
>>>     > +      where 'dma request id' is the dma request number which is
>>>     connected
>>>     > +      to the client controller.
>>>     > +
>>>     > +  Example:  tx-dma-channel = <&pdma0 12>;
>>>
>>>     I like this approach. I looked at this some and some PPC platforms do a
>>>     node for each channel/request, but this is much more simple and similar
>>>     to clock binding approach.
>>>
>>>     You need to define the property name. Probably just "dma-channel" is
>>>     enough. For peripherals with more than 1, just list them out like when
>>>     you have more than 1 interrupt. The order should be defined as part of
>>>     that device's binding (i.e. 1st channel is tx and 2nd channel is rx).
>>>
>>>
>>> I am little hesitant to do this the way you suggested. A controller
>>> could have dma request lines connected to multiple dma controllers. So
>>> the phandle could be different for each dma channel. Also, the client
>>> drivers specify the property value for each dma channel requested (the
>>> property value gets assigned to chan->private and then used by the
>>> filter function to lookup the dma channel). So changing it the way you
>>> have suggested would make things complex.
>>>
>>
>> Perhaps you could make private point to the array entry rather than the
>> property.
>>
>> But I don't have s strong opinion either way.
> 
> There could be cases where tx could be polled and rx uses dma transfer
> and such this could vary across platforms. This would make parsing the
> property value a little complex and so I still perfer to use property
> for each dma channel required in the client device nodes.
> 
>>
>>>
>>>     > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>>>     > index 9732995..984dc18 100644
>>>     > --- a/drivers/dma/pl330.c
>>>     > +++ b/drivers/dma/pl330.c
>>>     > @@ -19,6 +19,7 @@
>>>     >  #include <linux/amba/pl330.h>
>>>     >  #include <linux/pm_runtime.h>
>>>     >  #include <linux/scatterlist.h>
>>>     > +#include <linux/of.h>
>>>     >
>>>     >  #define NR_DEFAULT_DESC      16
>>>     >
>>>     > @@ -277,6 +278,20 @@ bool pl330_filter(struct dma_chan *chan, void
>>>     *param)
>>>     >       if (chan->device->dev->driver != &pl330_driver.drv)
>>>     >               return false;
>>>     >
>>>     > +#ifdef CONFIG_OF
>>>     > +     if (chan->device->dev->of_node) {
>>>     > +             const __be32 *prop_value;
>>>     > +             phandle phandle;
>>>     > +             struct device_node *node;
>>>     > +
>>>     > +             prop_value = ((struct property *)param)->value;
>>>     > +             phandle = be32_to_cpup(prop_value++);
>>>     > +             node = of_find_node_by_phandle(phandle);
>>>     > +             return ((chan->private == node) &&
>>>     > +                             (chan->chan_id ==
>>>     be32_to_cpup(prop_value)));
>>>     > +     }
>>>     > +#endif
>>>     > +
>>>     >       peri_id = chan->private;
>>>     >       return *peri_id == (unsigned)param;
>>>     >  }
>>>     > @@ -777,6 +792,40 @@ static irqreturn_t pl330_irq_handler(int irq,
>>>     void *data)
>>>     >               return IRQ_NONE;
>>>     >  }
>>>     >
>>>     > +#ifdef CONFIG_OF
>>>     > +static struct dma_pl330_platdata *pl330_parse_dt(struct device *dev)
>>>     > +{
>>>     > +     struct dma_pl330_platdata *pdat;
>>>     > +     const void *value;
>>>     > +
>>>     > +     pdat = devm_kzalloc(dev, sizeof(*pdat), GFP_KERNEL);
>>>     > +     if (!pdat)
>>>     > +             return NULL;
>>>
>>>     Ideally, we will get rid of platform_data completely in the future, so I
>>>     don't think filling it in from DT is the right approach.
>>>
>>>
>>> Ok. I will drop the usage of platform data.
>>>
>>>
>>>     > +
>>>     > +     value = of_get_property(dev->of_node, "arm,pl330-peri-reqs",
>>>     NULL);
>>>     > +     if (value)
>>>     > +             pdat->nr_valid_peri = be32_to_cpup(value);
>>>
>>>     Can't you use the u32 helper function here?
>>>
>>>
>>> This will go away now since the number of peripherals connected will be
>>> read from the configuration register.
>>>
>>>
>>>     > +
>>>     > +     if (of_device_is_compatible(dev->of_node, "arm,pl330-pdma")) {
>>>     > +             dma_cap_set(DMA_SLAVE, pdat->cap_mask);
>>>     > +             dma_cap_set(DMA_CYCLIC, pdat->cap_mask);
>>>     > +     } else if (of_device_is_compatible(dev->of_node,
>>>     "arm,pl330-mdma")) {
>>>     > +             dma_cap_set(DMA_MEMCPY, pdat->cap_mask);
>>>     > +     } else if (of_device_is_compatible(dev->of_node,
>>>     "arm,primecell")) {
>>>
>>>     I don't think the driver should look at this property. This is really
>>>     just for the bus code.
>>>
>>>
>>> The dma capabilities are derived from the compatible value by the
>>> driver. Sorry, I do not understand your suggestion for this.
>>>
>>
>> "arm,primecell" is purely for identifying peripherals with the Primecell
>> ID registers and in turn used to create amba_device instances. You
>> cannot imply that it is a DMA controller.
> 
> This has been changed as you suggested. Could you have a look at the
> updated patch listed below?
> 
> 
> For PL330 dma controllers instantiated from device tree, the channel
> lookup is based on phandle of the dma controller and dma request id
> specified by the client node. During probe, the private data of each
> channel of the controller is set to point to the device node of the
> dma controller. The 'chan_id' of the each channel is used as the
> dma request id.
> 
> Client driver requesting dma channels specify the phandle of the
> dma controller and the request id. The pl330 filter function
> converts the phandle to the device node pointer and matches that
> with channel's private data. If a match is found, the request id
> from the client node and the 'chan_id' of the channel is matched.
> A channel is found if both the values match.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  .../devicetree/bindings/dma/arm-pl330.txt          |   29 ++++++++++++++++
>  drivers/dma/pl330.c                                |   35 +++++++++++++++++---
>  2 files changed, 59 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt
> b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> new file mode 100644
> index 0000000..89f4b9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> @@ -0,0 +1,29 @@
> +* ARM PrimeCell PL330 DMA Controller
> +
> +The ARM PrimeCell PL330 DMA controller can move blocks of memory contents
> +between memory and peripherals or memory to memory.
> +
> +Required properties:
> +  - compatible: should be "arm,primecell".

Sorry, I guess I wasn't clear. This has to be "arm,primecell" plus
something else. In this case, "arm,pl330". If the IP is modified from
standard ARM version (like ST likes to do), then something like
"samsung,pl330" would be appropriate.

This is not actually used by the kernel at the moment, but could if
modified versions of pl330 show up.

> +  - reg: physical base address of the controller and length of memory mapped
> +    region.
> +  - interrupts: interrupt number to the cpu.
> +
> +Example: (from Samsung's Exynos4 processor dtsi file)
> +
> +	pdma0: pdma at 12680000 {
> +		compatible = "arm,primecell";
> +		reg = <0x12680000 0x1000>;
> +		interrupts = <99>;
> +	};
> +
> +Client drivers (device nodes requiring dma transfers from dev-to-mem or
> +mem-to-dev) should specify the DMA channel numbers using a two-value pair
> +as shown below.
> +
> +  [property name]  = <[phandle of the dma controller] [dma request id]>;

At least fix the "-dma-channel" part of the name. It not clear if that's
the case or just an example.

[name]-dma-channel = <[phandle of the dma controller] [dma request id]>;


The rest looks good.

Rob

> +
> +      where 'dma request id' is the dma request number which is connected
> +      to the client controller.
> +
> +  Example:  tx-dma-channel = <&pdma0 12>;
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 9732995..0c55de4 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -19,6 +19,7 @@
>  #include <linux/amba/pl330.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
> +#include <linux/of.h>
> 
>  #define NR_DEFAULT_DESC	16
> 
> @@ -277,6 +278,20 @@ bool pl330_filter(struct dma_chan *chan, void *param)
>  	if (chan->device->dev->driver != &pl330_driver.drv)
>  		return false;
> 
> +#ifdef CONFIG_OF
> +	if (chan->device->dev->of_node) {
> +		const __be32 *prop_value;
> +		phandle phandle;
> +		struct device_node *node;
> +
> +		prop_value = ((struct property *)param)->value;
> +		phandle = be32_to_cpup(prop_value++);
> +		node = of_find_node_by_phandle(phandle);
> +		return ((chan->private == node) &&
> +				(chan->chan_id == be32_to_cpup(prop_value)));
> +	}
> +#endif
> +
>  	peri_id = chan->private;
>  	return *peri_id == (unsigned)param;
>  }
> @@ -857,12 +872,17 @@ pl330_probe(struct amba_device *adev, const
> struct amba_id *id)
>  	INIT_LIST_HEAD(&pd->channels);
> 
>  	/* Initialize channel parameters */
> -	num_chan = max(pdat ? pdat->nr_valid_peri : 0, (u8)pi->pcfg.num_chan);
> +	num_chan = max(pdat ? pdat->nr_valid_peri : (u8)pi->pcfg.num_peri,
> +			(u8)pi->pcfg.num_chan);
>  	pdmac->peripherals = kzalloc(num_chan * sizeof(*pch), GFP_KERNEL);
> 
>  	for (i = 0; i < num_chan; i++) {
>  		pch = &pdmac->peripherals[i];
> -		pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
> +		if (!adev->dev.of_node)
> +			pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
> +		else
> +			pch->chan.private = adev->dev.of_node;
> +
>  		INIT_LIST_HEAD(&pch->work_list);
>  		spin_lock_init(&pch->lock);
>  		pch->pl330_chid = NULL;
> @@ -876,11 +896,16 @@ pl330_probe(struct amba_device *adev, const
> struct amba_id *id)
>  	}
> 
>  	pd->dev = &adev->dev;
> -	if (pdat)
> +	if (pdat) {
>  		pd->cap_mask = pdat->cap_mask;
> -	else
> +	} else {
>  		dma_cap_set(DMA_MEMCPY, pd->cap_mask);
> -
> +		if (pi->pcfg.num_peri) {
> +			dma_cap_set(DMA_SLAVE, pd->cap_mask);
> +			dma_cap_set(DMA_CYCLIC, pd->cap_mask);
> +		}	
> +	}
> +	
>  	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
>  	pd->device_free_chan_resources = pl330_free_chan_resources;
>  	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
