From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 15 Dec 2011 10:56:07 +0900
Subject: [PATCH v4] ARM: sched_clock: allow sched_clock to be selected at
 runtime
In-Reply-To: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
References: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <029b01ccbacc$b5fdb6e0$21f924a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> 
> sched_clock() is yet another blocker on the road to the single
> image. This patch implements an idea by Russell King:
> 
> http://www.spinics.net/lists/linux-omap/msg49561.html
> 
> Instead of asking the platform to implement both sched_clock()
> itself and the rollover callback, simply register a read()
> function, and let the ARM code care about sched_clock() itself,
> the conversion to ns and the rollover. sched_clock() uses
> this read() function as an indirection to the platform code.
> If the platform doesn't provide a read(), the code falls back
> to the jiffy counter (just like the default sched_clock).
> 
> This allow some simplifications and possibly some footprint gain
> when multiple platforms are compiled in. Among the drawbacks,
> the removal of the *_fixed_sched_clock optimization which could
> negatively impact some platforms (sa1100, tegra, versatile
> and omap).
> 
> Tested on 11MPCore, OMAP4 and Tegra.
> 
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Erik Gilling <konkers@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Hi Marc,

There is a complaining with checkpatch.

ERROR: trailing whitespace
#376: FILE: arch/arm/kernel/sched_clock.c:163:
+^I^Isetup_sched_clock(jiffy_sched_clock_read, 32, HZ);^I$

And build warning:

arch/arm/plat-s5p/s5p-time.c: In function 's5p_read_sched_clock':
arch/arm/plat-s5p/s5p-time.c:328: warning: 'return' with no value, in
function returning non-void

I'm not sure what is proper return value in this case...

Anyway, others, looks ok to me and tested on Samsung S5P boards.
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks and sorry for late response.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Cc: Jamie Iles <jamie@jamieiles.com>
> Tested-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> I'm reposting this patch with the hope that it (or Russell's
> alternative patch http://patchwork.ozlabs.org/patch/115961/)
> will get merged in 3.3. It doesn't look intrusive enough to be
> left on the side of the road for yet another cycle...
> 
> Based on RMK's devel-stable as of Dec 9th.
> 
> >From v3:
> - Converted picoxcell
> - Some minor cleanup
> 
> >From v2:
> - Removed the read_sched_clock test from sched_clock() and move
>   the jiffies code to its own function, as suggested by Nicolas Pitre.
>   WARN_ON are added to ensure that setup_sched_clock() is not called
>   in an unsafe context and that we only override the default once.
> 
> >From v1:
> - Added 'notrace' to all _read_sched_lock() functions, fixing
>   the ftrace problem reported by Jamie Iles
> - Removed useless #include <linux/sched.h> from touched files
> - Made omap_32k_read_sched_clock() static

(snip)
