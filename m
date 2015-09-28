From: slash.tmp@free.fr (Mason)
Date: Mon, 28 Sep 2015 18:32:05 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56094543.2040101@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <56094543.2040101@free.fr>
Message-ID: <56096B85.6040002@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/09/2015 15:48, Mason wrote:

> But tango_timer_init() is not being called...

Doh! I was using the wrong DTB...

By the way, the command I use to generate uImage feels wrong.
Is there a better way?

$ make dtbs ; make -j2 zImage ; cat arch/arm/boot/zImage arch/arm/boot/dts/tango4.dtb >XXX && mv XXX arch/arm/boot/zImage ; make uImage LOADADDR=0x80008000


My clocksource driver is fairly trivial:

#include <linux/of_address.h>	/* of_iomap			*/
#include <linux/sched_clock.h>	/* sched_clock_register		*/
#include <linux/clocksource.h>	/* clocksource_register_hz	*/
#include <linux/delay.h>	/* register_current_timer_delay	*/

#define XTAL_FREQ		27000000 /* Hz */

static void __iomem *xtal_in_cnt;

static unsigned long read_xtal_counter(void)
{
	return readl_relaxed(xtal_in_cnt);
}

static u64 read_sched_clock(void)
{
	return read_xtal_counter();
}

static cycle_t read_clocksource(struct clocksource *cs)
{
	return read_xtal_counter();
}

static struct clocksource tango_xtal = {
	.name	= "tango_xtal",
	.rating	= 300,
	.read	= read_clocksource,
	.mask	= CLOCKSOURCE_MASK(32),
	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
};

static struct delay_timer delay_timer = { read_xtal_counter, XTAL_FREQ };

static void __init tango_timer_init(struct device_node *np)
{
	xtal_in_cnt = of_iomap(np, 0);
	register_current_timer_delay(&delay_timer);
	sched_clock_register(read_sched_clock, 32, XTAL_FREQ);
	clocksource_register_hz(&tango_xtal, XTAL_FREQ);
}

CLOCKSOURCE_OF_DECLARE(tango, "sigma,tango-xtal", tango_timer_init);


Regards.
