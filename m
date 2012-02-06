From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 6 Feb 2012 16:06:23 +0800
Subject: [BUG] Spitz charger broken (and other sharpsl warnings)?
In-Reply-To: <20120204124534.GT889@n2100.arm.linux.org.uk>
References: <20120204124534.GT889@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZyjy+UsojvZWvCLpzX5d-3+32_3ULPpR_8vvpSZ2Sa1bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 4, 2012 at 8:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> While building my test PXA configuration, it spat out these warnings.
> There's three of them, the first probably does need fixing ASAP.
>
> This one is particularly nasty:
> arch/arm/mach-pxa/spitz_pm.c: In function 'spitz_charger_wakeup':
> arch/arm/mach-pxa/spitz_pm.c:178: warning: left shift count >= width of type
>
> static unsigned long spitz_charger_wakeup(void)
> {
> ? ? ? ?unsigned long ret;
> ? ? ? ?ret = (!gpio_get_value(SPITZ_GPIO_KEY_INT)
> ? ? ? ? ? ? ? ?<< GPIO_bit(SPITZ_GPIO_KEY_INT))
> ? ? ? ? ? ? ? ?| (!gpio_get_value(SPITZ_GPIO_SYNC)
> ? ? ? ? ? ? ? ?<< GPIO_bit(SPITZ_GPIO_SYNC)); <========
> ? ? ? ?return ret;
> }
>
> If this impacts the way the charger works, it's definitely something that
> needs fixing. ?We don't want more exploding batteries.
>
> ----------------------------------------------------------------------------
> arch/arm/mach-pxa/sharpsl_pm.c: In function 'sharpsl_pm_pxa_read_max1111':
> arch/arm/mach-pxa/sharpsl_pm.c:180: warning: ISO C90 forbids mixed declarations and code
>
> int sharpsl_pm_pxa_read_max1111(int channel)
> {
> ? ? ? ?/* Ugly, better move this function into another module */
> ? ? ? ?if (machine_is_tosa())
> ? ? ? ? ? ?return 0;
>
> ? ? ? ?extern int max1111_read_channel(int); <=====
>
> ? ? ? ?/* max1111 accepts channels from 0-3, however,
> ? ? ? ? * it is encoded from 0-7 here in the code.
> ? ? ? ? */
> ? ? ? ?return max1111_read_channel(channel >> 1);
>
> ----------------------------------------------------------------------------
> arch/arm/mach-pxa/sharpsl_pm.c: At top level:
> arch/arm/mach-pxa/sharpsl_pm.c:694: warning: 'sharpsl_fatal_check' defined but not used
>
> This warning has been around for a long time, since:
>
> commit 99f329a2ba3c2d07cc90ca9309babf27ddf98bff
> Author: Pavel Machek <pavel@ucw.cz>
> Date: ? Sun Sep 6 07:28:40 2009 +0200
>
> ? ?[ARM] pxa/sharpsl_pm: zaurus c3000 aka spitz: fix resume
>
> ? ?sharpsl_pm.c code tries to read battery state very early during
> ? ?resume, but those battery meters are connected on SPI and that's only
> ? ?resumed way later.
>
> ? ?Replace the check with simple checking of battery fatal signal, that
> ? ?actually works at this stage.
>
> ? ?Signed-off-by: Pavel Machek <pavel@ucw.cz>
> ? ?Tested-by: Stanislav Brabec <utx@penguin.cz>
> ? ?Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>

I can fix the first two bugs.

For the third one, could Pavel fix this issue? From the commit log,
Pavel should rework the checking of battery fatal signal, isn't it?

Best Regards
Haojian
