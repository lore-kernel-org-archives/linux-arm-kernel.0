From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 8 Jan 2017 15:28:28 +0530
Subject: [PATCH WIP 4/4] ARM: remove compile time vector base for CP15 case
In-Reply-To: <20170107182415.GO14217@n2100.armlinux.org.uk>
References: <20170107171339.GA5044@afzalpc>
 <20170107172228.6451-1-afzal.mohd.ma@gmail.com>
 <20170107173832.GN14217@n2100.armlinux.org.uk>
 <20170107180227.GA8130@afzalpc>
 <20170107182415.GO14217@n2100.armlinux.org.uk>
Message-ID: <20170108095828.GA3025@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 07, 2017 at 06:24:15PM +0000, Russell King - ARM Linux wrote:

> As I've said, CONFIG_VECTORS_BASE is _always_ 0xffff0000 on MMU, so
> this always displays 0xffff0000 - 0xffff1000 here.

> Older ARM CPUs without the V bit (ARMv3 and early ARMv4) expect the
> vectors to be at virtual address zero.
> 
> Most of these systems place ROM at physical address 0, so when the CPU
> starts from reset (with the MMU off) it starts executing from ROM.  Once
> the MMU is initialised, RAM can be placed there and the ROM vectors
> replaced.  The side effect of this is that NULL pointer dereferences
> are not always caught... of course, it makes sense that the page at
> address 0 is write protected even from the kernel, so a NULL pointer
> write dereference doesn't corrupt the vectors.
> 
> How we handle it in Linux is that we always map the page for the vectors
> at 0xffff0000, and then only map that same page at 0x00000000 if we have
> a CPU that needs it there.

Thanks for the information, i was not aware, seems that simplifies MMU
case handling.

arch/arm/mm/mmu.c:

	if (!vectors_high()) {
		map.virtual = 0;
		map.length = PAGE_SIZE * 2;
		map.type = MT_LOW_VECTORS;
		create_mapping(&map);
	}



arch/arm/include/asm/cp15.h:

#if __LINUX_ARM_ARCH__ >= 4
#define vectors_high()	(get_cr() & CR_V)
#else
#define vectors_high()	(0)
#endif

Deducing from your reply & above code snippets that for
__LINUX_ARM_ARCH__ >= 4, in all practical cases, vector_high() returns
true

Regards
afzal
