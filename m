From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 7 Aug 2014 10:18:32 +0800
Subject: [PATCH] ARM: mx6: Fix suspend/resume with PCI
In-Reply-To: <1407371998-11437-1-git-send-email-festevam@gmail.com>
References: <1407371998-11437-1-git-send-email-festevam@gmail.com>
Message-ID: <20140807021831.GM2167@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 09:39:58PM -0300, Fabio Estevam wrote:
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

I intend to agree with Lucas that we should align our testing and
understanding on the issue before trying to fix it.

Again, I do not see this issue on my TO1.2 chip, but only TO1.5,
aka Rev 1.3, one.

Shawn

> 
> Reported-by: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
