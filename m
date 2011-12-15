From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Dec 2011 11:04:20 +0000
Subject: [PATCH v4] ARM: sched_clock: allow sched_clock to be selected
 at runtime
In-Reply-To: <029b01ccbacc$b5fdb6e0$21f924a0$%kim@samsung.com>
References: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
 <029b01ccbacc$b5fdb6e0$21f924a0$%kim@samsung.com>
Message-ID: <4EE9D434.2010900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/11 01:56, Kukjin Kim wrote:
> Marc Zyngier wrote:
>>
>> sched_clock() is yet another blocker on the road to the single
>> image. This patch implements an idea by Russell King:
>>
>> http://www.spinics.net/lists/linux-omap/msg49561.html
>>
>> Instead of asking the platform to implement both sched_clock()
>> itself and the rollover callback, simply register a read()
>> function, and let the ARM code care about sched_clock() itself,
>> the conversion to ns and the rollover. sched_clock() uses
>> this read() function as an indirection to the platform code.
>> If the platform doesn't provide a read(), the code falls back
>> to the jiffy counter (just like the default sched_clock).
>>
>> This allow some simplifications and possibly some footprint gain
>> when multiple platforms are compiled in. Among the drawbacks,
>> the removal of the *_fixed_sched_clock optimization which could
>> negatively impact some platforms (sa1100, tegra, versatile
>> and omap).
>>
>> Tested on 11MPCore, OMAP4 and Tegra.
>>
>> Cc: Imre Kaloz <kaloz@openwrt.org>
>> Cc: Krzysztof Halasa <khc@pm.waw.pl>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> Cc: Colin Cross <ccross@android.com>
>> Cc: Erik Gilling <konkers@android.com>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Linus Walleij <linus.walleij@stericsson.com>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Alessandro Rubini <rubini@unipv.it>
>> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
>> Cc: Lennert Buytenhek <kernel@wantstofly.org>
>> Cc: Nicolas Pitre <nico@fluxnic.net>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
> 
> Hi Marc,
> 
> There is a complaining with checkpatch.
> 
> ERROR: trailing whitespace
> #376: FILE: arch/arm/kernel/sched_clock.c:163:
> +^I^Isetup_sched_clock(jiffy_sched_clock_read, 32, HZ);^I$
> 
> And build warning:
> 
> arch/arm/plat-s5p/s5p-time.c: In function 's5p_read_sched_clock':
> arch/arm/plat-s5p/s5p-time.c:328: warning: 'return' with no value, in
> function returning non-void
> 
> I'm not sure what is proper return value in this case...

Good catch. The return value should be 0, and I'll update the patch now.

> Anyway, others, looks ok to me and tested on Samsung S5P boards.
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
