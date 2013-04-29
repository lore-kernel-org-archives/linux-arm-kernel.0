From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 29 Apr 2013 15:28:41 +0200
Subject: [PATCH v3 1/6] at_hdmac: move to generic DMA binding
In-Reply-To: <20130423034407.GY24632@intel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
 <1366362683-14496-2-git-send-email-ludovic.desroches@atmel.com>
 <51750F68.4040701@atmel.com> <20130423034407.GY24632@intel.com>
Message-ID: <517E7589.5030205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2013 05:44 AM, Vinod Koul :
> On Mon, Apr 22, 2013 at 12:22:32PM +0200, Nicolas Ferre wrote:
>> On 04/19/2013 11:11 AM, ludovic.desroches at atmel.com :
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
>>> +#ifdef CONFIG_OF
>>> +static bool at_dma_filter(struct dma_chan *chan, void *slave)
> this is not defined for else case here. Also this could be CONFIG_DMA_OF...?

in fact, at_dma_filter() is only used in corresponding
dma_request_channel() in at_dma_xlate() function just below and only in
case of CONFIG_OF.
As the at_dma_xlate() is an empty function in !CONFIG_OF case, the
at_dma_filter() is not needed.

For the use of CONFIG_OF and not CONFIG_OF_DMA, it is simply because it
it the directive that we currently use in drivers when we have to put
the device tree condition around a piece of code. It is quite a common
pattern I think.
Moreover, it is what is used in dw_dmac.c and mv_xor.c...

>>> +{
>>> +	struct at_dma_slave *atslave = slave;
>>> +
>>> +	if (atslave->dma_dev == chan->device->dev) {
>>> +		chan->private = atslave;
>>> +		return true;
>>> +	} else {
>>> +		return false;
>>> +	}
>>> +}
> 
> --
> ~Vinod

Best regards,
-- 
Nicolas Ferre
