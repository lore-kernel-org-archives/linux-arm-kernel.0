From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 07 Aug 2014 12:04:04 +0200
Subject: [PATCH] ARM: mx6: Fix suspend/resume with PCI
In-Reply-To: <1407371998-11437-1-git-send-email-festevam@gmail.com>
References: <1407371998-11437-1-git-send-email-festevam@gmail.com>
Message-ID: <1407405844.4675.9.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 06.08.2014, 21:39 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When PCI is used and a suspend/resume sequence is done we see the following
> kernel hang:
> 
> root at freescale /$ echo mem > /sys/power/state 
> [   16.099018] PM: Syncing filesystems ... done.
> [   16.141010] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [   16.150840] Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
> [   16.199438] random: nonblocking pool is initialized
> [   16.229639] PM: suspend of devices complete after 64.793 msecs
> [   16.235488] PM: suspend devices took 0.070 seconds
> [   16.245301] PM: late suspend of devices complete after 4.968 msecs
> [   16.257063] PM: noirq suspend of devices complete after 5.538 msecs
> [   16.263425] Disabling non-boot CPUs ...
> [   16.274666] CPU1: shutdown
> [   16.286351] CPU2: shutdown
> [   16.294169] CPU3: shutdown
> [   16.299551] Enabling non-boot CPUs ...
> [   16.304155] CPU1: Booted secondary processor
> [   16.305717] CPU1 is up
> [   16.313078] CPU2: Booted secondary processor
> [   16.313456] CPU2 is up
> [   16.320778] CPU3: Booted secondary processor
> [   16.321174] CPU3 is up
> 	(hangs here)
> 
> Implement a workaround for the erratum ERR005723: "PCIe does not support L2
> Power Down", which consists in toggling bit 18 (TEST_POWERDOWN) of GPR1 register.
> 
> Tested on a mx6qsabresd TO1.2 revC2.
> 
> Reported-by: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

NACK

To my understanding the DW PCIe core needs a specific sequence to
enter/exit L2 at suspend that we currently ignore. Contrary to the
errata description I think it can be done without a dedicated core reset
signal. Hitting the PHY PD is a sledgehammer without proper
understanding of the problem.

Also hiding such things in the platform code seems really bad. Please
keep in mind that this is the mainline kernel, not a vendor downstream
tree where you are free to smash things all over the place.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
