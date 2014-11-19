From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 22:16:27 +0100
Subject: [GIT PULL] Third Round of Renesas ARM Based Soc Updates for v3.19
In-Reply-To: <cover.1415841454.git.horms+renesas@verge.net.au>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
Message-ID: <201411192216.27740.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014, Simon Horman wrote:
> ----------------------------------------------------------------
> Third Round of Renesas ARM Based Soc Updates for v3.19
> 
> * Always build rcar setup for armv7
>   - Fixes allmodconfig build fauilre caused by
>     "ARM: shmobile: always build rcar setup for armv7"
> * Add restart callback to sh73a0

Pulled into next/soc, thanks!

> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       ARM: shmobile: always build rcar setup for armv7
> 
> Geert Uytterhoeven (1):
>       ARM: shmobile: sh73a0: Add restart callback

I'm not too happy about the restart handler here: 

+#define RESCNT2 IOMEM(0xe6188020)
+static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
+{
+       /* Do soft power on reset */
+       writel((1 << 31), RESCNT2);
+}

I see that you have the same thing in other SoCs, but I'd really want to
see this done properly at some point and likely won't take future patches
doing the same thing.

Please have a look@drivers/power/restart for how other platforms do
this. You probably need to add a device node for whatever IP block
holds the reset register and then have a driver. What exactly this
driver should look like depends of course on what other registers are
part of this block.

	Arnd
