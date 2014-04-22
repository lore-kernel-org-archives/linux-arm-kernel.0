From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 22 Apr 2014 16:55:14 -0300
Subject: [PATCH] ARM: Better virt_to_page() handling
In-Reply-To: <E1WTYiT-0007Jl-Fe@rmk-PC.arm.linux.org.uk>
References: <20140328152831.GK7528@n2100.arm.linux.org.uk>
 <E1WTYiT-0007Jl-Fe@rmk-PC.arm.linux.org.uk>
Message-ID: <20140422195514.GA13106@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Mar 28, Russell King wrote:
> -#ifndef __virt_to_phys
> -#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +#if defined(__virt_to_phys)
> +#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> +#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
> +
> +#define virt_to_pfn(kaddr) (__pa(kaddr) >> PAGE_SHIFT)
> +

Building 20140422 -next produces a myriad of these warnings:

  [..]
  CC      fs/mpage.o
In file included from /home/zeta/linux/next/arch/arm/include/asm/page.h:163:0,
                 from include/linux/mmzone.h:20,
                 from include/linux/gfp.h:5,
                 from include/linux/mm.h:9,
                 from fs/mpage.c:17:
/home/zeta/linux/next/arch/arm/include/asm/memory.h:297:0: warning: "virt_to_pfn" redefined [enabled by default]
 #define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
 ^
/home/zeta/linux/next/arch/arm/include/asm/memory.h:194:0: note: this is the location of the previous definition
 #define virt_to_pfn(kaddr) \
 ^

I saw you already answered Nicolas about the double-definition, so I'm merely
reporting the build gets really spammy now. (Although I guess you already
noticed this)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
