From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 1 Dec 2015 11:56:42 +0200
Subject: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
In-Reply-To: <CAHp75VeTe6hcnuqHNv=GX8pZJmde0H-AjZpxMHq=f5YfOL5hSA@mail.gmail.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VeTe6hcnuqHNv=GX8pZJmde0H-AjZpxMHq=f5YfOL5hSA@mail.gmail.com>
Message-ID: <565D6EDA.4070002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 04:51 PM, Andy Shevchenko wrote:
>> +struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>> +{
>> +       struct dma_device *device, *_d;
>> +       struct dma_chan *chan = NULL;
>> +
>> +       /* If device-tree is present get slave info from here */
>> +       if (dev->of_node)
>> +               chan = of_dma_request_slave_channel(dev->of_node, name);
>> +
>> +       /* If device was enumerated by ACPI get slave info from here */
>> +       if (ACPI_HANDLE(dev) && !chan)
> 
> The preferable way is to use
> has_acpi_companion() instead of ACPI_HANDLE().

I have done this part based on the dma_request_slave_channel_reason().
Will switch to use the has_acpi_companion() for the next RFC.

>> +               chan = acpi_dma_request_slave_chan_by_name(dev, name);
>> +
>> +       if (chan)
>> +               return chan;
>> +

-- 
P?ter
