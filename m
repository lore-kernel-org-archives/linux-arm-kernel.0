From: nm@ti.com (Menon, Nishanth)
Date: Tue, 13 Mar 2012 12:40:01 -0500
Subject: [PATCH 3/6] ARM: OMAP3+: SmartReflex: introduce notifier_control
In-Reply-To: <1331634381-31436-4-git-send-email-j-pihet@ti.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
 <1331634381-31436-4-git-send-email-j-pihet@ti.com>
Message-ID: <CAOMWX4fauZQccPhHn+f4-SOAXRbaU135xUKva0QsGgJoXDQzwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 05:26, <jean.pihet@newoldbits.com> wrote:
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c
> b/arch/arm/mach-omap2/smartreflex.c
> index 7977018..dfe8075 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
...
> + ? ? ? switch (sr->ip_type) {
> + ? ? ? case SR_TYPE_V1:
> + ? ? ? ? ? ? ? value = notifier_to_irqen_v1(sr_class->notify_flags);
> + ? ? ? ? ? ? ? sr_modify_reg(sr, ERRCONFIG_V1, value,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (enable) ? value : 0);
> + ? ? ? ? ? ? ? break;
> + ? ? ? case SR_TYPE_V2:
> + ? ? ? ? ? ? ? value = notifier_to_irqen_v2(sr_class->notify_flags);
> + ? ? ? ? ? ? ? sr_write_reg(sr, (enable) ? IRQENABLE_SET : IRQENABLE_CLR,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? value);
> + ? ? ? ? ? ? ? break;
> + ? ? ? default:
> + ? ? ? ? ? ? ? ?dev_warn(&sr->pdev->dev, "%s: unknown type of sr??\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?__func__);
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? if (!enable)
> + ? ? ? ? ? ? ? sr_write_reg(sr, IRQSTATUS, value);

can you move this to before we disable the interrupt? it took a while,
but we caught a bug recently when we disable IRQ and then attempt to
clear the status[1]

Regards,
Nishanth Menon
[1] http://review.omapzoom.org/#/c/20231/
