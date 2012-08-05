From: cyril@ti.com (Cyril Chemparathy)
Date: Sun, 5 Aug 2012 11:10:34 -0400
Subject: [PATCH 00/22] Introducing the TI Keystone platform
In-Reply-To: <20120804083945.GB6802@n2100.arm.linux.org.uk>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <20120804083945.GB6802@n2100.arm.linux.org.uk>
Message-ID: <501E8CEA.9050601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 8/4/2012 4:39 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2012 at 07:04:36PM -0400, Cyril Chemparathy wrote:
>> This series is a follow on to the RFC series posted earlier (archived at [1]).
>> The major change introduced here is the modification to the kernel patching
>> mechanism for phys_to_virt/virt_to_phys, in order to support LPAE platforms
>> that require late patching.  In addition to these changes, we've updated the
>> series based on feedback from the earlier posting.
>>
>> Most of the patches in this series are fixes and extensions to LPAE support on
>> ARM. The last three patches in this series are specific to the TI Keystone
>> platform, and are being provided here for the sake of completeness.  These
>> three patches are dependent on the smpops patch set (see [2]), and are not
>> ready to be merged in as yet.
>
> Can you explain why you want the kernel loaded above the 4GB watermark?
> This seems silly to me, as the kernel needs to run at points with a 1:1
> physical to virtual mapping, and you can't do that if the kernel is
> stored in physical memory above the 4GB watermark.
>

The Keystone family of devices is built to run with large (>8G) physical 
memory for certain use-cases.  From the CPUs perspective, this entire 
range of physical memory is mapped in linearly at 08:0000:0000, i.e., 
above the 4GB watermark.

The interconnect provides an aliased view of the first 2GB of this 
memory at the 8000:0000 offset.  This alias is intended primarily for 
boot-time usage, and does not support DMA coherence.  We considered the 
option of running with the first 2G of memory located under the 4GB 
watermark, and the rest located at the native >4GB location, but this 
would necessitate sparsemem, and would also break DMA coherence out of 
lowmem.  Hence the need for the more complicated approach implemented in 
this patch series.


The posted patch series manages to get an SMP system running out of 
memory beyond the 4GB watermark.  We identified a couple of places that 
needed the 1:1 physical to virtual mapping, and for these we take 
advantage of the alias view provided by the interconnect.  The two 
places that we found the need for 1:1 mapping were:

1. initial boot code in head.S:  here we've taken the approach of 
initially running out of the alias space, and then switching over to the 
high address space once we are safely in machine-specific territory.

2. idmap for secondary CPU boot:  here we've added a virt_to_idmap() 
facility that our sub-architecture then overrides to express the 
interconnect supported alias view.


We are well aware of the fact that we are barely scratching the surface 
of the problem space here, and we'd be very thankful for a heads up on 
issues that we may have missed so far.  We would similarly appreciate 
other better ideas to solve this problem in light of the unique 
constraints imposed here.

-- 
Thanks
- Cyril
