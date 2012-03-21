From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Mar 2012 09:37:25 -0500
Subject: Device tree and IO map_desc.
In-Reply-To: <CAKON4OxxmO_Et8FTVp=i7h9uODWAtdjHOmZrFWLtgqYVAjAAGg@mail.gmail.com>
References: <CAKON4OyHRVvdtZGt+HiCnsRT_5zTuDVBVgOx22kFC2xxFLnD+Q@mail.gmail.com>
 <4F69D325.1000500@gmail.com>
 <CAKON4OxxmO_Et8FTVp=i7h9uODWAtdjHOmZrFWLtgqYVAjAAGg@mail.gmail.com>
Message-ID: <4F69E7A5.4090101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 09:23 AM, jonsmirl at gmail.com wrote:
> On Wed, Mar 21, 2012 at 9:09 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On 03/20/2012 11:52 AM, jonsmirl at gmail.com wrote:
>>> Is there a helper for building the IO map_desc from the device tree?
>>>
>>
>> No. This is one of those things that device tree cannot have knowledge
>> of what needs to be statically mapped as that's not a h/w description.
> 
> What's an example of something that is described in the device tree
> and is dynamically mapped? Things like PCI cards shouldn't be in the
> device tree since they are discoverable.
> 

I mean mapped into cpu virtual memory. Static mapping is map_desc.
Dynamic mapping is ioremap.

> Nodes have 'status' in them, could this be used to control mapping?
> 
> 				uart1: uart at 02020000 {
> 					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> 					reg = <0x02020000 0x4000>;
> 					interrupts = <0 26 0x04>;
> 					status = "disabled";
> 				};
> 
> Probably the right solution is that the individual drivers should map
> themselves by calling into a helper function with address and range.
> The helper would coalesce and merge ranges to reduce the number of
> mappings.

This is what most drivers do. The static mappings in map_desc are often
special cases where ioremap doesn't work. LL_DEBUG is one example.

> 
> This is a piece of a lpc3131 three I am working on. I could add a tiny
> driver for the adp node that creates the mapping. Then as the
> dependent devices ask for mappings they'd be inside the larger node.
> 

Use ioremap unless there is a reason you can't.

Rob

> 	ahb {
> 		compatible = "simple-bus";
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges;
> 
> 		isram0: memory at 11028000 {
> 			reg = <0x11028000 0x18000>;
> 		};
> 		isram1: memory at 11040000 {
> 			reg = <0x11040000 0x18000>;
> 		};
> 
> 		apb0: apb at 13000000 {
> 			compatible = "simple-bus";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			ranges = <0x13000000 0x13000000 0x8000>;
> 
> 			evtr at 13000000 {
> 				compatible = "nxp,lpc31xx-evtr";
> 				reg = <0x13000000 0x800>;
> 			};
> 			adc at 13002000 {
> 				compatible = "nxp,lpc31xx-adc";
> 				reg = <0x13002000 0x400>;
> 				interrupts = <1>;
> 			};
> 
> 
>>
>> We could probably have a list of nodes to map and extract the size and
>> physical addresses from the DT. There's lots of register defines
>> typically associated with the static mappings, so you would still have
>> duplicated information.
>>
>>> For example on Versatile. All of this map_io data is already in the
>>> device tree, it is just repeated here.
>>>
>>>
>>> DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
>>>       .map_io         = versatile_map_io,
>>>       .init_early     = versatile_init_early,
>>> ....
>>> MACHINE_END
>>>
>>> void __init versatile_map_io(void)
>>> {
>>>       iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
>>> }
>>>
>>> static struct map_desc versatile_io_desc[] __initdata = {
>>>       {
>>>               .virtual        =  IO_ADDRESS(VERSATILE_SYS_BASE),
>>>               .pfn            = __phys_to_pfn(VERSATILE_SYS_BASE),
>>>               .length         = SZ_4K,
>>>               .type           = MT_DEVICE
>>>       }, {
>>>               .virtual        =  IO_ADDRESS(VERSATILE_SIC_BASE),
>>>               .pfn            = __phys_to_pfn(VERSATILE_SIC_BASE),
>>>               .length         = SZ_4K,
>>>               .type           = MT_DEVICE
>>>       }, {
>>>               .virtual        =  IO_ADDRESS(VERSATILE_VIC_BASE),
>>>               .pfn            = __phys_to_pfn(VERSATILE_VIC_BASE),
>>>               .length         = SZ_4K,
>>>               .type           = MT_DEVICE
>>
>> The SIC and VIC should get converted to ioremap and using of_irq_init.
>> There's already DT init support for the VIC at least, so the conversion
>> should be easy. I think Linus W was working on this.
>>
>> Rob
>>
>>>       }, {
>>> ...
>>>
>>
> 
> 
> 
