From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 1 Jul 2015 17:54:36 +0200
Subject: [PATCH v2 3/4] ARM: mvebu: Allow using the GIC for wakeup in
 standby mode
In-Reply-To: <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
 <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150701175436.7dff0754@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 30 Jun 2015 19:18:59 +0200, Gregory CLEMENT wrote:

>  static void __init mvebu_init_irq(void)
>  {
> +	if (of_machine_is_compatible("marvell,armada375") ||
> +	    of_machine_is_compatible("marvell,armada380") ||
> +	    of_machine_is_compatible("marvell,armada390"))

What we really want to know is if we're using the GIC, so what about
instead:

	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
	if (np)
		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
				      IRQCHIP_MASK_ON_SUSPEND);
	of_node_put(np);

(Not even compile-tested).

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
