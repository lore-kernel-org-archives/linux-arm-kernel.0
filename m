From: monstr@monstr.eu (Michal Simek)
Date: Wed, 13 Feb 2013 16:52:50 +0100
Subject: [PATCH 1/2] arm: mm: Ignore memory banks which are in front of
 the kernel when HIGHMEM is ON
In-Reply-To: <20130213145208.GC17833@n2100.arm.linux.org.uk>
References: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
 <20130213090317.GY17833@n2100.arm.linux.org.uk>
 <CAHTX3dLy=t43+oNXMrsdz1_5AGf6==z=vG7K8V6dSG0tm6U4=g@mail.gmail.com>
 <20130213145208.GC17833@n2100.arm.linux.org.uk>
Message-ID: <CAHTX3dJXtx5V2SN4Wd7mrnhUzMyK86vT_h_xLOzmQKGo3rcDqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Feb 13, 2013 at 03:39:21PM +0100, Michal Simek wrote:
>> ok. Can you describe me this configuration? Enough to tell me dts memory
>> fragment and kernel load addr which match this case.
>
> Anything which uses more than 1GB of memory and has PAGE_OFFSET set at
> 0xc0000000 (3GB).  Simple maths will tell you that, and why it fails.
>
> Look:
> - if __va(bank->start) = PAGE_OFFSET, and PAGE_OFFSET is at 3GB.
> - if bank->size = 1GB (which we _do_ have), then
>      __va(bank->start + bank->size) = 4GB.  4GB represented as a 32-bit
>   pointer is NULL.  NULL < (void *)PAGE_OFFSET.
>
> Therefore, your patch will cause systems with 1GB or more of memory in
> one bank to ignore _all_ the memory passed in.
>
> And if you look at the code:
>
>                 if (__va(bank->start) >= vmalloc_min ||
>                     __va(bank->start) < (void *)PAGE_OFFSET)
>                         highmem = 1;
>
> notice the facy that we're marking all memory starting with an apparant
> virtual address outside of PAGE_OFFSET...vmalloc_min as highmem.  This is
> to catch cases exactly like this.
>
> Memory for which __va(bank->start) < (void *)PAGE_OFFSET will also have
> __va(bank->start + bank->size - 1) (in your patch) also below PAGE_OFFSET,
> and your modification will cause the kernel to ignore this memory -
> which is not acceptable.

ok - that's fair.


> I don't think there's much option for solutions to this; not with a common
> kernel designed to run on multiple platforms.  If a platform doesn't
> conform to the Linux requirements for a common kernel, then it doesn't
> conform and it can't use it.

I have no problem to admit that this patch is wrong in this implementation
but I tend to disagree with this part.
The Linux kernel has some requirements, limitations, etc,  that's all truth.

Placing the kernel to the main memory to any location you want which end
up with kernel panic is from my point of view fault.
Saying that the kernel is always loaded withing the 16MB of memory is limitation
but it doesn't mean that we shouldn't remove it.

Ignoring the memory before the kernel can be one solution which I
would like to discuss.
What about the second patch used for !HIGHMEM case?

> In much the same way that we ended up saying "no" to people who wanted
> to place two physical banks of memory in reverse order in the virtual
> mapping, I think this is another case of "no, we can't permit this with
> common cross-subarch kernels".

This case should probably end up on device-tree rule (+dtc fault).
Not sure if memory banks should be ordered or not. Rob and Grant any thought?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
