From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Jul 2012 16:52:51 +0000
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120701184110.GA30680@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <201206302104.37937.arnd@arndb.de> <20120701184110.GA30680@elf.ucw.cz>
Message-ID: <201207021652.52787.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 01 July 2012, Pavel Machek wrote:
> @@ -133,6 +134,11 @@ static void socfpga_cyclone5_restart(char mode, const char *cmd)
>  
>  static void __init socfpga_cyclone5_init(void)
>  {
> +       int i;
> +       for (i = 0; i < 512; i++) {
> +               dynamic_irq_init(i);
> +       }
> +
>  #ifdef CONFIG_CACHE_L2X0
>         /* 8-way, 64K/way, evmon/parity/share */
>         l2x0_of_init(0x00760000, 0xfe000fff);
> 

This looks wrong, I think what you should do instead is
to call irq_domain_add_legacy() for each controller you
register as the first step, and then try to convert the
controllers to use irq_domain_add_linear() as the second
step. See also Documentation/IRQ-domain.txt.

	Arnd
