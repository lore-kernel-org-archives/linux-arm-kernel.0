From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Nov 2013 17:05:33 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <CAPcyv4iL8LSXfpfAugCAVK11A5fvJ4kYZXneNC6V5HZeTRY+4g@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>	<1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4iL8LSXfpfAugCAVK11A5fvJ4kYZXneNC6V5HZeTRY+4g@mail.gmail.com>
Message-ID: <528FF14D.1020702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2013 04:50 PM, Dan Williams wrote:
> A question about the patch:
> 
> On Fri, Nov 15, 2013 at 12:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
> [..]
>> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
>> index 0b88dd3d05f4..928141f6f21b 100644
>> --- a/drivers/dma/of-dma.c
>> +++ b/drivers/dma/of-dma.c
>> @@ -181,11 +181,13 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>>
>>                 of_node_put(dma_spec.np);
>>
>> +               if (!ofdma && defer)
>> +                       return ERR_PTR(-EPROBE_DEFER);
>>                 if (chan)
>>                         return chan;
>>         }
> 
> Why do we need to make this conditional on the value of 'defer'?  If
> the client cares it will propagate the error if it does not care then
> nothing is gained by converting this to -ENODEV.

The function ends up being called from two code-paths. One of which
wants the new behaviour of deferring probe if a valid DMA specifier is
found but there's not registered driver for it, and the other
(compatibility) path wants exactly the old behaviour. The flag is passed
down from dma_request_slave_channel() (old behaviour) or
dma_request_slave_channel_or_err() (new behaviour).
