From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 16:41:15 +0000
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <201303131635.02355.arnd@arndb.de>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <CAD6h2NQa-RhR555o_1_RYPuPb4366H_AwK1U9S3pRVPdo_xNNg@mail.gmail.com>
 <1363189748.3100.108.camel@hornet> <201303131635.02355.arnd@arndb.de>
Message-ID: <1363192875.3100.125.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 16:35 +0000, Arnd Bergmann wrote:
> Makes sense. I guess you can actually derive "has_timint1"
> from the presence of the irq and just try to parse it:
> 
> 	irq = irq_of_parse_and_map(np, 0);
> 	if (irq) {
> 		evtoffs = TIMER_1_BASE;
> 		srcoffs = TIMER_2_BASE;
> 	} else {
> 		irq = irq_of_parse_and_map(np, 1);
> 		if (!irq)
> 			return -ENODEV;
> 		srcoffs = TIMER_1_BASE;
> 		evtoffs = TIMER_2_BASE;
> 	}
> 
> 
> I wonder if we can ever get into the second case though: If the
> first interrupt in not valid, can there be a second one in the
> interrupts property? I don't know of a way to put an "invalid"
> interrupt in there.

The discussion in the "[PATCH v3 03/11] clocksource: sp804: add device
tree support" thread resulted in some ideas how to describe such
situation. I suggested using interrupt-names property to explicitly
describe the numbers, Rob wanted to simply define one or two interrupts
and in the former case have a special property describing which one is
it. Either way you can get this information from the tree. The main
argument is about the clockevent/source aliases - whether they should be
obligatory, optional or banned.

Pawe?
