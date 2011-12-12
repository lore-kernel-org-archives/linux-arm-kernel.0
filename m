From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Dec 2011 17:05:29 +0000
Subject: [PATCH v4] ARM: sched_clock: allow sched_clock to be selected
 at runtime
In-Reply-To: <4EE57BC3.4080306@gmail.com>
References: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
 <4EE57BC3.4080306@gmail.com>
Message-ID: <4EE63459.1030105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/11 03:57, Rob Herring wrote:
> On 12/09/2011 09:33 AM, Marc Zyngier wrote:
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
>> Cc: Jamie Iles <jamie@jamieiles.com>
>> Tested-by: Jamie Iles <jamie@jamieiles.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> I'm reposting this patch with the hope that it (or Russell's
>> alternative patch http://patchwork.ozlabs.org/patch/115961/)
>> will get merged in 3.3. It doesn't look intrusive enough to be
>> left on the side of the road for yet another cycle...
>>
> 
> Please! I've been holding off on (re)doing and submitting sched_clock
> support for highbank until this goes in.

Queued as patch 7205/1.

	M.
-- 
Jazz is not dead. It just smells funny...
