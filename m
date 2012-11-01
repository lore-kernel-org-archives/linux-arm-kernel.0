From: zonque@gmail.com (Daniel Mack)
Date: Thu, 01 Nov 2012 01:08:28 +0100
Subject: Representation of external memory-mapped devices in DT (gpmc)
In-Reply-To: <508FB10D.9030906@ti.com>
References: <508E9513.7050106@gmail.com> <508E9C42.10907@gmail.com>
 <508EBB47.8070405@gmail.com> <508FB10D.9030906@ti.com>
Message-ID: <5091BD7C.7040105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.10.2012 11:50, Afzal Mohammed wrote:
> Hi Daniel,
> 
> On Monday 29 October 2012 10:52 PM, Daniel Mack wrote:
>> On 29.10.2012 16:09, Rob Herring wrote:
> 
>>> You may want a CS0 node with nand as a child node of that.
> 
>> Hmm, I don't see what that would buy us. The question is which way is
>> feasible for storing both the memory region and the cs number in the
>> device tree. The CS number should certainly go to the child node, no?
>>
>> IOW, would it be a good idea to have something like the following layout?
>>
>> 	gpmc: gpmc at 50000000 {
>> 		compatible = "ti,gpmc";
>> 		ti,hwmods = "gpmc";
>> 		reg =<0x50000000 0x2000>;
>>
>> 		/* cs-reg stores the setup of the controller's
>> 		   memory map */
>>
>> 			/* offset	size */
>> 		cs-reg =<0x0		0x1000000
>> 			  ....		.....
>> 			  ....		.....>;
>>
>> 		nand: child at 0 {
>> 			/* timings */
>> 			/* peripheral specifics */
>> 		};
>> 	};
>>
>> I would actually much prefer that approach.
>>
>> Afzal, because because that way, we can leave the code as-is for now and
>> add the "cs-reg" property once the code is switched to dynamic handling.
>> What do you think?
> 
> I don't know what to say, don't have a good grasp on DT to give
> right suggestion.
> 
> It seems offset field may not be necessary. memory for connected
> peripherals is not fixed, only CS is fixed (as CS pin is hard-wired).
> Physical memory can be anywhere between 0-512MB (with
> alignment constraints depending on size, refer GPMC_CONFIG7
> register), even though right now memory region for peripheral
> seems to be fixed (for boards supported in mainline it will be
> what bootloader configures), it is possible to have it in a different
> region for those peripherals.

The question is whether this is transparent to the client driver at the
end. If the driver needs to know about the address of the external
memory (that's the case for the smsx911x for example), that value should
be in the device tree.

Actually, there's an example here that matches our case quite well:

http://devicetree.org/Device_Tree_Usage#Ranges_.28Address_Translation.29

I think the important part is to get the bindings straight so we don't
have to change them anymore later on; we don't really need to parse the
values from the generic driver and set up the mappings accrodingly -
that can be added easily later on. For a first shot, we can just write
default values to the DT that are computed anyway, right?



Daniel
