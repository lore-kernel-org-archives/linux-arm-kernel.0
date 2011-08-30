From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 30 Aug 2011 18:39:17 +0530
Subject: [PATCH 4/6] DMA: PL330: Add device tree support
In-Reply-To: <4E579C9B.7030807@gmail.com>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-2-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-3-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-4-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-5-git-send-email-thomas.abraham@linaro.org>
	<4E579C9B.7030807@gmail.com>
Message-ID: <CAJuYYwRGaeTnXh=7RCK4RCkRyFXTCzcRiXUJQ+yjRD_BAUzyYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 26 August 2011 18:46, Rob Herring <robherring2@gmail.com> wrote:
> Thomas,
>
> On 08/26/2011 03:40 AM, Thomas Abraham wrote:
>> For PL330 dma controllers instantiated from device tree, the channel
>> lookup is based on phandle of the dma controller and dma request id
>> specified by the client node. During probe, the private data of each
>> channel of the controller is set to point to the device node of the
>> dma controller. The 'chan_id' of the each channel is used as the
>> dma request id.
>>
>> Client driver requesting dma channels specify the phandle of the
>> dma controller and the request id. The pl330 filter function
>> converts the phandle to the device node pointer and matches that
>> with channel's private data. If a match is found, the request id
>> from the client node and the 'chan_id' of the channel is matched.
>> A channel is found if both the values match.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?.../devicetree/bindings/dma/arm-pl330.txt ? ? ? ? ?| ? 42 +++++++++++++
>> ?drivers/dma/pl330.c ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 63 +++++++++++++++++++-
>> ?2 files changed, 103 insertions(+), 2 deletions(-)
>> ?create mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
>> new file mode 100644
>> index 0000000..46a8307
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
>> @@ -0,0 +1,42 @@
>> +* ARM PrimeCell PL330 DMA Controller
>> +
>> +The ARM PrimeCell PL330 DMA controller can move blocks of memory contents
>> +between memory and peripherals or memory to memory.
>> +
>> +Required properties:
>> + ?- compatible: should one or more of the following
>> + ? ?- arm,pl330-pdma - For controllers that support mem-to-dev and dev-to-mem
>> + ? ? ?transfers.
>> + ? ?- arm,pl330-mdma - For controllers that support mem-to-mem transfers only.
>
> And if they support both? I would think all controllers can support
> mem-to-mem. If so, the distinction can be made with the number of requests.

If a controller supports both types of transfer, the device node
should not claim compatibility for "arm,pl330-pdma" or
"arm,pl330-mdma". Compatible should be "arm,primecell".

>
>> + ? ?- arm,primecell - should be included for all pl330 dma controller nodes.
>> +
>> + ?- reg: physical base address of the controller and length of memory mapped
>> + ? ?region.
>> +
>> + ?- interrupts: interrupt number to the cpu.
>> +
>> + ?- arm,primecell-periphid: should be 0x00041330.
>
> Should be optional. It's only needed when the h/w value is wrong. This
> is already documented in primecell.txt.

Ok. This will be made optional.

>
>> +
>> + ?- arm,pl330-peri-reqs: number of actual peripheral requests connected to the
>> + ? ?dma controller. Maximum value is 32.
>
> Perhaps could be a bitmask for sparsely populated requests. May not
> matter since phandles will define the connections.
>
> Can be optional and not present means 00 requests (mem-to-mem only).

As suggested by Russell, this property will be removed and its value
will be read from the configuration register.

>
>> +
>> +Example: (from Samsung's Exynos4 processor dtsi file)
>> +
>> + ? ? pdma0: pdma at 12680000 {
>> + ? ? ? ? ? ? compatible = "arm,pl330-pdma", "arm,primecell";
>> + ? ? ? ? ? ? reg = <0x12680000 0x1000>;
>> + ? ? ? ? ? ? interrupts = <99>;
>> + ? ? ? ? ? ? arm,primecell-periphid = <0x00041330>;
>> + ? ? ? ? ? ? arm,pl330-peri-reqs = <30>;
>> + ? ? };
>> +
>> +Client drivers (device nodes requiring dma transfers from dev-to-mem or
>> +mem-to-dev) should specify the DMA channel numbers using a two-value pair
>> +as shown below.
>> +
>> + ?[property name] ?= <[phandle of the dma controller] [dma request id]>;
>> +
>> + ? ? ?where 'dma request id' is the dma request number which is connected
>> + ? ? ?to the client controller.
>> +
>> + ?Example: ?tx-dma-channel = <&pdma0 12>;
>
> I like this approach. I looked at this some and some PPC platforms do a
> node for each channel/request, but this is much more simple and similar
> to clock binding approach.
>
> You need to define the property name. Probably just "dma-channel" is
> enough. For peripherals with more than 1, just list them out like when
> you have more than 1 interrupt. The order should be defined as part of
> that device's binding (i.e. 1st channel is tx and 2nd channel is rx).

I am little hesitant to do this the way you suggested. A controller
could have dma request lines connected to multiple dma controllers. So
the phandle could be different for each dma channel. Also, the client
drivers specify the property value for each dma channel requested (the
property value gets assigned to chan->private and then used by the
filter function to lookup the dma channel). So changing it the way you
have suggested would make things complex.

>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 9732995..984dc18 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -19,6 +19,7 @@
>> ?#include <linux/amba/pl330.h>
>> ?#include <linux/pm_runtime.h>
>> ?#include <linux/scatterlist.h>
>> +#include <linux/of.h>
>>
>> ?#define NR_DEFAULT_DESC ? ? ?16
>>
>> @@ -277,6 +278,20 @@ bool pl330_filter(struct dma_chan *chan, void *param)
>> ? ? ? if (chan->device->dev->driver != &pl330_driver.drv)
>> ? ? ? ? ? ? ? return false;
>>
>> +#ifdef CONFIG_OF
>> + ? ? if (chan->device->dev->of_node) {
>> + ? ? ? ? ? ? const __be32 *prop_value;
>> + ? ? ? ? ? ? phandle phandle;
>> + ? ? ? ? ? ? struct device_node *node;
>> +
>> + ? ? ? ? ? ? prop_value = ((struct property *)param)->value;
>> + ? ? ? ? ? ? phandle = be32_to_cpup(prop_value++);
>> + ? ? ? ? ? ? node = of_find_node_by_phandle(phandle);
>> + ? ? ? ? ? ? return ((chan->private == node) &&
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? (chan->chan_id == be32_to_cpup(prop_value)));
>> + ? ? }
>> +#endif
>> +
>> ? ? ? peri_id = chan->private;
>> ? ? ? return *peri_id == (unsigned)param;
>> ?}
>> @@ -777,6 +792,40 @@ static irqreturn_t pl330_irq_handler(int irq, void *data)
>> ? ? ? ? ? ? ? return IRQ_NONE;
>> ?}
>>
>> +#ifdef CONFIG_OF
>> +static struct dma_pl330_platdata *pl330_parse_dt(struct device *dev)
>> +{
>> + ? ? struct dma_pl330_platdata *pdat;
>> + ? ? const void *value;
>> +
>> + ? ? pdat = devm_kzalloc(dev, sizeof(*pdat), GFP_KERNEL);
>> + ? ? if (!pdat)
>> + ? ? ? ? ? ? return NULL;
>
> Ideally, we will get rid of platform_data completely in the future, so I
> don't think filling it in from DT is the right approach.

Ok. I will drop the usage of platform data.

>
>> +
>> + ? ? value = of_get_property(dev->of_node, "arm,pl330-peri-reqs", NULL);
>> + ? ? if (value)
>> + ? ? ? ? ? ? pdat->nr_valid_peri = be32_to_cpup(value);
>
> Can't you use the u32 helper function here?

This will go away now since the number of peripherals connected will
be read from the configuration register.

>
>> +
>> + ? ? if (of_device_is_compatible(dev->of_node, "arm,pl330-pdma")) {
>> + ? ? ? ? ? ? dma_cap_set(DMA_SLAVE, pdat->cap_mask);
>> + ? ? ? ? ? ? dma_cap_set(DMA_CYCLIC, pdat->cap_mask);
>> + ? ? } else if (of_device_is_compatible(dev->of_node, "arm,pl330-mdma")) {
>> + ? ? ? ? ? ? dma_cap_set(DMA_MEMCPY, pdat->cap_mask);
>> + ? ? } else if (of_device_is_compatible(dev->of_node, "arm,primecell")) {
>
> I don't think the driver should look at this property. This is really
> just for the bus code.

The dma capabilities are derived from the compatible value by the
driver. Sorry, I do not understand your suggestion for this.

Thanks for your help.

Regards,
Thomas.

>
> Rob
>
>> + ? ? ? ? ? ? dma_cap_set(DMA_SLAVE, pdat->cap_mask);
>> + ? ? ? ? ? ? dma_cap_set(DMA_CYCLIC, pdat->cap_mask);
>> + ? ? ? ? ? ? dma_cap_set(DMA_MEMCPY, pdat->cap_mask);
>> + ? ? }
>> +
>> + ? ? return pdat;
>> +}
>> +#else
>> +static struct dma_pl330_platdata *pl330_parse_dt(struct device *dev)
>> +{
>> + ? ? return NULL;
>> +}
>> +#endif
>> +
>> ?static int __devinit
>> ?pl330_probe(struct amba_device *adev, const struct amba_id *id)
>> ?{
>> @@ -789,7 +838,13 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>> ? ? ? int i, ret, irq;
>> ? ? ? int num_chan;
>>
>> - ? ? pdat = adev->dev.platform_data;
>> + ? ? if (adev->dev.of_node) {
>> + ? ? ? ? ? ? pdat = pl330_parse_dt(&adev->dev);
>> + ? ? ? ? ? ? if (!pdat)
>> + ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
>> + ? ? } else {
>> + ? ? ? ? ? ? pdat = adev->dev.platform_data;
>> + ? ? }
>>
>> ? ? ? /* Allocate a new DMAC and its Channels */
>> ? ? ? pdmac = kzalloc(sizeof(*pdmac), GFP_KERNEL);
>> @@ -862,7 +917,11 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>>
>> ? ? ? for (i = 0; i < num_chan; i++) {
>> ? ? ? ? ? ? ? pch = &pdmac->peripherals[i];
>> - ? ? ? ? ? ? pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
>> + ? ? ? ? ? ? if (!adev->dev.of_node)
>> + ? ? ? ? ? ? ? ? ? ? pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? pch->chan.private = adev->dev.of_node;
>> +
>> ? ? ? ? ? ? ? INIT_LIST_HEAD(&pch->work_list);
>> ? ? ? ? ? ? ? spin_lock_init(&pch->lock);
>> ? ? ? ? ? ? ? pch->pl330_chid = NULL;
>
>
