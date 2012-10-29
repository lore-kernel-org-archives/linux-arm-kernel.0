From: zonque@gmail.com (Daniel Mack)
Date: Mon, 29 Oct 2012 18:22:15 +0100
Subject: Representation of external memory-mapped devices in DT (gpmc)
In-Reply-To: <508E9C42.10907@gmail.com>
References: <508E9513.7050106@gmail.com> <508E9C42.10907@gmail.com>
Message-ID: <508EBB47.8070405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.10.2012 16:09, Rob Herring wrote:
> On 10/29/2012 09:39 AM, Daniel Mack wrote:
>> Hi,
>>
>> we're currently working on a DT binding for the GPMC bus that is found
>> on SoCs by TI. The implementation is based on CS lines and an 8, 16 or
>> 32 bit parallel interface. That IP is quite flexible, and it can for
>> example be used for physmap flash, external peripherals or even NAND.
>>
>> Depending on which CS is used to control the device, different memory
>> regions are reserved, and there's code to calculate the location and
>> size of them, given a CS number (see arch/arm/mach-omap2/gpmc.c).
> 
> I don't know the details of the h/w, but I would think the DT core code
> should be able work out the addresses. This can be done using ranges
> property which defines the mapping of a child bus into the parent bus
> addresses.

In this case, the controller is @0x50000000 while the external device is
mapped to address 0x0.

>> The binding will use one top-level node to describe the GPMC controller
>> itself and register the actual devices as sub-nodes to it. The NAND type
>> is the only one that is currently supported. This is how it currently looks:
>>
>> 	gpmc: gpmc at 50000000 {
>> 		compatible = "ti,gpmc";
>> 		ti,hwmods = "gpmc";
>> 		reg = <0x50000000 0x2000>;
>> 		interrupt-parent = <&intc>;
>> 		interrupts = <100>;
>> 		#address-cells = <1>;
>> 		#size-cells = <0>;
>>
>> 		nand at 0 {
> 
> You may want a CS0 node with nand as a child node of that.

Hmm, I don't see what that would buy us. The question is which way is
feasible for storing both the memory region and the cs number in the
device tree. The CS number should certainly go to the child node, no?

IOW, would it be a good idea to have something like the following layout?

	gpmc: gpmc at 50000000 {
		compatible = "ti,gpmc";
		ti,hwmods = "gpmc";
		reg = <0x50000000 0x2000>;

		/* cs-reg stores the setup of the controller's
		   memory map */

			/* offset	size */
		cs-reg = <0x0		0x1000000
			  ....		.....
			  ....		.....>;

		nand: child at 0 {
			/* timings */
			/* peripheral specifics */
		};
	};

I would actually much prefer that approach.

Afzal, because because that way, we can leave the code as-is for now and
add the "cs-reg" property once the code is switched to dynamic handling.
What do you think?


Thanks,
Daniel
