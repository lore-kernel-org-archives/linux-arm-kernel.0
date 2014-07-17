From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 13:01:22 +0100
Subject: [PATCH v3 1/3] asm-generic/io.h: Implement generic
 {read,write}s*()
In-Reply-To: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140717120122.GG18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 12:01:22PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently driver writers need to use io{read,write}{8,16,32}_rep() when
> accessing FIFO registers portably. This is bad for two reasons: it is
> inconsistent with how other registers are accessed using the standard
> {read,write}{b,w,l}() functions, which can lead to confusion. On some
> architectures the io{read,write}*() functions also need to perform some
> extra checks to determine whether an address is memory-mapped or refers
> to I/O space. Drivers which can be expected to never use I/O can safely
> use the {read,write}s{b,w,l,q}(), just like they use their non-string
> variants and there's no need for these extra checks.
> 
> This patch implements generic versions of readsb(), readsw(), readsl(),
> readsq(), writesb(), writesw(), writesl() and writesq(). Variants of
> these string functions for I/O accesses (ins*() and outs*() as well as
> ioread*_rep() and iowrite*_rep()) are now implemented in terms of the
> new functions.
> 
> Going forward, {read,write}{,s}{b,w,l,q}() should be used consistently
> by drivers for devices that will only ever be memory-mapped and hence
> don't need to access I/O space, whereas io{read,write}{8,16,32}_rep()
> should be used by drivers for devices that can be either memory-mapped
> or I/O-mapped.
> 
> While at it, also make sure that any of the functions provided as
> fallback for architectures that don't override them can't be overridden
> subsequently.
> 
> This is compile- and runtime-tested on 32-bit and 64-bit ARM and compile
> tested on Microblaze, s390, SPARC and Xtensa. For ARC, Blackfin, Metag,
> OpenRISC, Score and Unicore32 which also use asm-generic/io.h I couldn't
> find or build a cross-compiler that would run on my system. But by code
> inspection they shouldn't break with this patch.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
