From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 23 Jan 2015 09:57:19 -0700
Subject: [PATCH] arm64: dts: Add initial device tree support for Tegra132
In-Reply-To: <alpine.DEB.2.02.1501231038130.5450@utopia.booyaka.com>
References: <alpine.DEB.2.02.1501161139180.9776@utopia.booyaka.com>
 <20150121161313.GI5044@leverpostej>
 <alpine.DEB.2.02.1501231038130.5450@utopia.booyaka.com>
Message-ID: <54C27D6F.9000006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2015 04:31 AM, Paul Walmsley wrote:
> + Arto, Terje for comments on the host1x section
> + Stephen Warren for comments on the serial DT data

> On Wed, 21 Jan 2015, Mark Rutland wrote:
>
>> As mentioned in my reply to the DT list patch [1], there are a couple of
>> bits I'd like to see cleaned up first, but in the meantime I have some
>> comments from my first pass of the dtsi below. Some of these may equally
>> apply to existing dts(i) files.
>>
>> I see a few undocumented compatible strings (at least when comparing
>> against mainline). If there are other series or trees I should be
>> looking at, any pointers would be appreciated. If not, documentation
>> updates would be nice (checkpatch should complain otherwise).

>> On Fri, Jan 16, 2015 at 11:45:29AM +0000, Paul Walmsley wrote:
>>>
>>> Add an initial device tree file for the Tegra132 SoC.  The DT file is
>>> based on arch/arm/boot/dts/tegra124.dtsi and
>>> arch/arm/boot/dts/tegra114.dtsi, with the following significant
>>> changes:
>>>
>>> - Tegra132 uses a Denver CPU cluster rather than an ARMv7 CPU cluster
>>> - Devices are arranged by bus, rather than in a flat topology
>>> - No polling delays have been defined for the thermal zones.  I don't
>>>    believe that this is a property of the SoC hardware, but rather of a
>>>    given use-case.

>>> diff --git a/arch/arm64/boot/dts/tegra/tegra132.dtsi b/arch/arm64/boot/dts/tegra/tegra132.dtsi
>>> +               /*
>>> +                * There are two serial drivers: an 8250 based simple
>>> +                * serial driver and an APB DMA based serial driver
>>> +                * for higher baudrate and performance. To enable the
>>> +                * 8250 based driver, the compatible string is
>>> +                * "nvidia,tegra132-uart", "nvidia,tegra124-uart",
>>> +                * "nvidia,tegra20-uart" and to enable the APB DMA
>>> +                * based serial driver, the compatible string is
>>> +                * "nvidia,tegra132-hsuart", "nvidia,tegra124-hsuart",
>>> +                * "nvidia,tegra30-hsuart".
>>> +                */
>>
>> Is there any reason to continue with this split?
>>
>> Surely if the only difference is DMA, the presence of dmas and dma-names
>> should be sufficient to get the driver to do the right thing, and if you
>> need to disable DMA for debugging that could be a command-line option.

I vaguely recall asking for the DMA support to be integrated into the 
regular 8250 driver instead when the separate DMA-capable driver was 
first added. I /think/ there was resistance to this because adding lots 
of different SoC-specific ways to do DMA into the existing 8250 driver 
would complicate it even more, and hence be unmaintainable.

I assume that reasoning is still valid.

Perhaps what we need is more fine-grained driver selection, not just 
based on compatible value. Something like:

if compatible == nvidia,tegra20-uart:
   if node.has_prop("enable-dma"):
     driver = Tegra-specfic DMA capable UART driver
   else:
     driver = Common 8250 driver

Is that something that of_serial.c could/should be enhanced to do? That 
said, the whole reasoning behind separate compatible properties before 
was that compatible is supposed to "drive" driver selection. At least, 
that's what I was told then.

>> Does the binding and/or driver support aliases so you can get consistent
>> numbering? It would be nice to have.

I believe either the serial core or serial driver(s) support DT aliases 
now, yes.

>> Do these UARTs work with earlycon?

I do not know.

>> It would be nice to have a /chosen/stdout-path (ideally with rate) so as
>> to get output consistently without command line options being required.
>
> Stephen Warren might be the best person to directly respond to these
> issues.  This is all legacy DT data from previous Tegra SoCs.
>
>>
>>> +               uarta: serial at 0,70006000 {
>>> +                       compatible = "nvidia,tegra132-uart", "nvidia,tegra124-uart", "nvidia,tegra20-uart";
>>> +                       reg = <0x0 0x70006000 0x0 0x40>;
>>> +                       reg-shift = <2>;
>>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>> +                       clocks = <&tegra_car TEGRA124_CLK_UARTA>;
>>> +                       resets = <&tegra_car 6>;
>>> +                       reset-names = "serial";
>>> +                       dmas = <&apbdma 8>, <&apbdma 8>;
>>> +                       dma-names = "rx", "tx";
>>> +                       status = "disabled";
>>> +               };
