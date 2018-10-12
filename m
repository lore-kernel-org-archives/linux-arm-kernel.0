From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Fri, 12 Oct 2018 11:03:22 +0200
Subject: [PATCH v3 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining support
In-Reply-To: <d64da587-a680-20c4-7139-f59fd1f299bc@st.com>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-5-git-send-email-pierre-yves.mordret@st.com>
 <20181007160030.GB2372@vkoul-mobl>
 <e9cedfdd-ad90-9123-03bb-34a2e84059c5@st.com>
 <20181010040343.GO2372@vkoul-mobl>
 <d64da587-a680-20c4-7139-f59fd1f299bc@st.com>
Message-ID: <c0a9d530-010a-6a26-79c8-3a7992946df2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I should add more explanations on how this feature works.

As I told earlier in my cover letter, the STM32 DMA don't have the ability to
generate burst transfer on the DDR as it only embeds a 4-word FIFO although the
minimal burst length on the DDR is 8 words.
This a big flaw when performances is at sack.
Even more some IP like camera is very aggressive in term or real time
constraints. The amount of data is huge (5Mpix) and DMAv2 is limited to 256KiB
for a single transfer that leads to overrun at Camera IP level when loading new
DMA descriptors: DMAv2 doesn't implement Hw LLI this is pure sw.

Thus our Hw has been devised to overcome this weakness. MDMA FIFO is bigger
(128Bytes) and burst length is more accurate in such cases of performances.
Unfortunately MDMA can't access some IPs like I2C, Camera, UART, SPI, ...
This is why DMAv2 is used to transfer data from device to/from SDRAM (DMAv2 can
burst on SDRAM) and MDMA to transfer data from SDRAM to/from DDR.
For M2D: DDR --> MDMA --> SRAM --> DMA  --> IP
For D2M: IP  --> DMA  --> SRAM --> MDMA --> DDR

When user request a DMA txn (SG or cyclic)
* DMAv2 will be set in double buffer cyclic mode. DMAv2 will toggle upon 2
buffers in SDRAM (size defined by device tree: 4KiB, 8Kib, 16KiB, 32KiB). In
cyclic mode DMAv2 will reload automatically its configuration without sw support.
* On the other side MDMA will be used to fetch those 2 buffers with an Hw LLI to
fill up final destination DDR buffer.

DMAv2 and MDMA synchronization is purely Hw ! At DMAv2 side there are NO
interrupts generated at CPU level. Internally the DMAv2 transfer complete irq is
connected upon MDMA request line. At MDMA side, it has the ability to
acknowledge DMAv2 irq throughout programmable register.
This means when DMAv2 has ended up a SRAM buffer, a Transfer complete is
generation upon MDMA request line. While MDMA will fetch this newly SRAM buffer,
DMAv2 gathers a new SRAM buffer. This process goes on until the DDR is filled
up. MDMA will fire the final transfer complete that will notify user for
transfer completion.

Hope it clarifies.
Regards


On 10/10/2018 09:02 AM, Pierre Yves MORDRET wrote:
> 
> 
> On 10/10/2018 06:03 AM, Vinod wrote:
>> On 09-10-18, 10:40, Pierre Yves MORDRET wrote:
>>>
>>>
>>> On 10/07/2018 06:00 PM, Vinod wrote:
>>>> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
>>>>> This patch adds support of DMA/MDMA chaining support.
>>>>> It introduces an intermediate transfer between peripherals and STM32 DMA.
>>>>> This intermediate transfer is triggered by SW for single M2D transfer and
>>>>> by STM32 DMA IP for all other modes (sg, cyclic) and direction (D2M).
>>>>>
>>>>> A generic SRAM allocator is used for this intermediate buffer
>>>>> Each DMA channel will be able to define its SRAM needs to achieve chaining
>>>>> feature : (2 ^ order) * PAGE_SIZE.
>>>>> For cyclic, SRAM buffer is derived from period length (rounded on
>>>>> PAGE_SIZE).
>>>>
>>>> So IIUC, you chain two dma txns together and transfer data via an SRAM?
>>>
>>> Correct. one DMA is DMAv2 (stm32-dma) and the other is MDMA(stm32-mdma).
>>> Intermediate transfer is between device and memory.
>>> This intermediate transfer is using SDRAM.
>>
>> Ah so you use dma calls to setup mdma xtfers? I dont think that is a
>> good idea. How do you know you should use mdma for subsequent transfer?
>>
> 
> When user bindings told to setup chaining intermediate MDMA transfers are always
> triggers.
> For instance if a user requests a Dev2Mem transfer with chaining. From client
> pov this is still a prep_slave_sg. Internally DMAv2 is setup in cyclic mode (in
> double buffer mode indeed => 2 buffer of PAGE_SIZE/2) and destination is SDRAM.
> DMAv2 will flip/flop on those 2 buffers.
> At the same time DMAv2 driver prepares a MDMA SG that will fetch data from those
> 2 buffers in SDRAM and fills final destination memory.
> 
>>
>>>>>  drivers/dma/stm32-dma.c | 879 ++++++++++++++++++++++++++++++++++++++++++------
>>>>
>>>> that is a lot of change for a driver, consider splitting it up
>>>> logically in smaller changes...
>>>>
>>>
>>> This feature is rather monolithic. Difficult to split up.
>>> All the code is required at once.
>>
>> It can be enabled at last but split up logically. Intrusive changes to a
>> driver make it hard to review..
>>
> Ok. I will to think about it how to proceed.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
