From: rabin@rab.in (Rabin Vincent)
Date: Wed, 23 Nov 2011 23:17:54 +0530
Subject: [PATCH v5 6/7] arm: omap4: support pmu
In-Reply-To: <1319467559-5518-7-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-7-git-send-email-ming.lei@canonical.com>
Message-ID: <CAH+eYFD==CbcTWha=4pLVaaeE32gN4_BPdKv0Eo-XNhiz8CM-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 20:15,  <ming.lei@canonical.com> wrote:
> ?static struct platform_device* __init omap4_init_pmu(void)
> ?{
> ? ? ? ?int id = -1;
> @@ -420,6 +472,10 @@ static struct platform_device* __init omap4_init_pmu(void)
> ? ? ? ? ? ? ? ?return NULL;
> ? ? ? ?}
>
> + ? ? ? omap4_pmu_data.handle_irq = omap4_pmu_handler;
> + ? ? ? omap4_pmu_data.enable_irq = omap4_enable_cti;
> + ? ? ? omap4_pmu_data.disable_irq = omap4_disable_cti;
> +
> ? ? ? ?pd = omap_device_build_ss(dev_name, id, oh, 3, &omap4_pmu_data,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?sizeof(omap4_pmu_data),
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?omap_pmu_latency,
> @@ -440,7 +496,9 @@ static void __init omap_init_pmu(void)
> ? ? ? ? ? ? ? ?pd = omap4_init_pmu();
> ? ? ? ? ? ? ? ?if (!pd)
> ? ? ? ? ? ? ? ? ? ? ? ?return;
> - ? ? ? ? ? ? ? omap_device_enable(pd);
> +
> + ? ? ? ? ? ? ? omap_device_enable(&od->pdev);
> + ? ? ? ? ? ? ? omap4_configure_pmu_irq();

This doesn't build, because there's no "od" in this function.  I guess
you shouldn't be changing the omap_device_enable() call.
