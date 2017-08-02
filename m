From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 2 Aug 2017 13:11:41 +0000
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <7d2091fe-a2e5-78bb-b63d-9cb66bdb7e84@ti.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
 <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
 <20170726052930.GF3053@localhost>
 <f2908e38-dc4d-3886-4058-52a7ad845415@st.com>
 <20170731123157.GJ3053@localhost>
 <e3a76a50-4160-d111-cce9-132b46b66c33@st.com>
 <20170802045522.GU3053@localhost>
 <7d2091fe-a2e5-78bb-b63d-9cb66bdb7e84@ti.com>
Message-ID: <7bcad698-fa1a-3dc2-e918-4400639ca6d7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/2017 11:19 AM, Peter Ujfalusi wrote:
> 
> 
> On 2017-08-02 07:55, Vinod Koul wrote:
>> On Tue, Aug 01, 2017 at 09:32:50AM +0000, Pierre Yves MORDRET wrote:
>>>
>>>
>>> On 07/31/2017 02:31 PM, Vinod Koul wrote:
>>>> On Wed, Jul 26, 2017 at 07:38:02AM +0000, Pierre Yves MORDRET wrote:
>>>>>>>>> +
>>>>>>>>> +#ifndef __DMA_STM32_DMAMUX_H
>>>>>>>>> +#define __DMA_STM32_DMAMUX_H
>>>>>>>>> +
>>>>>>>>> +#if defined(CONFIG_STM32_DMAMUX)
>>>>>>>>> +int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id);
>>>>>>>>
>>>>>>>> Why do we need a custom API in this case?
>>>>>>>>
>>>>>>>
>>>>>>> This API is called by DMA when a slave is requested by client. DMA can work
>>>>>>> without DMAMUX this API has been put in place to configure DMAMUX whether client
>>>>>>> is requesting a DMAMUX Channel instead of a DMA one.
>>>>>>
>>>>>> You mean the dmaengine driver right?
>>>>>>
>>>>>
>>>>> Yes. The API is mainly called by "device_config" through out STM32 DMA Driver
>>>>> when a router is in place for client.
>>>>> Please refer to Patch 4/5 on this set.
>>>>
>>>> Okay am thinking on why this can't be generic..? An optional router config
>>>> callback?
>>>>
>>>
>>> I would have liked to answer there is a callback within engine but unfortunately
>>> I didn't figure out one when I did my router's development. I've looked once
>>> more but again I can't find how to map chanID and request line without custom API.
>>
>> Yes there is no callback for routers but we can add a generic callback
>> here to be used. I added Peter for his comments, isn't that something they
>> need too?
> 
> The event router via of_dma_router_register() should be capable of 
> handling different type of muxers, like the ti-dma-crossbar.c is doing 
> for two different type of event crossbars.
> 
> Basically with the of_dma_route_allocate you craft a dma_spec which can 
> be understood by the dma-master pointed form the router's node.
> You do the configuration of the mux in this function, craft the dma_spec 
> and that's it. In DT the peripherals are using the router's node for DMA 
> binding and everything is transparent for them.
> 
> Note: The use of am335x xbar in the ti-dma-crossbar is optional and only 
> needed when we need to have different event than the default for a 
> specific dma request line.
> 
> If you normally use the DMA like this:
> dmas = <&edma 129 1>, <&ddma_xbar 128 1>;
> dma-names = "tx", "rx";
> 
> If you have DMA event router/mux, then depending on how it works you 
> might have different number of parameters. In my case the DRA7 crossbar 
> does not need extra parameter, so to get it in use:
> dmas = <&edma_xbar 129 1>, <&edma_xbar 128 1>;
> dma-names = "tx", "rx";
> 
> The router driver will rewrite the dma_spec and replace the 129/128 and 
> pass something different to the dma-master (dynamic event mapping).
> 
> On am335x we have different xbar type so there:
> 
> dmas = <&edma_xbar 12 0 1>, <&edma_xbar 13 0 2>;
> 
> Out from this the router driver will create a spec equivalent to
> dmas = <&edma_xbar 12 0>, <&edma_xbar 13 0>;
> 
> But it will change the xbar that DMA request 12/13 will not have the 
> default event routed to.
> 
> I believe that the dma_router infra we have in dmaengine can cover most 
> if not all use cases...
> 
> - P?ter
> 

Our SoC works with or without DMAMUX. Both binding is allowed. Using only DMA a
ChannelId and request line is part of the binding. Using DMAMUx now the request
line is coming from dma_spec forwards to dma-master as well explained by Peter.
However ChannelID is now given by dma_get_any_slave_channel instead of bindings.
DMAMUX driver has to be aware of this ID to route request line to out DMA
channel. This channel id information is carried on until DMAMUX through
dmaengine_slave_config with a custom API.
Hope it clarifies the need.
