From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Dec 2013 11:49:08 +0100
Subject: [REPOST PATCH] ARM: sunxi: stop timer from ticking before
 enabling interrupts
In-Reply-To: <529C61A3.8010208@linaro.org>
References: <1385976575-28011-1-git-send-email-marc.zyngier@arm.com>
 <529C61A3.8010208@linaro.org>
Message-ID: <20131202104908.GC3034@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Mon, Dec 02, 2013 at 11:32:03AM +0100, Daniel Lezcano wrote:
>>+	/* Make sure timer is stopped before playing with interrupts */
>>+	sun4i_clkevt_time_stop(0);
>>+
> 
> It isn't possible to *not* enable it instead of stopping it ?
> 
> In the code before we have:
> 
>         writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD |
>                TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
>                timer_base + TIMER_CTL_REG(1));
> 
> If we remove the TIMER_CTL_ENABLE flag, wouldn't it fix the issue ?

Actually, this excerpt enables the timer 1, that is used as a
clocksource, while Marc stops the timer 0, which is used as our clock
event.

The timer 0 is enabled only whenever either .set_mode or
.set_next_event is called.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/490fefcf/attachment.sig>
