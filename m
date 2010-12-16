From: npiggin@kernel.dk (Nick Piggin)
Date: Thu, 16 Dec 2010 13:41:46 +1100
Subject: [PATCH v2] include/linux: Add missing include / fix build failure
In-Reply-To: <201012160040.54313.PeterHuewe@gmx.de>
References: <201012152204.18881.PeterHuewe@gmx.de>
	<20101216103141.6f0a418c.sfr@canb.auug.org.au>
	<201012160040.54313.PeterHuewe@gmx.de>
Message-ID: <20101216024146.GA3537@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for this.

On Thu, Dec 16, 2010 at 12:40:54AM +0100, Peter H?we wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch fixes a build failure[1-2] by adding the missing asm/memory.h
> include needed for arch_is_coherent().
> 
> Error message:
> In file included from include/linux/list_bl.h:5,
>                  from include/linux/rculist_bl.h:7,
>                  from include/linux/dcache.h:7,
>                  from include/linux/fs.h:381,
>                  from arch/arm/mm/mmap.c:4:
> include/linux/bit_spinlock.h: In function 'bit_spin_unlock':
> include/linux/bit_spinlock.h:61: error: implicit declaration of function 
> 'arch_is_coherent'
> 
> KernelVersion: linux-next-20101215
> Used configs: hackkit_defconfig (arm), ep93xx_defconfig (arm)
> 
> References:
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/3651495/
> [2] http://kisskb.ellerman.id.au/kisskb/buildresult/3651425/
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> v2:
> moved additional information in the commit message.
> 
>  include/linux/bit_spinlock.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index e612575..053fad7 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -4,6 +4,7 @@
>  #include <linux/kernel.h>
>  #include <linux/preempt.h>
>  #include <asm/atomic.h>
> +#include <asm/memory.h>
>  
>  /*
>   *  bit-based spin_lock()

The problem is actually in ARM's asm/atomic.h file -- they declare the
smp_mb__before_clear_bit() etc. without providing the necessary includes
to actually call it. Can you include asm/memory.h in there?

Thanks,
Nick
