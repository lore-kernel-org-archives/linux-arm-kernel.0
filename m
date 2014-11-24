From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 16:20:45 +0100
Subject: [PATCH RESEND 2/3] ARM: Meson6: Add SMP support for Amlogic Meson6
In-Reply-To: <1415982353-9293-3-git-send-email-carlo@caione.org>
References: <1415982353-9293-1-git-send-email-carlo@caione.org>
 <1415982353-9293-3-git-send-email-carlo@caione.org>
Message-ID: <201411241620.45412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014, Carlo Caione wrote:

> +static void __iomem *cpucfg_membase;
> +static void __iomem *scu_membase;

I don't think you need a global scu_membase variable, you use it only in
one function.

> +static DEFINE_SPINLOCK(cpu_lock);
> +
> +extern void meson_secondary_startup(void);

Better put the extern declaration into a header file.

> +static void __init meson6_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
> +	if (!node) {
> +		pr_err("Missing Meson6 SCU node\n");
> +		return;
> +	}
> +
> +	scu_membase = of_iomap(node, 0);
> +	if (!scu_membase) {
> +		pr_err("Couln't map Meson6 SCU registers\n");
> +		return;
> +	}
> +
> +	node = of_find_compatible_node(NULL, NULL, "amlogic,meson6-cpuconfig");
> +	if (!node) {
> +		pr_err("Missing Meson6 CPU config node\n");
> +		return;
> +	}

I'm not sure about the "amlogic,meson6-cpuconfig" device node. Since this
is just an 8-byte register range, I suspect it's actually part of a larger
device, so you should better represent that instead. We can now have
early "syscon" devices (in linux-next I think), so you could instead make
this a device that is compatible with "syscon" and have the smp code
look that up and apply an appropriate offset. Do you have an idea of
which device this is part of?

	Arnd
