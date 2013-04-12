From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 13 Apr 2013 00:26:43 +0200
Subject: [PATCH v5 00/14] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <201304130022.49987.heiko@sntech.de>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
 <201304130022.49987.heiko@sntech.de>
Message-ID: <7765249.PbghLduf67@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 April 2013 00:22:48 Heiko St?bner wrote:
> 
> Without dt support, you get this:
> 
>   CC      drivers/clocksource/samsung_pwm.o
> drivers/clocksource/samsung_pwm.c:620: warning: ?samsung_pwm_clocksource_init_of? defined but not used
> 
> So, something like the following might be necessary

That patch should not be required any more with the definition

#ifdef CONFIG_CLKSRC_OF
extern void clocksource_of_init(void);

#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)                        \
        static const struct of_device_id __clksrc_of_table_##name       \
                __used __section(__clksrc_of_table)                     \
                 = { .compatible = compat,                              \
                     .data = (fn == (clocksource_of_init_fn)NULL) ? fn : fn }
#else
static inline void clocksource_of_init(void) {}
#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)                        \
        static const struct of_device_id __clksrc_of_table_##name       \
                __attribute__((unused))                                 \
                 = { .compatible = compat,                              \
                     .data = (fn == (clocksource_of_init_fn)NULL) ? fn : fn }
#endif

which turns the ?samsung_pwm_clocksource_init_of? function into an unused
symbol that gets silently dropped by gcc, at least in theory. Are you
using the latest clksrc/cleanup branch as a base?

	Arnd
