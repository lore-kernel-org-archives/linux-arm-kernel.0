From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 18 May 2010 10:54:29 +0800
Subject: Boot interface for device trees on ARM
Message-ID: <201005181054.32325.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As we're getting closer to device tree support on ARM, I'd like to get some 
input on our proposed boot interface.

Basically, I'd like to define how we pass the device tree from the bootloader 
to the kernel.

My current method of doing this is through a new atag. It looks like this:

	/* flattened device tree blob pointer */
	#define ATAG_DEVTREE	0x5441000a

	struct tag_devtree {
		__u32 start;	/* physical start address */
		__u32 size;	/* size of dtb image in bytes */
	};

With ATAG_DEVTREE, we keep the existing boot interface the same (ie, machine 
number in r1, atags pointer r2).

Some notes about this scheme:

 + We can easily keep compatibility with the existing boot interface; both DT 
and non-DT kernels will be supported if a bootloader uses this.

 - It's a little more complex, as the bootloader has to initialise the atags 
structure.

 - If we end up in a situation where most machines are DT-enabled, then we'll 
be carrying a seldom-used structure (ie, a mostly-empty atags block) just to 
provide one pointer to the kernel.

 - We are now potentially carrying data in two different places - atags and 
the device tree. For example, the physical memory layout and kernel command 
line may be present in both.

Nicolas Pitre has suggested that we make it simpler, and specify the device 
tree blob directly instead (and remove the atags). In this case, r2 would 
point to the device tree blob, and r1 would be ignored.

Fortunately, both structures (atags list and device tree blob) begin with a 
magic number, so it is trivial to determine whether the pointer is to an atags 
list or a device tree blob.

Some notes about this scheme:

 - This would break compatibility with the existing boot interface: 
bootloaders that expect a DT kernel will not be able to boot a non-DT kernel. 
However, does this matter? Once the machine support (ie, bootloader and 
kernel) is done, we don't expect to have to enable both methods.

 + A simpler boot interface, so less to do (and get wrong) in the bootloader

 + We don't have two potential sources of boot information

Although I have been using the atag for a while, I have not pushed it to an 
upstream (either qemu or the kernel), as I would like to get a firm decision 
on the best method before making any commitment.

Comments and questions most welcome.

Cheers,


Jeremy
