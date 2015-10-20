From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 20 Oct 2015 10:34:42 +0200
Subject: [PATCH V2] ARM: imx: add platform irq type setting in gpc
In-Reply-To: <1445337859-19111-1-git-send-email-Anson.Huang@freescale.com>
References: <1445337859-19111-1-git-send-email-Anson.Huang@freescale.com>
Message-ID: <1445330082.3716.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 20.10.2015, 18:44 +0800 schrieb Anson Huang:
> From: Anson Huang <b20788@freescale.com>
> 
> GPC irq domain is a child domain of GIC, now all of platform irqs
> are inside GPC domain, during the module populate, all devices irq
> should have correct type setting in GIC, however, there is no
> .irq_set_type callback setting in GPC, so the irq_set_type will be
> skipped and cause all irqs' type in /proc/interrupt are "edge" which
> mismatch with irq type setting in dtb file. Since GPC has no irq
> type setting, so just tell kernel to use irq_chip_set_type_parent.
> 
> Signed-off-by: Anson Huang <Anson.Huang@freescale.com>

Cc: <stable@vger.kernel.org> # 4.1+
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> change from V1:
> 	improve commit message.
>  arch/arm/mach-imx/gpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 10bf715..b3a7a74 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -176,6 +176,7 @@ static struct irq_chip imx_gpc_chip = {
>  	.irq_unmask		= imx_gpc_irq_unmask,
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_set_wake		= imx_gpc_irq_set_wake,
> +	.irq_set_type           = irq_chip_set_type_parent,
>  #ifdef CONFIG_SMP
>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  #endif

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
