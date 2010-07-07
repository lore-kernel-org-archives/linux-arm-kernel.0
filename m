From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Jul 2010 08:56:22 +0100
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on S5PV210/S5PC110.
In-Reply-To: <013001cb1d62$de72ff30$9b58fd90$%kim@samsung.com>
References: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
	<20100706071245.GA5058@n2100.arm.linux.org.uk>
	<013001cb1d62$de72ff30$9b58fd90$%kim@samsung.com>
Message-ID: <20100707075622.GA21830@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 07, 2010 at 08:27:53AM +0900, Kukjin Kim wrote:
> Russell King wrote:
> > What is the spacing of chunks of memory, and minimum alignment of those
> > chunks in physical address space?
> 
> Some S5PC110(MCP D-type) has only available 80MiB in a bank.
> So the space accounts for 432MiB in a DMC0, but larger memory(256MiB +
> 128MiB) exists in a DMC1.

Ok.

> As you know, the size of a section should be a power of 2 and a physical
> address space of a section should be contiguous.
> If a section size is greater than 16MiB, a section have a hole. So the
> SECTION_SIZE_BITS should be 16MiB.

Where is this hole?  Please show it as a diagram similar to the one
you've produced below.

> > Also, what is the maximum physical address which memory can be located?
> 
> Following is memory map of S5PV210/S5PC110.
> 
> 0x80000000  -------------------
>             |          |
> 0x70000000  |          |
>             |          |
> 0x60000000  |  DMC 1  |  up to 1GiB
>             |          |
> 0x50000000  |          |
>             |          |
> 0x40000000  ----------------- 
>             |          |
> 0x30000000  |  DMC 0  |  up to 512MiB
>             |          |
> 0x20000000  -------------------

Right, so MAX_PHYSMEM_BITS is 31 and not 32 as you don't have memory
at or above 0x80000000.  This will immediately halve the amount of
sparsemem supporting structures irrespective of the SECTION_SIZE_BITS
value.
