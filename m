From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Feb 2016 14:26:31 +0000
Subject: [PATCH 2/9] ARM: change NR_IPIS to 8
In-Reply-To: <1455804123-2526139-3-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-3-git-send-email-arnd@arndb.de>
Message-ID: <56C5D497.7030309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 18/02/16 14:01, Arnd Bergmann wrote:
> When function tracing for IPIs is enabled, we get a warning for an
> overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> as triggered by raise_nmi():
> 
> arch/arm/kernel/smp.c: In function 'raise_nmi':
> arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
>   trace_ipi_raise(target, ipi_types[ipinr]);
> 
> This is a correct warning as we actually overflow the array here.
> To make the tracing work correctly, this extends the array by one
> entry and increases NR_IPI accordingly.
> 
> This only works after patch e7273ff49acf ("ARM: 8488/1: Make
> IPI_CPU_BACKTRACE a "non-secure" SGI"), which changed the number
> assignment from '15' to '8'. If we decide to backport this patch
> to stable kernels, we probably need to backport e7273ff49acf
> as well.

I may actually have made the bug worse in 89d798b ("ARM: 8487/1: Remove
IPI_CALL_FUNC_SINGLE"), which changed NR_IPI from 8 to 7. It would need
to be backported as well (as otherwise we don't have a free non-secure
IP slot).

> 
> As far as I can tell, the problem has existed since the tracepoints
> were originally added, but it only triggered a gcc warning with the
> later change to NR_IPIS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
> Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
