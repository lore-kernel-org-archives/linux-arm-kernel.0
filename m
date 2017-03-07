From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 Mar 2017 07:41:49 +0000
Subject: [PATCH] irqchip/gic-v3: Fix GICD_CTLR_ARE_NS bit field
In-Reply-To: <1488859625-7532-1-git-send-email-alim.akhtar@samsung.com> (Alim
 Akhtar's message of "Tue, 7 Mar 2017 09:37:05 +0530")
References: <CGME20170307041023epcas5p1229831d4cc8541e6c35914508e6e01f0@epcas5p1.samsung.com>
 <1488859625-7532-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <87lgsh1qki.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07 2017 at  4:07:05 am GMT, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> From: Alim Akhtar <alim.akhtar@gmail.com>
>
> As per GICv3 Architecture specification 8.9.4 field descriptions,
> GICD_CTLR_ARE_NS is bit[5]. This patch correct the same.
>
> Fixes: 021f6537 ("irqchip: gic-v3: Initial support for GICv3")
> Cc: stable at vger.kernel.org
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  include/linux/irqchip/arm-gic-v3.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index e808f8a..4aaf639 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -57,7 +57,7 @@
>  
>  #define GICD_CTLR_RWP			(1U << 31)
>  #define GICD_CTLR_DS			(1U << 6)
> -#define GICD_CTLR_ARE_NS		(1U << 4)
> +#define GICD_CTLR_ARE_NS		(1U << 5)
>  #define GICD_CTLR_ENABLE_G1A		(1U << 1)
>  #define GICD_CTLR_ENABLE_G1		(1U << 0)

No, the issue is much more subtle.

- When the access is secure in a system that supports two security
  states, this is bit[5] indeed.

- When the access is non-secure in a system that supports two security
  states, this is bit[4] (so that software written for a single security
  mode can run on both side of the security fence).

- In a system that only supports a single security state, this is bit[4]
  too.

Given that Linux is only designed to run on the non-secure side (at
least when paired with GICv3), I stand by my original bit layout.

Thanks,

        M.
-- 
Jazz is not dead, it just smell funny.
