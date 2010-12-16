From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 16 Dec 2010 13:58:07 +0530
Subject: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc
	handling
In-Reply-To: <1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTi=RE3ZEuoe=jMRLiFZ7iVgvuXMrgqfXMAYa92=z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 12:17, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Use runtime pm APIs to enable/disable mailbox clocks and
> to configure SYSC register.
>
> Based on the patch sent by Felipe Contreras:
> https://patchwork.kernel.org/patch/101662/
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> ?arch/arm/mach-omap2/mailbox.c | ? 27 +++++----------------------
> ?1 files changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 40ddeca..f5f72ba 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -14,6 +14,7 @@
> ?#include <linux/err.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> ?#include <plat/mailbox.h>
> ?#include <mach/irqs.h>
>
> @@ -34,12 +35,8 @@
> ?#define MAILBOX_IRQ_NOTFULL(m) ? ? ? ? (1 << (2 * (m) + 1))
>
> ?/* SYSCONFIG: register bit definition */
> -#define AUTOIDLE ? ? ? (1 << 0)
> ?#define SOFTRESET ? ? ?(1 << 1)
> -#define SMARTIDLE ? ? ?(2 << 3)
> ?#define OMAP4_SOFTRESET ? ? ? ?(1 << 0)
> -#define OMAP4_NOIDLE ? (1 << 2)
> -#define OMAP4_SMARTIDLE ? ? ? ?(2 << 2)
>
> ?/* SYSSTATUS: register bit definition */
> ?#define RESETDONE ? ? ?(1 << 0)

Is this still required?

> @@ -70,8 +67,6 @@ struct omap_mbox2_priv {
> ? ? ? ?unsigned long irqdisable;
> ?};
>
> -static struct clk *mbox_ick_handle;
> -
> ?static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?omap_mbox_type_t irq);
>

<<snip>>
