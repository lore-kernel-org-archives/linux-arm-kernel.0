From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 25 Sep 2018 22:14:56 +0200
Subject: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
In-Reply-To: <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
Message-ID: <20180925201456.GD3112@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/2018 13:29:48+0200, Daniel Lezcano wrote:
> On 13/09/2018 13:30, Alexandre Belloni wrote:
> > Hi,
> > 
> > This series reworks the Atmel TCB drivers. It introduces a new driver to handle
> > the clocksource and clockevent devices.
> > 
> > This is necessary because:
> >  - the current tcb_clksrc driver is probed too late to be able to be used at
> >    boot and we now have SoCs that don't have a PIT. They currently are not able
> >    to boot a mainline kernel.
> >  - using the PIT doesn't work well with preempt-rt because its interrupt is
> >    shared (in particular with the UART and their interrupt flags are
> >    incompatible)
> 
> You say for rt the PIT is not suitable because of the shared irq but in
> the driver, the interrupt is flagged as shared.
> 

Well, it is not simply sharing the interrupt that is an issue, it is the
mismatch between the PIT and the UART interrupt flags and that only
happens when using preempt-rt.

But still, the TCB is flagged as shared because it may be shared between
multiple TCB channels (it is the case for the more recent SoCs).
However, what happens is that the DBGU UART is always enabled on the
boards so when using the PIT, the interrupt is always shared. But, for
the TCB, the only driver currently able to use the interrupt is the
clockevent driver so the interrupt as almost no chance to actually be
shared.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
