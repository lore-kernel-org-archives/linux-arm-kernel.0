From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Fri, 19 Oct 2018 11:21:37 +0200
Subject: [PATCH v3 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining support
In-Reply-To: <20181016144432.GR2400@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-5-git-send-email-pierre-yves.mordret@st.com>
 <20181007160030.GB2372@vkoul-mobl>
 <e9cedfdd-ad90-9123-03bb-34a2e84059c5@st.com>
 <20181010040343.GO2372@vkoul-mobl>
 <d64da587-a680-20c4-7139-f59fd1f299bc@st.com>
 <20181015171403.GM2400@vkoul-mobl>
 <9a375fd3-964f-3d57-9d18-b010e20a4d42@st.com>
 <20181016144432.GR2400@vkoul-mobl>
Message-ID: <fe4469fd-14bf-2031-7eda-babc3eef9cf3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/16/18 4:44 PM, Vinod wrote:
> On 16-10-18, 11:19, Pierre Yves MORDRET wrote:
>>
>>
>> On 10/15/18 7:14 PM, Vinod wrote:
>>> On 10-10-18, 09:02, Pierre Yves MORDRET wrote:
>>>>
>>>>
>>>> On 10/10/2018 06:03 AM, Vinod wrote:
>>>>> On 09-10-18, 10:40, Pierre Yves MORDRET wrote:
>>>>>>
>>>>>>
>>>>>> On 10/07/2018 06:00 PM, Vinod wrote:
>>>>>>> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
>>>>>>>> This patch adds support of DMA/MDMA chaining support.
>>>>>>>> It introduces an intermediate transfer between peripherals and STM32 DMA.
>>>>>>>> This intermediate transfer is triggered by SW for single M2D transfer and
>>>>>>>> by STM32 DMA IP for all other modes (sg, cyclic) and direction (D2M).
>>>>>>>>
>>>>>>>> A generic SRAM allocator is used for this intermediate buffer
>>>>>>>> Each DMA channel will be able to define its SRAM needs to achieve chaining
>>>>>>>> feature : (2 ^ order) * PAGE_SIZE.
>>>>>>>> For cyclic, SRAM buffer is derived from period length (rounded on
>>>>>>>> PAGE_SIZE).
>>>>>>>
>>>>>>> So IIUC, you chain two dma txns together and transfer data via an SRAM?
>>>>>>
>>>>>> Correct. one DMA is DMAv2 (stm32-dma) and the other is MDMA(stm32-mdma).
>>>>>> Intermediate transfer is between device and memory.
>>>>>> This intermediate transfer is using SDRAM.
>>>>>
>>>>> Ah so you use dma calls to setup mdma xtfers? I dont think that is a
>>>>> good idea. How do you know you should use mdma for subsequent transfer?
>>>>>
>>>>
>>>> When user bindings told to setup chaining intermediate MDMA transfers are always
>>>> triggers.
>>>> For instance if a user requests a Dev2Mem transfer with chaining. From client
>>>> pov this is still a prep_slave_sg. Internally DMAv2 is setup in cyclic mode (in
>>>> double buffer mode indeed => 2 buffer of PAGE_SIZE/2) and destination is SDRAM.
>>>> DMAv2 will flip/flop on those 2 buffers.
>>>> At the same time DMAv2 driver prepares a MDMA SG that will fetch data from those
>>>> 2 buffers in SDRAM and fills final destination memory.
>>>
>>> I am not able to follow is why does it need to be internal, why should
>>> the client not set the two transfers and trigger them?
>>>
>>
>> Client may use or not chaining: defined within DT. API and dynamic are same at
> 
> That should be upto client... As a dmaengine driver you should enable
> data transfer from src to dstn.
> 
>> driver client level. Moreover driver exposes only DMAv2 and not both DMAv2 and
>> MDMA. This is totally hidden for client. If client sets both this would imply
> 
> Why should a controller be hidden from user, I dont see why that would
> be a good thing
> 
>> changing all drivers that may want use chaining. Even more to deal with DMAv2
>> and MDMA at its level.
>> Since DMAv2 deals with MDMA, all drivers are same as before. no changes required.
> 
> It is not about changes, it is about the SW model you want to have.
> 
> The intermediate SRAM transfers should not be made within DMAengine
> driver, client can chose to have two transfers and couple or not, it is
> upto them to choose. Sorry I do not like this abstraction and would like
> to see a cleaner approach
> 

What we have done it to hide all the complexity related to DMA engine:
synchronization, residue and many other topics solved by this approach. If this
is up to client to perform intermediate transfer, each client drivers using
chaining will need to duplicate the required sw.
This approach is present as a feature from driver pov.

Regards
