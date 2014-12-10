From: mpeg.blue@free.fr (Mason)
Date: Wed, 10 Dec 2014 10:41:24 +0100
Subject: ARM page tables
In-Reply-To: <20141210001632.GL11285@n2100.arm.linux.org.uk>
References: <54872F9C.2080005@free.fr>
 <20141209172729.GK11285@n2100.arm.linux.org.uk> <54877ECA.6050501@free.fr>
 <20141210001632.GL11285@n2100.arm.linux.org.uk>
Message-ID: <54881544.8040302@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russel,

Russell King wrote:

> Mason wrote:
>  
>> What's the name of the address of the page table?
>
> swapper_pg_dir

Got it.
arch/arm/kernel/head.S

/*
  * swapper_pg_dir is the virtual address of the initial page table.
  */
.equ  swapper_pg_dir, KERNEL_RAM_VADDR - PG_DIR_SIZE

#define KERNEL_RAM_VADDR (PAGE_OFFSET + TEXT_OFFSET)

PAGE_OFFSET = 0xC0000000
TEXT_OFFSET = $(textofs-y) = 0x00008000
PG_DIR_SIZE = 0x4000

Thus, in my case, swapper_pg_dir = 0xC0004000

> As we can see above, you asked for 0x00200000 bytes to be mapped from
> 0xf0800000.  So, 0xf0800000 to 0xf09fffff will be mapped.  The address
> which you are accessing falls within this range.
>
> So, there's a valid mapping.  Assuming nothing on the bus raises an
> external abort, accesses to this address will succeed.

I was looking so hard for the tree, that I completely missed the forest.
Thanks for clearing my confusion.

By the way, wrt to the thread "Creating 16 MB super-sections for MMIO".
I'm thinking of writing a quick-and-dirty patch to test the impact on
our SoC of using a super-section for the 0-16MB region. Would there be
any interest in mainlining that?

Regards.
