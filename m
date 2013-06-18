From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 18 Jun 2013 22:22:17 +0800
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <201306181609.14966.arnd@arndb.de>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306172258.08185.arnd@arndb.de>
 <CAMj5Bkh8=zc=RYoS9T_9ORYFuJeswQP2hfZ5GH_vywa_qM2DRA@mail.gmail.com>
 <201306181609.14966.arnd@arndb.de>
Message-ID: <51C06D19.3020304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-18 10:09 PM, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, zhangfei gao wrote:
>> On Tue, Jun 18, 2013 at 4:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>>> +static struct of_dma_filter_info k3_dma_filter;
>>>> +static bool k3_dma_filter_fn(struct dma_chan *chan, void *param)
>>>> +{
>>>> +     return  (*(int *)param == chan->chan_id);
>>>> +}
>>>
>>> This filter function works only as long as there is no more than
>>> one DMA engine in the system, which is something that needs to
>>> be documented better. Unfortunately, providing a filter
>>> function to be called by .xlate is currently the only way that
>>> the dma-engine API supports, but we should really get over that.
>>>
>>> Vinod: I think we need to add a way for a dmaengine driver to
>>> just return one of its channels to the xlate function. The
>>> current method is getting very silly, and it adds run-time and
>>> code complexity without any need.
>>>
>>> How about something like
>>>
>>> int dma_get_slave_channel(struct dma_chan *chan)
>>> {
>>>          /* lock against __dma_request_channel */
>>>          mutex_lock(&dma_list_mutex);
>>>
>>>          if (chan->client_count == 0)
>>>                  ret = dma_chan_get(chan);
>>>          else
>>>                  ret = -EBUSY;
>>>
>>>          mutex_unlock(&dma_list_mutex);
>>>
>>>          return ret;
>>> }
>>> EXPORT_SYMBOL_GPL(dma_get_slave_channel);
>>
>> Want to double check here.
>> Device need specific channel via request line, the requirement still
>> can be met, right?
>
> The driver can have a simple array of pointers that is indexed by
> the request number, so you end up with something like
>
> struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>                                                  struct of_dma *ofdma)
> {
>          struct k3_dma_dev *dev = ofdma->of_dma_data;
> 	unsigned int vchan = dma_spec->args[0];
>
> 	if (vchan > dev->nr_channels)
> 		return NULL;
>
>          return dma_get_slave_channel(dev->vchan[vchan]);
> }
>
> With no need to have a filter function.

Cool, then I would like to wait for the patch.
