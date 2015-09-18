From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2015 10:08:17 +0100
Subject: [PATCH 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <55FBC36C.2090801@linaro.org>
References: <1442476272-31723-1-git-send-email-wxt@rock-chips.com>
 <1442476272-31723-2-git-send-email-wxt@rock-chips.com>
 <55FA83D5.9010504@linaro.org> <55FA87AA.4040807@gmail.com>
 <55FA9099.7000903@linaro.org> <55FA93B0.40504@gmail.com>
 <55FBC36C.2090801@linaro.org>
Message-ID: <20150918090817.GA21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 09:55:24AM +0200, Daniel Lezcano wrote:
> On 09/17/2015 12:19 PM, Caesar Wang wrote:
> >
> >
> >? 2015?09?17? 18:06, Daniel Lezcano ??:
> >>On 09/17/2015 11:28 AM, Caesar Wang wrote:
> >>>Hi Daniel,
> >>>
> >>>
> >>>? 2015?09?17? 17:11, Daniel Lezcano ??:
> >>>>
> >>>>Hi Caesar,
> >>>>
> >>>>
> >>>>On 09/17/2015 09:51 AM, Caesar Wang wrote:
> >>>>>Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
> >>>>>There are some failure with build up on timer driver for rockchip.
> >>>>>
> >>>>>logs:
> >>>>>...
> >>>>>drivers/clocksource/rockchip_timer.c:156:13: error: 'NO_IRQ'
> >>>>>undeclared
> >>>>
> >>>>I think the NO_IRQ definition is missing for ARM64.
> >>>
> >>>Yep, Maybe better to compatible if we don't use the 'NO_IRQ',
> >>
> >>Hmm, after digging into drivers/of/irq.c and kernel/irq/irqdomain.c
> >>
> >>when there is an error it returns zero. So NO_IRQ and -1 are not
> >>correct and on the other side zero can be a valid irq. That sounds a
> >>little bit fuzzy to me.
> >
> >I believe the 'NO_IRQ' is better select if 'NO_IRQ' is defined on ARM64
> >platform.
> >
> >     irq = irq_of_parse_and_map(np, 0);
> >
> >     if (irq  == NO_IRQ)
> >...
> >Also, that's ok if we instead of the 'irq < 0'  or  '!irq' , right?
> 
> 
> Hi Caesar,
> 
> so regarding Thomas and Russel answers, let's replace NO_IRQ by '!irq'.
                                ^

Definitely in this case.  irq_create_of_mapping() and therefore
irq_of_parse_and_map() both return _zero_ when they fail, not whatever
happens to be NO_IRQ on a particular architecture.  New code should
_never_ be making any use of NO_IRQ.

That's why I said:

"Modern drivers should _all_ be using !irq to detect invalid IRQs, and not
using NO_IRQ."

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
