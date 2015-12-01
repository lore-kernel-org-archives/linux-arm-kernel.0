From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 1 Dec 2015 11:58:53 +0200
Subject: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter
 mapping to slave devices
In-Reply-To: <7490116.jHcmUxB3Rf@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
 <7490116.jHcmUxB3Rf@wuerfel>
Message-ID: <565D6F5D.3060603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 04:11 PM, Arnd Bergmann wrote:
> On Monday 30 November 2015 15:45:34 Peter Ujfalusi wrote:
>> @@ -2428,6 +2436,22 @@ bool edma_filter_fn(struct dma_chan *chan, void *param)
>>  }
>>  EXPORT_SYMBOL(edma_filter_fn);
>>  
>> +static bool edma_filter_for_map(struct dma_chan *chan, void *param)
>> +{
>> +       bool match = false;
>> +
>> +       if (chan->device->dev->driver == &edma_driver.driver) {
>> +               struct edma_chan *echan = to_edma_chan(chan);
>> +               unsigned ch_req = (unsigned)param;
>> +               if (ch_req == echan->ch_num) {
>> +                       /* The channel is going to be used as HW synchronized */
>> +                       echan->hw_triggered = true;
>> +                       match = true;
>> +               }
>> +       }
>> +       return match;
>> +}
>> +
>>  static int edma_init(void)
>>
> 
> I don't see the difference between edma_filter_fn and edma_filter_for_map.
> Why do you need both?

edma_filter_fn:
	unsigned ch_req = *(unsigned *)param;

edma_filter_for_map:
	unsigned ch_req = (unsigned)param;


If I want to reuse the edma_filter_fn, I would need an unsigned array for the
eDMA event numbers in the board files to be able to provide the pointer to
each of them.

-- 
P?ter
