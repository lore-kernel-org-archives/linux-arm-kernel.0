From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 3 Dec 2015 17:42:31 +0200
Subject: [PATCH 3/4] dmaengine: core: Introduce new, universal API to
 request a channel
In-Reply-To: <6922343.04ZpTXZq7O@wuerfel>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com>
 <1449153192-9082-4-git-send-email-peter.ujfalusi@ti.com>
 <6922343.04ZpTXZq7O@wuerfel>
Message-ID: <566062E7.2020705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2015 05:32 PM, Arnd Bergmann wrote:
> On Thursday 03 December 2015 16:33:11 Peter Ujfalusi wrote:
>> +
>> +/**
>> + * dma_request_chan - try to allocate an exclusive slave channel
>> + * @dev:       pointer to client device structure
>> + * @name:      slave channel name
>> + *
>> + * Returns pointer to appropriate DMA channel on success or an error pointer.
>> + */
>> +struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>> +{
>> +       struct dma_device *d, *_d;
>> +       struct dma_chan *chan = NULL;
>> +
>> +       /* If device-tree is present get slave info from here */
>> +       if (dev->of_node)
>> +               chan = of_dma_request_slave_channel(dev->of_node, name);
>> +
>> +       /* If device was enumerated by ACPI get slave info from here */
>> +       if (has_acpi_companion(dev) && !chan)
>> +               chan = acpi_dma_request_slave_chan_by_name(dev, name);
> 
> I just noticed that you are creating this as a new interface, rather than
> changing dma_request_slave_channel_reason() and making the old interface
> a static inline wrapper. What is the reasoning behind that?

Oh, it was in my plans. Will do it for v02

> I think if we make both interfaces do the same thing, it's easier
> to do the migration.
> 
>> +       if (chan) {
>> +               /* Valid channel found */
>> +               if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
>> +                       return chan;
>> +
>> +               pr_warn("%s: %s DMA request failed, falling back to legacy\n",
>> +                       __func__, dev->of_node ? "OF" : "ACPI");
>> +       }
> 
> Maybe print the error code as well?

Or remove the print altogether?
In a healthy system we will either get the channel or the EPROBE_DEFER, in
case of the platforms where the DT lookup does not work we expect errors and
it is 'normal'.
I think if we fail via DT/ACPI and we fail with legacy also then the client
driver will say something about it anyways, or deal with it as it see fits.

-- 
P?ter
