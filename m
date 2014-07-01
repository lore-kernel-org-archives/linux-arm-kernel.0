From: loeliger@gmail.com (Jon Loeliger)
Date: Tue, 1 Jul 2014 12:41:36 -0500
Subject: Some Large Address Space Ponders on A9
In-Reply-To: <20140701162620.GB18309@arm.com>
References: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
 <20140701162620.GB18309@arm.com>
Message-ID: <CAJgR-BjmDo9HiLqnnDmAabVCXHZCTwvZ9unfLNC_FbyKv+bn7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 11:26 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:

>> Here's the problem.  Over in include/linux/types.h we find:
>>
>>     #ifdef CONFIG_PHYS_ADDR_T_64BIT
>>     typedef u64 phys_addr_t;
>>     #else
>>     typedef u32 phys_addr_t;
>>     #endif
>>
>>     typedef phys_addr_t resource_size_t;
>
> I won't comment on how you define this in DT but for the kernel things
> will likely break when you increase phys_addr_t to 64-bit on non-LPAE
> builds.
>
> First (only) question - how do you intend to map such physical address?
> The only way I'm aware of on A9 is using supersections and the ARM Linux
> port provides __arm_ioremap_pfn(). However, the supersections code is
> only enabled if !SMP.
>
> --
> Catalin

So, I don't really need to map in that as physical address space
that will be actually accessed.  I need to be able to parse the
large values out of the DT (2-cell values) into resource_size_t
variables and then manipulate the address space they represent.
Later, my IP block can handle the larger addresses, not as physical
memory, but as addresses.  I guess you could think of it as a
windowing or address translation mechanism that isn't coming
from the A9's 32-bit AXI bus.

Does that help explain the weird?  Or just confuse it? :-)

jdl
