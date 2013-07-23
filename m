From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 23 Jul 2013 08:41:40 +0200
Subject: [PATCH 1/3] dmaengine: add dma_get_slave_sg_limits()
In-Reply-To: <51EDA80F.7060606@ti.com>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
 <1374166001-31340-2-git-send-email-joelf@ti.com>
 <20130718161658.GW16653@intel.com> <51EDA80F.7060606@ti.com>
Message-ID: <51EE25A4.7000609@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 11:45 PM, Joel Fernandes wrote:
> On 07/18/2013 11:16 AM, Vinod Koul wrote:> On Thu, Jul 18, 2013 at
> 11:46:39AM -0500, Joel Fernandes wrote:
>>> From: Matt Porter <mporter@ti.com>
>>>
>>> Add a dmaengine API to retrieve slave SG transfer limits.
>>>
>>> The API is optionally implemented by dmaengine drivers and when
>>> unimplemented will return a NULL pointer. A client driver using
>>> this API provides the required dma channel, address width, and
>>> burst size of the transfer. dma_get_slave_sg_limits() returns an
>>> SG limits structure with the maximum number and size of SG segments
>>> that the given channel can handle.
>> Hi Joel,
>>
>> I have already resurrected this and generalized the API to get the slave
>> capablities.
>> https://lkml.org/lkml/2013/7/15/147
>
> Hi Vinod,
>
> get_caps and get_sg_limits are 2 different things, looks like this was
> already discussed earlier, and this patch series is a separate API that
> adds support for SG limits.
>
> Infact, you can already see here that he changed the name of the
> function from caps to dma_get_slave_sg_limits:
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2013-March/026601.html
>

And it was changed back, since we need to provide more information than just 
the sg limits. So the name didn't fit anymore. The dma_get_slave_caps() API 
patch was based on the dma_get_slave_sg_limits() patch.

> Considering this, what is the way forward? Can this patch series be
> merged as it is a different API as discussed above?
>
> Summarizing:
> * get_caps API cannot be used for this same purpose, as get_caps is done
> _before_ the DMA channel can be configured from what it looks like:
> * get_sg_limits, on the other hand is supposed to already have the
> parameters required for configuring the DMA channel before hand.
>
> Are there any other changes to the get_sg_limits series you would like
> before it can be applied? Any other suggestions?

If you need to calculate the limit based on a certain configuration I'd suggest 
to add a optional dma_slave_config parameter to the dma_slave_get_caps() function.

- Lars
