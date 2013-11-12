From: monstr@monstr.eu (Michal Simek)
Date: Tue, 12 Nov 2013 16:24:46 +0100
Subject: Physical memory start contraints in the Linux kernel  (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <20131112132001.GJ16735@n2100.arm.linux.org.uk>
References: <osstest-21486-mainreport@xen.org>
 <1383731526.26213.25.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061111580.26077@kaball.uk.xensource.com>
 <1383736784.26213.72.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061938080.26077@kaball.uk.xensource.com>
 <1383822868.26213.181.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311111825090.26077@kaball.uk.xensource.com>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <20131112132001.GJ16735@n2100.arm.linux.org.uk>
Message-ID: <5282483E.1000101@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 02:20 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 12, 2013 at 12:25:18PM +0000, Stefano Stabellini wrote:
>> Arnd, Olof,
> 
> This isn't really an arm-soc thing, it's a core ARM thing...
> 
>> we have been having this discussion on xen-devel regarding whether Xen
>> should be allowed to modify the start address of the physical memory
>> region in device tree before passing it to dom0 or not.
>>
>> The reason why this question is coming up now, is that we realized that
>> we are going to have to live with the 1:1 pseudo-physical to physical
>> mapping for dom0 for a while. This limits the ability of the hypervisor
>> of allocating dom0 memory wherever it wants. Xen can allocate dom0
>> memory from the low end but maybe not exactly from the start.
>>
>> As a result we would adjust the start of physical memory in device tree
>> to match the start of the memory region allocated for dom0. For example
>> on the Arndale it could be 0x80800000 instead of 0x80000000.
>>
>> Unfortunately not all the platforms can cope with this very well. In
>> particular the Arndale seems to have issues.
> 
> That should be no problem provided that:
> 
> (a) you load the kernel somewhere between 0x80800000 and 0x80ffffff -
> the decompressor will decide that the start of memory is 0x80800000, and
> place the kernel at 0x80808000.
> (b) _at the moment_ you modify DT to specify that memory starts at
> 0x80800000 and not 0x80000000.
> 
> (b) is going to change soon: the shmobile and zynq platforms already have
> a problem with their memory setup which needs a patch in this area, and
> the patch will have the side effect of automatically removing (in your
> case) 0x80000000 to 0x80800000.  See the patch below.

I wouldn't say problem here - just use case where we want/need to ignore
the part of memory. The patch below works nicely for us.

> 
> If there's any other issues with multiplatform, then yes, we want to hear
> about them.
> 
>  arch/arm/kernel/setup.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index f52150d2ec00..1957d54198ad 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -660,6 +660,17 @@ int __init arm_add_memory(u64 start, u64 size)
>  	}
>  #endif
>  
> +	if (aligned_start < PHYS_OFFSET) {
> +		if (aligned_start + size < PHYS_OFFSET) {

just a note I sent to Russell. Here should be "<=" instead of just "<"

> +			pr_info("Ignoring memory below PHYS_OFFSET: 0x%08llx-0x%08llx\n",
> +				aligned_start, aligned_start + size);
> +			return -EINVAL;
> +		}
> +
> +		size -= PHYS_OFFSET - aligned_start;
> +		aligned_start = PHYS_OFFSET;

We should printk a message here to be aware that alignment was done.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131112/7042b660/attachment.sig>
