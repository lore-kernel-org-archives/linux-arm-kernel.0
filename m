From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Fri, 4 Aug 2017 14:50:01 +0200
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <401305f0-15d8-1996-60d6-69c13cbacc06@ti.com>
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
 <0e16a519-3d60-f683-5517-12a520e0e521@st.com>
 <f0db566e-5613-8914-e070-915c8c4d9b9f@ti.com>
 <71b7ef2a-d745-d16b-4538-567c856cce9a@st.com>
 <401305f0-15d8-1996-60d6-69c13cbacc06@ti.com>
Message-ID: <58bf2f7c-faf1-d1e9-3c87-d7964d1ba3d4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/03/2017 11:48 AM, Peter Ujfalusi wrote:
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> On 2017-08-03 12:00, Pierre Yves MORDRET wrote:
>>> What I actually mean is that you should not need to modify the DMA 
>>> driver at all.
>>> According to stm32-dma.txt:
>>> #dma-cells = <4>;
>>> 1. channelID
>>> 2. request line number
>>> 3. - 4. some parameters
>>>
>>> I believe if you don't have the event router (directly using the DMA 
>>> node) you always need to provide these, right?
>>
>> Correct
>>
>>> If I'm not mistaken, when you use the event router you want to omit the 
>>> ChannelID and get a random channel via dma_get_any_slave_channel in the 
>>> DMA driver and feed back the channelID to the event router driver?
>>
>> Again correct.
>>
>>> I believe the reason for this is that you want to keep mixed binding 
>>> use, to have direct DMA bindings and bindings via event router.
>>>
>>
>> Well no. peripheral has to use DMAMUX and mixing up is to be avoided. This is
>> more for backward compatibility with SoC which doesn't have a DMAMUX.
>>
>>> Now what happens if you have direct binding:
>>> device1 {
>>> 	dmas = <&dma2 1 4 0x10400 0x3>;
>>> };
>>>
>>> and via event router:
>>> device2 {
>>> 	dmas =	<&dma_router 10 0x10400 0x3>,
>>> 		<&dma_router 11 0x10400 0x3>;
>>> };
>>>
>>> device2 probes first, will get channelID 0 and 1 via 
>>> dma_get_any_slave_channel.
>>>
>>> When device1 tries to probe, the channelID 1 is already taken..
>>
>> Yes this is a flaw if we mix up bindings.
>>
>>>
>>> You need to convert all peripherals to use the event router to avoid 
>>> such a races. I have done the same for the dra7.
>>> Add the event router driver,
>>> add the event router node and convert existing users to use that
>>> when adding new devices, use the event router node.
>>>
>>> The event router's binding would have 3 parameters, it manages the 
>>> available channelIDs, like the ti-dma-crossbar does for dra7. At 
>>> allocate time it would pick an unused channelID and craft the dma-spec 
>>> with the four parameters as documented.
>>> The main DMA driver will not need any modification as everything will be 
>>> taken care of by the event router.
>>>
>>
>> I look up what has been done in ti-dma-crossbar and actually this DMAMUX driver
>> has been well inspired from ti-dma-crossbar.
>> Nonetheless I understand what you meant. The channelID doesn't come from the
>> dmaengine and a piece a code is devised to allocate those. I could copy/paste
>> such code in my side but I do believe this would be better if such information
>> would come from dmaengine instead : this is what I did but a link/callback is
>> missing to craft this info until DMA. ChannelID is computed in two places in
>> dmaemgine and in your driver. Moreover any router is going to develop its own
>> channelID allocator, info which normally comes from dmaengine.
> 
> yes and no.
> In my case on dr7 we have DMA request crossbar to support more events
> than either eDMA or sDMA could possible handle. eDMA and sDMA works in
> different ways, but the same event router driver facilitates them fine.
> In sDMA any channel can service any DMA requests, while in eDMA the
> channel number and the event numbers are matched (ch10 can service only
> event10).
> 
> Our event router driver's task is to map the incoming event number to an
> outgoing event number, which is then going to be used by the DMA driver
> as incoming event. So in the crossbar we anyways need to pick an event
> from the available list of unused ones. The DMA drivers (eDMA or sDMA)
> would just think that the request comes via normal binding and does what
> it normally does on SoC where we don't have the crossbar (OMAPs for
> sDMA, daVinci, am33/am43, k2g, etc for eDMA).
> 
> I'm not sure what your DMAMUX muxes, is it the channels or the events,
> but it only need to manage the needed, moving parts.
> 

Our DMAMUX can manage up to 255 request lines (only 128 is eventually assigned
though) onto 16 events: 8 events mapped on 1 DMA and the 8 others onto the
second DMA. Request line numbering is fixed (a peripheral DMA request is
assigned to one MUX input) and but can be routed randomly onto the any 16
channels. We use chanID to mux input on event.
chanID given by dma_get_any_slave_channe is enough in our case.

Py

>> Vinod, I can update my driver to mimic what ti-dma-crossbar did to avoid the
>> custom API. This is s rather big change to evaluate in my side though.
>> However it seems to me such info should have come from dmaengine and not from
>> driver.
>> Let me know your thought about this
>>
>>> The only gotcha is with memcpy type of transfers as they might also need 
>>> unique channelID, but not requested via the slave binding. For that I 
>>> have added properties to the event router to mask out certain channels 
>>> (and I needed to do the same for the eDMA, but it is unrelated to the 
>>> router itself).
>>>
>>>
>>> - P?ter
>>>
>>
>> Py
>>
> 
> - P?ter
> 
