From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Nov 2013 07:33:34 -0800
Subject: [PATCH 1/8] ARM: OMAP: Move public portion of dmtimer.h to
 include/linux/omap-timer.h
In-Reply-To: <1385085414-9034-2-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
 <1385085414-9034-2-git-send-email-joelf@ti.com>
Message-ID: <20131122153334.GE10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Joel Fernandes <joelf@ti.com> [131121 18:00]:
> Multiplatform support has made arch/arm/plat-omap/include/plat/ inaccessible to
> drivers outside the plat-omap directory [1]. Due to this the following drivers
> are disabled with !CONFIG_ARCH_MULTIPLATFORM:
> CONFIG_IR_RX51 (drivers/media/rc/ir-rx51.c)
> CONFIG_TIDSPBRIDGE (drivers/staging/tidspbridge/core/dsp-clock.c)
> 
> We move the portion of the dmtimer "API" that should be accessible to the
> drivers, into include/linux/omap-timer.h

As we chatted earlier, we don't have to expose all these hardware specific
functions and use existing Linux generic frameworks instead.

We can implement an irqchip and a clocksource in the dmtimer code for the
client drivers to use, and after that we only have a couple of dmtimer
specific functions left to export.

I'm thinkging some thing like this for the public API:

omap_dm_timer_request			request_irq
omap_dm_timer_request_specific		request_irq
omap_dm_timer_get_irq			request_irq
omap_dm_timer_set_source		clk_set_rate
omap_dm_timer_stop			disable_irq
omap_dm_timer_start			enable_irq
omap_dm_timer_disable			disable_irq
omap_dm_timer_free			free_irq
omap_dm_timer_set_int_enable		enable_irq

After that, what's left to export are some functions to configure
the hardware timer:

omap_dm_timer_write_counter
omap_dm_timer_set_match
omap_dm_timer_read_counter
omap_dm_timer_read_status
omap_dm_timer_write_status

And for those we can then eventually probably have some Linux generic
hardware timer API :)

Regards,

Tony
