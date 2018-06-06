From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jun 2018 10:09:54 +0100
Subject: [PATCH] ARM: Build secure_cntvoff.S unconditionally to fix
 shmobile !SMP build
In-Reply-To: <1528275154-5164-1-git-send-email-geert+renesas@glider.be>
References: <1528275154-5164-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180606090953.GW17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 10:52:34AM +0200, Geert Uytterhoeven wrote:
> If CONFIG_SMP=n, building a kernel for R-Car Gen2 fails with:
> 
>     arch/arm/mach-shmobile/setup-rcar-gen2.o: In function `rcar_gen2_timer_init':
>     setup-rcar-gen2.c:(.init.text+0x30): undefined reference to `secure_cntvoff_init'
> 
> Indeed, on R-Car Gen2 SoCs, secure_cntvoff_init() is not only needed for
> secondary CPUs, but also for the boot CPU.  This is most visible on SoCs
> with Cortex A7 cores (e.g. R-Car E2, cfr. commit 9ce3fa6816c2fb59 ("ARM:
> shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794")),
> but Cortex A15 is affected, too.
> 
> Fix this by always providing secure_cntvoff_init().
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7c607944bc657616 ("ARM: smp: Add initialization of CNTVOFF")
> Fixes: cad160ed0a94927e ("ARM: shmobile: Convert file to use cntvoff")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This doesn't look right to me, but I don't have secure_cntvoff in any
tree here that I can look at to check.  What if secure_cntvoff contains
instructions only available on ARMv7 CPUs, and not ARMv4?

It makes no sense (to me) to always build this.

NAK, for the time being until the situation becomes clearer.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
