From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Sep 2012 14:03:34 +0100
Subject: [RFC PATCH 1/6] ARM: mm: define LoUIS API for cache
 maintenance ops
In-Reply-To: <20120913113949.GC2470@linaro.org>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913113949.GC2470@linaro.org>
Message-ID: <20120913130334.GI28448@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 12:39:49PM +0100, Dave Martin wrote:
> We could introduce something like CONFIG_ARM_HAVE_CACHEFLUSH_LOUIS, and
> do:
> 
> <asm/glue-cache.h>
> #ifndef MULTI_CACHE
> #ifdef CONFIG_HAVE_ARM_CACHEFLUSH_LOUIS
> #define __cpuc_flush_kern_cache_louis __glue(_CACHE,_flush_kern_cache_louis)
> #else
> #define __cpuc_flush_kern_cache_louis __glue(_CACHE,_flush_kern_all)
> #endif
> #endif
> 
> <asm/cacheflush.h>
> #ifdef MULTI_CACHE
> #define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
> #else
> #define flush_cache_louis()   __cpuc_flush_kern_cache_louis()
> #endif

No, this is stupidly complicated and is fragile.  Just alias the
functions, like we do in cache-v4wt.S:

	.globl	v4wt_dma_flush_range
	.equ	v4wt_dma_flush_range, v4wt_dma_inv_range

except, you'll need:

	.globl	v4wt_flush_kern_cache_louis
	.equ	v4wt_flush_kern_cache_louis, v4wt_flush_kern_cache_all

You can do it automatically, using the attached sedscript and this bit
of shell:

$ for f in $(grep -l define_cache_functions arch/arm/mm/*.S ); do
    sed -if sedscript $f
    git add $f
done
$ git commit -s

Do that first, and then go over those which you need to add a real
flush_kern_cache_louis function to.

-------------- next part --------------
1,/__INITDATA\|define struct cpu_cache_fns/ {
	/ENTRY.*flush_kern_cache_all/ {
        	h
	        s/.*(\([^_]*\)_.*/\t.globl\t\1_flush_kern_cache_louis\n\t.equ\t\1_flush_kern_cache_louis, \1_flush_kern_cache_all\n/
        	x
	}
	/__INITDATA\|define struct cpu_cache_fns/ {
        	H
	        g
	}
}
