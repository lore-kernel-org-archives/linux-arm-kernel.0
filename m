From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Jul 2014 17:26:20 +0100
Subject: Some Large Address Space Ponders on A9
In-Reply-To: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
References: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
Message-ID: <20140701162620.GB18309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 10:59:45AM -0500, Jon Loeliger wrote:
> I have a classic Cortex A9 based SoC in which I will need to
> do some device driver development that will be capable of
> addressing a physical address space larger than 32-bits.
> I understand that the A9 doesn't support LPAE and that
> pretending that it does and config'ing LPAE "on" will just
> break six-ways-to-hell.
> 
> But I need to be able to specify some 64-bit addresses in
> the Device Tree, and allow my device driver to manipulate
> 64-bit resource_size_t ranges.
> 
> Here's the problem.  Over in include/linux/types.h we find:
> 
>     #ifdef CONFIG_PHYS_ADDR_T_64BIT
>     typedef u64 phys_addr_t;
>     #else
>     typedef u32 phys_addr_t;
>     #endif
> 
>     typedef phys_addr_t resource_size_t;

I won't comment on how you define this in DT but for the kernel things
will likely break when you increase phys_addr_t to 64-bit on non-LPAE
builds.

First (only) question - how do you intend to map such physical address?
The only way I'm aware of on A9 is using supersections and the ARM Linux
port provides __arm_ioremap_pfn(). However, the supersections code is
only enabled if !SMP.

-- 
Catalin
