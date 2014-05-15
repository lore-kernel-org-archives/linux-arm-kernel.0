From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 15:26:29 +0200
Subject: [PATCHv3 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <6600397.74rV2Hm7nM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 11:18:39 Thomas Petazzoni wrote:
> @@ -78,6 +121,14 @@ static void __init mvebu_timer_and_clk_init(void)
>         mvebu_scu_enable();
>         coherency_init();
>         BUG_ON(mvebu_mbus_dt_init(coherency_available()));
> +
> +       if (of_machine_is_compatible("marvell,armada375") ||
> +           of_machine_is_compatible("marvell,armada38x")) {
> +               arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
> +               pci_ioremap_set_mem_type(MT_UNCACHED);
> +               mvebu_l2x0_pl310_coherent();
> +       }
> +
>         l2x0_of_init(0, ~0UL);


I wonder whether this should just be move to the existing
armada_375_380_coherency_init() function to avoid the
of_machine_is_compatible() check. Other than that,

Acked-by: Arnd Bergmann <arnd@arndb.de>
