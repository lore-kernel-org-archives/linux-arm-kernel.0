From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Dec 2017 17:32:27 -0800
Subject: [PATCH v6 4/5] clk: aspeed: Register gated clocks
In-Reply-To: <1513910633.2743.79.camel@kernel.crashing.org>
References: <20171128071908.12279-1-joel@jms.id.au>
 <20171128071908.12279-5-joel@jms.id.au>
 <20171221233927.GE7997@codeaurora.org>
 <1513910191.2743.77.camel@kernel.crashing.org>
 <1513910633.2743.79.camel@kernel.crashing.org>
Message-ID: <20171227013227.GV7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22, Benjamin Herrenschmidt wrote:
> On Fri, 2017-12-22 at 13:36 +1100, Benjamin Herrenschmidt wrote:
> > 
> > > No you can't sleep here. It needs to delay because this is inside
> > > spinlock_irqsave.
> > 
> > Additionally you really don't want to delay for 10ms with interrupts
> > off :-(
> > 
> > Sadly, it looks like the clk framework already calls you with spinlock
> > irqsafe, which is a rather major suckage.
> > 
> > Stephen, why is that so ? That pretty much makes it impossible to
> > do sleeping things, which prevents things like i2c based clock
> > controllers etc...
> 
> I noticed we do have a few i2c based clock drivers... how are they ever
> supposed to work ? i2c bus controllers are allowed to sleep and the i2c
> core takes mutexes...

We have clk_prepare()/clk_unprepare() for sleeping suckage. You
can use that, and i2c based clk drivers do that today.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
