From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 12:26:49 +0200
Subject: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
In-Reply-To: <201306031146.57611.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de> <9452845.qTGjLPCfXq@wuerfel>
 <201306031146.57611.heiko@sntech.de>
Message-ID: <1822564.TIKVDZSzqK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 11:46:57 Heiko St?bner wrote:
> 
> The timers are of the same type and the clocksource driver just grabs the 
> first of them as clockevent and the second as clocksource, so I think two 
> CLOCKSOURCE_OF_DECLARE lines won't do.

Ok, got it. I was confused by the fact that the existing two sets of
"compatible" strings have separate sets of strings:

static const struct of_device_id sptimer_ids[] __initconst = {
        { .compatible = "picochip,pc3x2-rtc" },
        { .compatible = "snps,dw-apb-timer-sp" },
        { /* Sentinel */ },
};

static const struct of_device_id osctimer_ids[] __initconst = {
        { .compatible = "picochip,pc3x2-timer" },
        { .compatible = "snps,dw-apb-timer-osc" },
        {},
};

and thought they were for clocksource and clockevent respectively,
which is wrong.

> But I just looked at clocksource_of_init a bit more closely, which does a 
> for_each_matching_node_and_match over the nodes. So the init_func could grab 
> the device for the clockevent on the first call and the clocksource when it 
> gets called for the second matching node.

Yes, I think that should work. You just have to be careful about calling
init_sched_clock() only once.

	Arnd
