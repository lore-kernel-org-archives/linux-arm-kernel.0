From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 18 May 2010 00:34:45 -0400 (EDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <201005181054.32325.jeremy.kerr@canonical.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
Message-ID: <alpine.LFD.2.00.1005172341200.12758@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 May 2010, Jeremy Kerr wrote:

> Hi all,
> 
> As we're getting closer to device tree support on ARM, I'd like to get some 
> input on our proposed boot interface.
> 
> Basically, I'd like to define how we pass the device tree from the bootloader 
> to the kernel.
> 
> My current method of doing this is through a new atag. It looks like this:
> 
> 	/* flattened device tree blob pointer */
> 	#define ATAG_DEVTREE	0x5441000a
> 
> 	struct tag_devtree {
> 		__u32 start;	/* physical start address */
> 		__u32 size;	/* size of dtb image in bytes */
> 	};
> 
> With ATAG_DEVTREE, we keep the existing boot interface the same (ie, machine 
> number in r1, atags pointer r2).
> 
> Some notes about this scheme:
> 
>  + We can easily keep compatibility with the existing boot interface; both DT 
> and non-DT kernels will be supported if a bootloader uses this.
> 
>  - It's a little more complex, as the bootloader has to initialise the atags 
> structure.
> 
>  - If we end up in a situation where most machines are DT-enabled, then we'll 
> be carrying a seldom-used structure (ie, a mostly-empty atags block) just to 
> provide one pointer to the kernel.
> 
>  - We are now potentially carrying data in two different places - atags and 
> the device tree. For example, the physical memory layout and kernel command 
> line may be present in both.
> 
> Nicolas Pitre has suggested that we make it simpler, and specify the device 
> tree blob directly instead (and remove the atags). In this case, r2 would 
> point to the device tree blob, and r1 would be ignored.

This is almost what I suggested, except for ignoring r1.  More on this 
below.

> Fortunately, both structures (atags list and device tree blob) begin with a 
> magic number, so it is trivial to determine whether the pointer is to an atags 
> list or a device tree blob.
> 
> Some notes about this scheme:
> 
>  - This would break compatibility with the existing boot interface: 
> bootloaders that expect a DT kernel will not be able to boot a non-DT kernel. 
> However, does this matter? Once the machine support (ie, bootloader and 
> kernel) is done, we don't expect to have to enable both methods.

I think that, for the moment, it is best if the bootloader on already 
existing subarchitectures where DT is introduced still preserve the 
already existing ability to boot using ATAGs.  This allows for the 
testing and validation of the DT concept against the legacy ATAG method 
more easily.

On new subarchitectures, it might make sense to go with DT from the 
start instead of creating setup code for every single machine.  In that 
case the bootloader for those machines would only need to care about DT 
and forget about ATAGs.

>  + A simpler boot interface, so less to do (and get wrong) in the bootloader
> 
>  + We don't have two potential sources of boot information

Those last two are IMHO the biggest reasons for not having both ATAGs 
and DT at the same time.  Otherwise the confusion about which one is 
authoritative, which one has precedence over the other, and/or whether 
the information should be obtained from one structure if it is missing 
from the other will simply bite us eventually for sure, as bootloader 
writers will get sloppy/lazy and have it wrong.  I strongly suggest that 
we should specify that the kernel must consider either ATAGs _or_ a 
device tree, and that the bootloader must pass only one of them.

[ I also insist on the ability for the DT info to be extractable and 
  updatable at the bootloader level, and not hardcoded into the
  bootloader itself. But that's another topic for discussion. ]

> Although I have been using the atag for a while, I have not pushed it to an 
> upstream (either qemu or the kernel), as I would like to get a firm decision 
> on the best method before making any commitment.
> 
> Comments and questions most welcome.

My suggestion is to have the DT support to be considered just as another 
machine _within_ each subarchitecture.  This means that a machine ID 
could be registered for DT on PXA, another for DT on OMAP, another for 
DT on Dove, etc.  This way, the DT support can be developed in parallel 
to the existing machine support code.  So if for example you want to 
test DT for Kirkwood then you may boot the kernel passing the ID for DT 
on Kirkwood into r1 and provide the DT corresponding to, say, a 
SheevaPlug.  Or you may decide to boot the same kernel binary and use 
the legacy SheevaPlug machine ID instead.  In theory both methods should 
be equivalent, baring any bugs.

Why one DT machine ID per subarchitecture?  Simply because a significant 
part of the DT handling code will have to be subarchitecture specific 
anyway.  The timer hardware, the GPIO configuration and muxing, SOC 
specific platform data handling, power management config, and many other 
things are simply too different from one SOC family to another and 
trying to have a single global DT support code to rule them all is 
insane.  At least with the concept of a "virtual" machine definition for 
DT per subarchitecture, the problem can easily be split and just fits 
naturally into the existing model on ARM.

This means that, over time, the machine ID registration would simply 
transition from a per machine thing to a per subarchitecture / SOC 
family thing.  And once the DT support is introduced for a given SOC 
family, then new machines using that SOC should be able to reuse 
the existing kernel binary for that SOC simply by providing a new DT 
data for the existing kernel to consume.

[ There is also the issue of being able to support multiple SOC families 
  within the same kernel binary, but that's something that could be done 
  with or without the device tree, and has issues of its own that the DT 
  cannot solve. Hence this is orthogonal to DT and a topic for yet another
  discussion. ]


Nicolas
