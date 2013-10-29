From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 28 Oct 2013 18:28:00 -0700
Subject: [PATCH 5/6] edac: Add support for Krait CPU cache error detection
In-Reply-To: <1383006690-6754-6-git-send-email-sboyd@codeaurora.org>
References: <1383006690-6754-1-git-send-email-sboyd@codeaurora.org>
 <1383006690-6754-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131029012759.GH4763@kartoffel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 12:31:29AM +0000, Stephen Boyd wrote:
> Add support for the Krait CPU cache error detection. This is a
> simplified version of the code originally written by Stepan
> Moskovchenko[1] ported to the EDAC device framework.
> 
> [1] https://www.codeaurora.org/cgit/quic/la/kernel/msm/tree/arch/arm/mach-msm/cache_erp.c?h=msm-3.4
> 
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/edac/Kconfig      |   8 ++
>  drivers/edac/Makefile     |   2 +
>  drivers/edac/krait_edac.c | 336 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/edac/krait_edac.c

[...]

> +static int krait_edac_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct edac_device_ctl_info *edev;
> +       struct krait_edac *p;
> +       int l1_irq, l2_irq;
> +       int ret;
> +       int cpu;
> +
> +       l1_irq = platform_get_irq(pdev, 0);
> +       if (l1_irq < 0)
> +               return l1_irq;
> +
> +       l2_irq = platform_get_irq(pdev, 1);
> +       if (l2_irq < 0)
> +               return l2_irq;

As you have optional interrupt-names, I would prefer that you attempted to
request interrupts by name if interrupt-names is present. Otherwise
interrupt-names brings no value.

Thanks,
Mark.
