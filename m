From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 7 Aug 2012 14:13:29 -0400
Subject: [PATCH v2 04/23] xen/arm: sync_bitops
In-Reply-To: <1344263246-28036-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
 <1344263246-28036-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120807181329.GH15053@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 03:27:07PM +0100, Stefano Stabellini wrote:
> sync_bitops functions are equivalent to the SMP implementation of the
> original functions, independently from CONFIG_SMP being defined.
> 
> We need them because _set_bit etc are not SMP safe if !CONFIG_SMP. But
> under Xen you might be communicating with a completely external entity
> who might be on another CPU (e.g. two uniprocessor guests communicating
> via event channels and grant tables). So we need a variant of the bit
> ops which are SMP safe even on a UP kernel.

Ack from me.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  arch/arm/include/asm/sync_bitops.h |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/sync_bitops.h
> 
> diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
> new file mode 100644
> index 0000000..63479ee
> --- /dev/null
> +++ b/arch/arm/include/asm/sync_bitops.h
> @@ -0,0 +1,27 @@
> +#ifndef __ASM_SYNC_BITOPS_H__
> +#define __ASM_SYNC_BITOPS_H__
> +
> +#include <asm/bitops.h>
> +#include <asm/system.h>
> +
> +/* sync_bitops functions are equivalent to the SMP implementation of the
> + * original functions, independently from CONFIG_SMP being defined.
> + *
> + * We need them because _set_bit etc are not SMP safe if !CONFIG_SMP. But
> + * under Xen you might be communicating with a completely external entity
> + * who might be on another CPU (e.g. two uniprocessor guests communicating
> + * via event channels and grant tables). So we need a variant of the bit
> + * ops which are SMP safe even on a UP kernel.
> + */
> +
> +#define sync_set_bit(nr, p)		_set_bit(nr, p)
> +#define sync_clear_bit(nr, p)		_clear_bit(nr, p)
> +#define sync_change_bit(nr, p)		_change_bit(nr, p)
> +#define sync_test_and_set_bit(nr, p)	_test_and_set_bit(nr, p)
> +#define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
> +#define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
> +#define sync_test_bit(nr, addr)		test_bit(nr, addr)
> +#define sync_cmpxchg			cmpxchg
> +
> +
> +#endif
> -- 
> 1.7.2.5
