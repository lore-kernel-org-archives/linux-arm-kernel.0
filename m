From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Feb 2015 16:24:53 -0600
Subject: [PATCH v2] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <1424907152-18808-1-git-send-email-mathieu.poirier@linaro.org>
References: <1424907152-18808-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CAL_Jsq+JYc5DBXqEcpJ0O=RdO-uuz_-GR99YsgVqT=uG6CLqJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Will D...

On Wed, Feb 25, 2015 at 5:32 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> From: Pratik Patel <pratikp@codeaurora.org>
>
> This driver adds support for the STM CoreSight IP block,
> allowing any system compoment (HW or SW) to log and
> aggregate messages via a single entity.
>
> The STM exposes an application defined number of channels
> called stimulus port.  Configuration is done using entries
> in sysfs and channels made available to userspace via devfs.
>
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> Changes for v2:
>  - Fixed typo in struct stm_node documentation
>  - Added CPU_32v3 to list of architecture STM can't work with

Is this because of no strd instr only?

> +#ifndef CONFIG_64BIT
> +static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> +{
> +       asm volatile("strd %1, %0"
> +                    : "+Qo" (*(volatile u64 __force *)addr)
> +                    : "r" (val));
> +}
> +#undef writeq_relaxed
> +#define writeq_relaxed(v, c)   __raw_writeq((__force u64) cpu_to_le64(v), c)
> +#endif

We really shouldn't do private implementation here. It there really
any reason not to allow readq/writeq generically for 32-bit or just
for arm32?

Rob
