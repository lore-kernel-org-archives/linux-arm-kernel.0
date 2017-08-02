From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 2 Aug 2017 16:28:40 +0200
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <47ceba83-1097-072e-bed6-d1964bce7a25@ti.com>
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
 <7bcad698-fa1a-3dc2-e918-4400639ca6d7@st.com>
 <47ceba83-1097-072e-bed6-d1964bce7a25@ti.com>
Message-ID: <0e16a519-3d60-f683-5517-12a520e0e521@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/2017 04:09 PM, Peter Ujfalusi wrote:
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> On 2017-08-02 16:11, Pierre Yves MORDRET wrote:
>> Our SoC works with or without DMAMUX. Both binding is allowed. Using only DMA a
>> ChannelId and request line is part of the binding.
> 
> In our case the am335x's eDMA can work with or without the router, we 
> only use the router node if we need none default event for a given DMA 
> request line.
> 
>> Using DMAMUx now the request
>> line is coming from dma_spec forwards to dma-master as well explained by Peter.
>> However ChannelID is now given by dma_get_any_slave_channel instead of bindings.
>> DMAMUX driver has to be aware of this ID to route request line to out DMA
>> channel. This channel id information is carried on until DMAMUX through
>> dmaengine_slave_config with a custom API.
>> Hope it clarifies the need.
> 
> I see, this is not much different then what we face with our dra7 
> devices. In theory we could use direct DMA binding to the DMA controller 
> itself, but some requests would not be reachable, so we always use the 
> router's node for DMA on dra7 family.
> 
> Basically the router would manage the ChannelID and create 
> 'st,stm32-dma' compatible dma_spec (the four parameters).
> Afaik you could have 3 parameters for the router and create a four 
> parameter dma_spec, where the ChannelID is dynamically allocated.

Correct router needs 3 parameters and among those 2 are forwarded though out
dma_spec. But when you say "ChannelID is dynamically allocated" you mean
dma_get_any_slave_channel ? If yes I can use the already existing bindings to
carry the channelID to DMA. No changes need to peripheral...

> But you need to convert all peripherals to use the router's node for the 
> DMA.
> 
> - P?ter
> 

Py
