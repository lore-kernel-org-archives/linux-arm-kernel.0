From: kbeldan@baylibre.com (Karl Beldan)
Date: Sat, 13 Aug 2016 11:42:46 +0000
Subject: [PATCH 2/4] ARM: dts: da850: Add an aemif node
In-Reply-To: <57AAE728.8000209@ti.com>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
 <20160809171518.22690-3-kbeldan@baylibre.com>
 <57AADC63.90405@ti.com> <57AADF7B.1070102@ti.com>
 <20160810080713.GB16481@gobelin> <57AAE1D1.5080000@ti.com>
 <20160810082631.GC16481@gobelin> <57AAE5E6.8090304@ti.com>
 <20160810083421.GD16481@gobelin> <57AAE728.8000209@ti.com>
Message-ID: <20160813114246.GB27739@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 02:04:48PM +0530, Sekhar Nori wrote:
> On Wednesday 10 August 2016 02:04 PM, Karl Beldan wrote:
> > On Wed, Aug 10, 2016 at 01:59:26PM +0530, Sekhar Nori wrote:
> >> On Wednesday 10 August 2016 01:56 PM, Karl Beldan wrote:
> >>> On Wed, Aug 10, 2016 at 01:42:01PM +0530, Sekhar Nori wrote:
> >>>> On Wednesday 10 August 2016 01:37 PM, Karl Beldan wrote:
> >>>>> On Wed, Aug 10, 2016 at 01:32:03PM +0530, Sekhar Nori wrote:
> >>>>>> On Wednesday 10 August 2016 01:18 PM, Sekhar Nori wrote:
> >>>>>>> On Tuesday 09 August 2016 10:45 PM, Karl Beldan wrote:
> >>>>>>>> Currently the davinci da8xx boards use the mach-davinci aemif code.
> >>>>>>>> Instantiating an aemif node into the DT allows to use the ti-aemif
> >>>>>>>> memory driver and is another step to better DT support.
> >>>>>>>> Also it will allow to properly pass the emif timings via DT.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> >>>>>>>> ---
> >>>>>>>>  arch/arm/boot/dts/da850.dtsi | 10 ++++++++++
> >>>>>>>>  1 file changed, 10 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> >>>>>>>> index bc10e7e..f62928c 100644
> >>>>>>>> --- a/arch/arm/boot/dts/da850.dtsi
> >>>>>>>> +++ b/arch/arm/boot/dts/da850.dtsi
> >>>>>>>> @@ -411,6 +411,16 @@
> >>>>>>>>  			dma-names = "tx", "rx";
> >>>>>>>>  		};
> >>>>>>>>  	};
> >>>>>>>> +	aemif: aemif at 68000000 {
> >>>>>>>> +		compatible = "ti,da850-aemif";
> >>>>>>>> +		#address-cells = <2>;
> >>>>>>>> +		#size-cells = <1>;
> >>>>>>>> +
> >>>>>>>> +		reg = <0x68000000 0x00008000>;
> >>>>>>>> +		ranges = <0 0 0x60000000 0x08000000
> >>>>>>>> +			  1 0 0x68000000 0x00008000>;
> >>>>>>>> +		status = "disabled";
> >>>>>>>> +	};
> >>>>>>>>  	nand_cs3 at 62000000 {
> >>>>>>>>  		compatible = "ti,davinci-nand";
> >>>>>>>>  		reg = <0x62000000 0x807ff
> >>>>>>>
> >>>>>>> The nand node should be part of aemif node like it is done for keystone
> >>>>>>> boards.
> >>>>>>
> >>>>>> Actually, can you move the nand node out of da850.dtsi completely. Its
> >>>>>> much better to keep da850.dtsi restricted to soc-internal devices and
> >>>>>> keep the board level devices like NAND flash in <board>.dts file.
> >>>>>>
> >>>>>> Similarly, can you move the NAND pinmux definitions too to the
> >>>>>> da850-evm.dts file?
> >>>>>>
> >>>>>> There is advantage in keeping common pinmux definitions in da850.dtsi so
> >>>>>> each board doe not have to repeat them. But AEMIF is an exception as its
> >>>>>> usage can really be varied (NAND, NOR, SRAM, other). Plus, different
> >>>>>> boards are likely to use different chip selects so coming up with some
> >>>>>> pinmux definitions which will be reused widely is really unlikely.
> >>>>>>
> >>>>> This is exactly what I just did for the LCDK.
> >>>>> If everybody is happy with it I will do the same for the evm as I put it
> >>>>> in the cover letter.
> >>>>
> >>>> Yes please. We dont want duplication of data between da850.dtsi and
> >>>> da850-lcdk.dts files.
> >>>>
> >>> Then I'll wait for this series to be applied and then apply my changes
> >>> to the EVM while retiring the nand_cs3 together.
> >>
> >> No, I prefer the fixup happens first. In the same series, you can first
> >> fixup existing EVM and then add LCDK support.
> >>
> > 
> > Well in that case you'll have to do the testing since I only have an
> > LCDK. I should be able to send the series within the hour.
> 
> Sure. I can test it.
> 

Yesterday I got my hands on an EVM TI just sent and could test it on it.
The change proper is fine, but I was surprised mainline was broken wrt
4-bit ECC on top of 8bits NANDs, so I tested with 1-bit ECC, 'enough'
for this device.

FYI, the NAND socket had a
  nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
  nand: Micron MT29F4G08AAC
  nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
 
Karl
