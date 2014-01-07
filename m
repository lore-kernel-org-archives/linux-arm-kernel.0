From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 7 Jan 2014 10:19:30 +0800
Subject: [PATCH v3] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <20140106150936.GA24664@e106331-lin.cambridge.arm.com>
References: <1389007012-10887-1-git-send-email-21cnbao@gmail.com>
 <20140106150936.GA24664@e106331-lin.cambridge.arm.com>
Message-ID: <CAGsJ_4wO33CUnB_oU27gd79i9ZyRyiG4bCZAW3h4YRM-0ODLeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
thanks!

2014/1/6 Mark Rutland <mark.rutland@arm.com>:
> On Mon, Jan 06, 2014 at 11:16:52AM +0000, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> move to support of_dma_request_slave_channel() and dma_request_slave_channel.
>> we add a xlate() to let dma clients be able to find right dma_chan by generic
>> "dmas" properties in dts.
>>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -v3:
>>  drop unused variant cap pointed out by Lars-Peter;
>>  add dt-binding document
>>
>>  .../devicetree/bindings/dma/sirfsoc-dma.txt        |   42 ++++++++++++++++++++
>>  arch/arm/boot/dts/atlas6.dtsi                      |    4 ++
>>  arch/arm/boot/dts/prima2.dtsi                      |    4 ++
>>  drivers/dma/sirf-dma.c                             |   23 +++++++++++
>>  4 files changed, 73 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/sirfsoc-dma.txt b/Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
>> new file mode 100644
>> index 0000000..262cf8c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/sirfsoc-dma.txt
>> @@ -0,0 +1,42 @@
>> +* CSR SiRFSoC DMA controller
>> +
>> +See dma.txt first
>> +
>> +Required properties:
>> +- compatible: Should be "sirf,prima2-dmac" or "sirf,marco-dmac"
>> +- reg: Should contain DMA registers location and length.
>> +- interrupts: Should contain one interrupt shared by all channel
>> +- #dma-cells: see dma.txt, should be 1, para number
>
> para number?

i copied the document from k3dma.txt and changed for sirfsoc. so
missed this issue as well:

# grep "para number" *
k3dma.txt:- #dma-cells: see dma.txt, should be 1, para number

>
>> +- dma-channels: physical channels supported
>> +- clocks: clock required
>> +
>> +Example:
>> +
>> +Controller:
>> +dmac0: dma-controller at b00b0000 {
>> +     compatible = "sirf,prima2-dmac";
>> +     reg = <0xb00b0000 0x10000>;
>> +     interrupts = <12>;
>> +     clocks = <&clks 24>;
>> +};
>
> #dma-cells and dma-channels seem to be missing.

real. #dma-cells is missed.

>
>> +
>> +
>> +Client:
>> +Use specific request line passing from dmax
>> +For example, spi0 read channel request line is 9 of the 2nd dma controller, while
>> +write channel uses 4 of the 2nd dma controller; spi1 read channel request line is
>> +12 of the 1st dma controller, while write channel uses 13 of the 1st dma controller.
>
> I think this should be described in the #dma-cells description, as this
> described the meaning of the single dma cell.

here it is explaining how to fill the client even though it is mapping
with the #dma-cells of host.

>
>> +
>> +spi0: spi at b00d0000 {
>> +     compatible = "sirf,prima2-spi";
>> +     dmas = <&dmac1 9>,
>> +             <&dmac1 4>;
>> +     dma-names = "rx", "tx";
>> +};
>> +
>> +spi1: spi at b0170000 {
>> +     compatible = "sirf,prima2-spi";
>> +     dmas = <&dmac0 12>,
>> +             <&dmac0 13>;
>> +     dma-names = "rx", "tx";
>> +};
>> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
>> index b63cfef..aa3ff43 100644
>> --- a/arch/arm/boot/dts/atlas6.dtsi
>> +++ b/arch/arm/boot/dts/atlas6.dtsi
>> @@ -260,6 +260,8 @@
>>                               reg = <0xb00b0000 0x10000>;
>>                               interrupts = <12>;
>>                               clocks = <&clks 24>;
>> +                             #dma-cells = <1>;
>> +                             #dma-channels = <16>;
>
> is it dma-channels or #dma-channels? The document and examples differ.

i realized i don't need dma-channels or #dma-channels at all as in
sirfsoc, the number of channels of every dma controller is dedicated
to SIRFSOC_DMA_CHANNELS(16). so i will drop the stuff.

>
> [...]
>
>> +static struct dma_chan *of_dma_sirfsoc_xlate(struct of_phandle_args *dma_spec,
>> +     struct of_dma *ofdma)
>> +{
>> +     struct sirfsoc_dma *sdma = ofdma->of_dma_data;
>> +     unsigned int request = dma_spec->args[0];
>> +
>> +     if (request > SIRFSOC_DMA_CHANNELS)
>> +             return NULL;
>> +
>> +     return dma_get_slave_channel(&(sdma->channels[request].chan));
>
> Are the internal brackets necessary? "&" is lower precendence than "->",
> "[]", and ".".

it is not a big issue. it seems more readable with this bracket.

>
> Thanks,
> Mark.

-barry
