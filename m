From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 14 May 2014 10:29:38 -0700
Subject: [PATCH v4 1/6] clocksource: Add support for the Mediatek SoCs
In-Reply-To: <1400087579-4250-2-git-send-email-matthias.bgg@gmail.com>
References: <1400087579-4250-1-git-send-email-matthias.bgg@gmail.com>
 <1400087579-4250-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <2fe960fd-b145-42a8-ace2-e2cd3aaf0cdc@BN1AFFO11FD010.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

just a few suggestions below. Nothing serious.

On Wed, 2014-05-14 at 07:12PM +0200, Matthias Brugger wrote:
> This patch adds a clock source and clock event for the timer found
> on the Mediatek SoCs.
> 
> The Mediatek General Porpose Timer block provides five 32 bit timers and
> one 64 bit timer.
> 
> Two 32 bit timers are used:
> TIMER1: clock events supporting periodic and oneshot events
> TIMER2: clock source configured as a free running counter

It is pretty common, I think, to use the free running counter also as
sched_clock. You probably want to look into this, but that's just a
possible enhancement.

[...]
> +static void __init mtk_timer_init(struct device_node *node)
> +{
> +	struct mtk_clock_event_device *evt;
> +	struct resource res;
> +	unsigned long rate = 0;
> +	struct clk *clk;
> +	int ret;
> +	u32 val;
> +
> +	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> +	if (!evt)
> +		panic("Can't allocate mtk clock event driver struct");

I'm not that sure about the A7s, but on Cortex-A9 there is also a global
timer which can be used for timing. And there might be other timing
options for this SOC too. Do you really want to panic?

	S?ren
