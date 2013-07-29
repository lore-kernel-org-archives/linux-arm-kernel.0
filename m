From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 29 Jul 2013 18:23:30 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <51F6E30B.7060106@wwwdotorg.org>
References: <2469263.vMN09Q7Tzi@flatron>
	<51F6E30B.7060106@wwwdotorg.org>
Message-ID: <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The schema should enforce some kind of regularity into the description
of similar devices.  Take SPI for example. I pulled these SPI
controller definitions from the kernel source. Obviously all of these
controllers are different, but it seems to me that their definitions
could be made more regular. DMA seems like it could use a lot of help.

spi_0: spi at 13920000 {
compatible = "samsung,exynos4210-spi";
reg = <0x13920000 0x100>;
interrupts = <0 66 0>;
tx-dma-channel = <&pdma0 7>; /* preliminary */
rx-dma-channel = <&pdma0 6>; /* preliminary */
#address-cells = <1>;
#size-cells = <0>;
clocks = <&clock 327>, <&clock 159>;
clock-names = "spi", "spi_busclk0";
pinctrl-names = "default";
pinctrl-0 = <&spi0_bus>;
status = "disabled";
};

spi1: spi at 1f0e000 {
#address-cells = <1>;
#size-cells = <0>;
compatible = "ti,da830-spi";
reg = <0x30e000 0x1000>;
num-cs = <4>;
ti,davinci-spi-intr-line = <1>;
interrupts = <56>;
status = "disabled";
};

spi0: spi at b00d0000 {
cell-index = <0>;
compatible = "sirf,prima2-spi";
reg = <0xb00d0000 0x10000>;
interrupts = <15>;
sirf,spi-num-chipselects = <1>;
cs-gpios = <&gpio 0 0>;
sirf,spi-dma-rx-channel = <25>;
sirf,spi-dma-tx-channel = <20>;
#address-cells = <1>;
#size-cells = <0>;
clocks = <&clks 19>;
status = "disabled";
};

spi0: spi at f0000000 {
#address-cells = <1>;
#size-cells = <0>;
compatible = "atmel,at91rm9200-spi";
reg = <0xf0000000 0x100>;
interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(1)>,
      <&dma0 1 AT91_DMA_CFG_PER_ID(2)>;
dma-names = "tx", "rx";
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_spi0>;
status = "disabled";
};

spi0: spi at 48030000 {
compatible = "ti,omap4-mcspi";
#address-cells = <1>;
#size-cells = <0>;
reg = <0x48030000 0x400>;
interrupts = <65>;
ti,spi-num-cs = <2>;
ti,hwmods = "spi0";
status = "disabled";
};

mcspi1: spi at 48098000 {
compatible = "ti,omap4-mcspi";
reg = <0x48098000 0x200>;
interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
#address-cells = <1>;
#size-cells = <0>;
ti,hwmods = "mcspi1";
ti,spi-num-cs = <4>;
dmas = <&sdma 35>,
      <&sdma 36>,
      <&sdma 37>,
      <&sdma 38>,
      <&sdma 39>,
      <&sdma 40>,
      <&sdma 41>,
      <&sdma 42>;
dma-names = "tx0", "rx0", "tx1", "rx1",
   "tx2", "rx2", "tx3", "rx3";
};

spi at 7000d400 {
compatible = "nvidia,tegra114-spi";
reg = <0x7000d400 0x200>;
interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
nvidia,dma-request-selector = <&apbdma 15>;
#address-cells = <1>;
#size-cells = <0>;
clocks = <&tegra_car TEGRA114_CLK_SBC1>;
clock-names = "spi";
status = "disabled";
};

On Mon, Jul 29, 2013 at 5:47 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/28/2013 06:21 PM, Tomasz Figa wrote:
> ...
>> b) What information should be specified in schemas? What level of
>>    granularity is required?
>>
>> For each property we need to have at least following data specified:
>>  - property name (or property name format, e.g. regex),
>>  - whether the property is mandatory or optional,
>>  - data type of value.
>
> We might want general restrictions on node/property names, e.g. it seems
> we generally prefer - rather than _ in them, although there are a few
> entrenched exceptions.
>
>> As for now, I can think of following data types used in device trees:
>>  - boolean (i.e. without value),
>>  - array of strings (including single string),
>>  - array of u32 (including single u32),
>>  - specifier (aka phandle with args, including cases with 0 args),
>>  - variable-length cells (e.g. #address-cells of u32s).
>>
>> Some properties might require a combination of data types to be specified
>
> I believe phandles are just cells in terms of the storage type at least.
> Hence, I'd argue we don't need mixing of types (boolean, cell, string),
> but I see your point about semantically needing to represent different
> cells meaning different things.
>
>> or even an array of combinations, like interrupt-map property, which is an
>> array of entries consisting of:
>>  - #address-cells u32s,
>>  - #interrupt-cells u32s,
>>  - specifier (phandle of interrupt controller and u32 of count defined by
>>    #interrupt-cells of the controller).
>>
>> We probably want to define allowed range of values for given property, be
>> it contiguous or enumerated.
>
> Where defining the length of a property (or part of it) in terms of
> another #xxx-cells property, we need to specify where that other
> property exists. Sometimes it's the nearest parent node containing the
> property (typical for #address-cells), sometimes it's the node
> containing the property itself (typical for one of the #address-cells
> referenced by a ranges property), and sometimes it's in the node
> referenced by the phandle associated with a specifier.
>
> Other content restrictions might be:
>
> * List must contain (at least) these entries/values.
>
> * List can't contain any other entries/values not specified here.
>
> * List must be in this order vs. any order.
>
> * List logical length (in entries, not bytes/cells) must match the
> logical length of another cell (consider clocks/clock-names).
>
> * Ordering of one property must match ordering of another property
> (again consider clocks/clock-names), although it'd be difficult to tell
> whether this condition was met, perhaps we can at least document it.
>
> I'm sure there will be many more criteria to validate that we're
> forgetting. This is possible the most complex area?
>
>> As for subnodes, I think we need to define following constraints:
>>  - node name (or node name format, e.g. regex),
>
> I don't think node names are supposed to convey any semantic meaning, so
> they probably shouldn't be restricted (much?) by schema.
>
>> d) When should the validation happen and what should handle it?
> ...
>> well. Nothing stops us from running validation on already compiled dtbs,
>> though, using an extra tool.
>
> In a DTB, I'm not sure whether all the type information is still present.
>
> For example, in DTS, the following are very obviously different:
>
> prop = "abc", "def";
> prop = <0x61626300> <0x64656600>;
>
> ... whereas in the DTB, I think they are both just two 32-bit values
> that just happen to encode string data or not. Presumably we want the
> validator to force string properties to be specified using string syntax?
>
> Equally, I'm not sure there's any difference between:
>
> prop = <&node>;
> prop = <0x23648689>;
>
> ... in the DTB, except that the value just *happens* to match another
> node's phandle value, which could end up leading to false positive
> matches if only applied on the raw values not the syntax?
>



-- 
Jon Smirl
jonsmirl at gmail.com
