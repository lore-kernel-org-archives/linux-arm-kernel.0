From: ccross@google.com (Colin Cross)
Date: Wed, 15 Sep 2010 16:15:41 -0700
Subject: [PATCH 0/3] Common struct clk implementation, v7
In-Reply-To: <1284522014.516876.675872472687.0.gpush@pororo>
References: <1284522014.516876.675872472687.0.gpush@pororo>
Message-ID: <AANLkTim++mNF=KDabCBCk=jDxbwNFWu=hrDQq=UWR=yM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 14, 2010 at 8:40 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> Hi all,
>
> These patches are an attempt to allow platforms to share clock code. At
> present, the definitions of 'struct clk' are local to platform code,
> which makes allocating and initialising cross-platform clock sources
> difficult, and makes it impossible to compile a single image containing
> support for two ARM platforms with different struct clks.

Having just finished implementing the clock tree support on Tegra, I
have a few concerns about these patches, and how they relate to the
clk api.

On the spinlock vs. mutex issue (I know, it's been beaten to death).
The clk api does not specify whether or not implementations can sleep.
 In fact, it explicitly states that clk_get and clk_put can't be
called from atomic context, but does not say anything about the rest
of the api, which vaguely implies that they can be called from atomic
context.

There are situations in which a non-sleeping clk api is useful, if not
necessary.  On msm with a smart panel, the vsync is connected to a
gpio, and the vsync interrupt enables the dma controller clock is to
start the dma of the framebuffer to the display block.  A similar
problem can happen in dma audio, where a low watermark interrupt from
the audio block needs to trigger dma to refill the buffer.  Leaving
the dma clock on before the vsync or low watermark interrupt would
prevent entering the lowest power idle state.

There is also a very common use case for clk_disable in an interrupt.
When an I2C transaction completes, the irq handler should disable the
clock if there are no other queued transactions.  With a non-sleeping
clk api, this is easy.  With a sleeping clk api, the clk_disable needs
to be deferred to non-atomic context.  Because of the refcounting in
clk_disable, this is not particularly difficult, but a
clk_disable_later helper function might simplify it.

However, some of the clocks on Tegra can not be controlled from atomic
context.  Some clocks have voltage requirements, so enabling the clock
may require a call to the regulator api to increase the voltage, which
will call into the i2c api, which sleeps.

Additionally, using a lock per clk struct can cause AB-BA locking
issues.  In my implementation, calling clk_enable on a child clock in
the clock tree can call clk_enable on its parent if the child clock
was not already enabled.  This leads to the child clock lock being
taken, followed by the parent clock lock.  Calling clk_set_rate on the
parent requires recalculating the rate of all of the children, which
leads to the parent clock lock being taken first, followed by the
child clock lock.  Deadlock.

I solved these problems by using a single spinlock around all of the
clocks, plus an additional mutex around the clocks that need to sleep.
 I also locally added clk_*_cansleep functions to the clk api, and
used might_sleep to prevent calls to the non-cansleep clk api on
clocks that require sleeping.  I'm not happy with this solution, as it
uses a local extension to a cross-platform api, but I don't see any
way around it.  Some clocks really need to be enabled or disabled from
atomic context, and some clocks are impossible to use in atomic
context.

I think something a little like the gpio api style of cansleep and non
cansleep functions would help would preserve the ability for clocks to
avoid sleeping on platforms that don't need to sleep, while allowing
drivers that can handle sleeping clocks to remain as widely
cross-platform as possible.  Instead of changing all the calls, add a
clk_get_nosleep for drivers that will call the clk apis in atomic
context, which will catch drivers that are not compatible with the
clock they are requesting early on during probe.

Either way, the clk api could use some notes on the restrictions for
both the callers and the implementers to ensure compatibility between
architectures.  Which calls can sleep?  Can clk_set_rate or
clk_set_parent be called on a clock that is already enabled, and, if
so, what is the expected behavior for the children of the clock that
is changed?
