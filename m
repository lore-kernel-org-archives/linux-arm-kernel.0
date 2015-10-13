From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Oct 2015 17:32:56 +0200
Subject: [PATCH v2 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <20151013142240.GC24353@leverpostej>
References: <1444744848-720-1-git-send-email-cedric.madianga@gmail.com>
 <1444744848-720-2-git-send-email-cedric.madianga@gmail.com>
 <20151013142240.GC24353@leverpostej>
Message-ID: <CAOAejn1m1shL-ajxBsiEwQABM1HuhuNgMbgn83LUzmvJXGx0_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

2015-10-13 16:22 GMT+02:00 Mark Rutland <mark.rutland@arm.com>:
> On Tue, Oct 13, 2015 at 04:00:45PM +0200, M'boumba Cedric Madianga wrote:
>> This patch adds documentation of device tree bindings for the STM32 dma
>> controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>  .../devicetree/bindings/dma/stm32-dma.txt          | 98 ++++++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> new file mode 100644
>> index 0000000..9ce0d49
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> @@ -0,0 +1,98 @@
>> +* STMicroelectronics STM32 DMA controller
>> +
>> +The STM32 DMA is a general-purpose direct memory access controller capable of
>> +supporting 8 independent DMA channels. Each channel can have up to 8 requests.
>> +
>> +Required properties:
>> +- compatible: Should be "st,stm32-dma"
>> +- reg: Should contain DMA registers location and length. This should include
>> +  all of the per-channel registers.
>> +- interrupts: Should contain all of the per-channel DMA interrupts.
>
> Please specify the order they must be in.
 Ok, I will do it in the next version.
Thanks

>
>> +- clocks: Should contain the input clock of the DMA instance.
>> +- #dma-cells : Must be <4>. See DMA client paragraph for more details.
>> +
>> +Optional properties:
>> +- resets: Reference to a reset controller asserting the DMA controller
>> +- st,mem2mem: boolean; if defined, it indicates that the controller supports
>> +  memory-to-memory transfer
>> +
>> +Example:
>> +
>> +     dma2: dma-controller at 40026400 {
>> +             compatible = "st,stm32-dma";
>> +             reg = <0x40026400 0x400>;
>> +             interrupts = <56>,
>> +                          <57>,
>> +                          <58>,
>> +                          <59>,
>> +                          <60>,
>> +                          <68>,
>> +                          <69>,
>> +                          <70>;
>> +             clocks = <&clk_hclk>;
>> +             #dma-cells = <4>;
>> +             st,mem2mem;
>> +             resets = <&rcc 150>;
>> +     };
>> +
>> +* DMA client
>> +
>> +Required properties:
>> +- dmas: Comma separated list of dma channel requests
>> +- dma-names: Names of the aforementioned requested channels
>> +
>> +Each dmas request consists of 5 cells:
>> +1. A phandle pointing to the STM32 DMA controller
>> +2. The channel id
>> +3. The request line number
>> +4. A 32bit mask specifying the DMA channel configuration
>> + -bit 1: Direct Mode Error Interrupt
>> +     0x0: disabled
>> +     0x1: enabled
>> + -bit 2: Transfer Error Interrupt
>> +     0x0: disabled
>> +     0x1: enabled
>> + -bit 3: Half Transfer Mode Error Interrupt
>> +     0x0: disabled
>> +     0x1: enabled
>> + -bit 4: Transfer Complete Interrupt
>> +     0x0: disabled
>> +     0x1: enabled
>
> Why should this be in the DT?
>
> Surely the driver should be in charge of deciding when to use these?
For interrupt configuration the driver could set default configuration
and don't let the DMA client set it.
The goal here is to offer for each DMA client a way to choose his
level of information when an error occured on DMA bus or when a DMA
transfer is complete.
For channel and request ids, these inputs are really mandatory as DMA
mapping (couple channel/request) is fixed.
So each DMA peripheral has it own channel/request ids.

>
>> + -bit 9: Peripheral Increment Address
>> +     0x0: no address increment between transfers
>> +     0x1: increment address between transfers
>> + -bit 10: Memory Increment Address
>> +     0x0: no address increment between transfers
>> +     0x1: increment address between transfers
>
> These don't seem like they belong either. Surely this would depend on
> the request made, rather than being a fixed property?
It is really specific to the DMA client.
Many clients transfer DMA from peripheral at fixed register address so
in this use case PINC=0. (It is the most common case)
But others clients could do it by incrementing an memory area after
each transfer and in this case PINC=1.
I don't have any example in mind for the second use case but as the
DMA supports it I would like to keep it.

>
>> + -bit 15: Peripheral Increment Offset Size
>> +     0x0: offset size is linked to the peripheral bus width
>> +     0x1: offset size is fixed to 4 (32-bit alignment)
>
> This sounds like it might belong in the DT.
Agree

>
>> + -bit 16-17: Priority level
>> +     0x0: low
>> +     0x1: medium
>> +     0x2: high
>> +     0x3: very high
>
> What do we do elsewhere in terms of describing prioritisation? It feels
> like it would be a dynamic property of the system.
You're right it could be a dynamic property of the system but we don't
have any way to set it via the dmaengine API.
So, we decide to set it before requesting a DMA transfer and keep it
during all peripheral life.

>
>> +5. A 32bit mask specifying the DMA FIFO configuration
>> + -bit 0-1: Fifo threshold
>> +     0x0: 1/4 full FIFO
>> +     0x1: 1/2 full FIFO
>> +     0x2: 3/4 full FIFO
>> +     0x3:full FIFO
>
> What does this mean?
The STM32 DMA has a 4 words FIFO to temporarily stores data from source.
The threshold level is used to know at each which FIFO filling rate
the data stores in the FIFO will be really sent to the destination.
For example, with FIFO threshold = 1/2 full FIFO, we wait at least 2
words of data from source before storing it into to the destination.
>
>> + -bit 2: Direct mode
>> +     0x0: enabled
>> +     0x1: disabled
>
> What does this mean?
The Direct mode bit is used to choose if you want to use FIFO or not.
In direct mode (Direct mode = 0), the data coming from source are not
temporarily stored in the DMA FIFO and are directly stored into the
destination.
In FIFO mode ((Direct mode = 1), the data are temporarily stored in
the DMA FIFO and then in the destination according to the FIFO
threshold level as explained above.

>
>> + -bit 7: FIFO Error Interrupt
>> +     0x0: disabled
>> +     0x1: enabled
>
> As with the other interrupt configuration, this does not look like it
> belongs in the DT.
Again the driver could set default configuration and don't let the DMA
client set it.
The goal here is to offer for each DMA client a way to choose his
level of information when an error occured on DMA bus.

>
> Thanks,
> Mark.

Thanks for your review and comments.

BR,
Cedric
