From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 27 Sep 2010 00:57:42 +0100
Subject: [PATCH 0/3] Common struct clk implementation, v7
In-Reply-To: <AANLkTim++mNF=KDabCBCk=jDxbwNFWu=hrDQq=UWR=yM@mail.gmail.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<AANLkTim++mNF=KDabCBCk=jDxbwNFWu=hrDQq=UWR=yM@mail.gmail.com>
Message-ID: <4C9FDDF6.5000702@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/10 00:15, Colin Cross wrote:
> On Tue, Sep 14, 2010 at 8:40 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
>> Hi all,
>>
>> These patches are an attempt to allow platforms to share clock code. At
>> present, the definitions of 'struct clk' are local to platform code,
>> which makes allocating and initialising cross-platform clock sources
>> difficult, and makes it impossible to compile a single image containing
>> support for two ARM platforms with different struct clks.
> 
> Having just finished implementing the clock tree support on Tegra, I
> have a few concerns about these patches, and how they relate to the
> clk api.
> 
> On the spinlock vs. mutex issue (I know, it's been beaten to death).
> The clk api does not specify whether or not implementations can sleep.
>  In fact, it explicitly states that clk_get and clk_put can't be
> called from atomic context, but does not say anything about the rest
> of the api, which vaguely implies that they can be called from atomic
> context.

Personally, I took the view that they where never allowable from an
atomic context. We may need to lock the relevant clock hardware and
as such it makes it a bit of a headache if we have clock implementations
which communicate via something like i2c or spi. It could be that
clocks are sourced form some form of PMIC, PLL or other external device.

> There are situations in which a non-sleeping clk api is useful, if not
> necessary.  On msm with a smart panel, the vsync is connected to a
> gpio, and the vsync interrupt enables the dma controller clock is to
> start the dma of the framebuffer to the display block.  A similar
> problem can happen in dma audio, where a low watermark interrupt from
> the audio block needs to trigger dma to refill the buffer.  Leaving
> the dma clock on before the vsync or low watermark interrupt would
> prevent entering the lowest power idle state.

Is the DMA clock seperate from the device bus clock in this case?

> There is also a very common use case for clk_disable in an interrupt.
> When an I2C transaction completes, the irq handler should disable the
> clock if there are no other queued transactions.  With a non-sleeping
> clk api, this is easy.  With a sleeping clk api, the clk_disable needs
> to be deferred to non-atomic context.  Because of the refcounting in
> clk_disable, this is not particularly difficult, but a
> clk_disable_later helper function might simplify it.

IIRC, the I2C APIs aren't call-able from an atomic context, so the
clk_enable() and clk_disable() calls could be done from the context
initiating and completing the transaction, and not the interrupt
handler.

> However, some of the clocks on Tegra can not be controlled from atomic
> context.  Some clocks have voltage requirements, so enabling the clock
> may require a call to the regulator api to increase the voltage, which
> will call into the i2c api, which sleeps.
>
> Additionally, using a lock per clk struct can cause AB-BA locking
> issues.  In my implementation, calling clk_enable on a child clock in
> the clock tree can call clk_enable on its parent if the child clock
> was not already enabled.  This leads to the child clock lock being
> taken, followed by the parent clock lock.  Calling clk_set_rate on the
> parent requires recalculating the rate of all of the children, which
> leads to the parent clock lock being taken first, followed by the
> child clock lock.  Deadlock.

Hmm, either the lock has to be explicitly for the 'enable' count or
we end up with some really nasty locking problems.

> I solved these problems by using a single spinlock around all of the
> clocks, plus an additional mutex around the clocks that need to sleep.
>  I also locally added clk_*_cansleep functions to the clk api, and
> used might_sleep to prevent calls to the non-cansleep clk api on
> clocks that require sleeping.  I'm not happy with this solution, as it
> uses a local extension to a cross-platform api, but I don't see any
> way around it.  Some clocks really need to be enabled or disabled from
> atomic context, and some clocks are impossible to use in atomic
> context.

I'd like to see some comment about the use of the clk_ api from atomic
context, and then sorting this out before we try and get a unified API
sorted out.

> I think something a little like the gpio api style of cansleep and non
> cansleep functions would help would preserve the ability for clocks to
> avoid sleeping on platforms that don't need to sleep, while allowing
> drivers that can handle sleeping clocks to remain as widely
> cross-platform as possible.  Instead of changing all the calls, add a
> clk_get_nosleep for drivers that will call the clk apis in atomic
> context, which will catch drivers that are not compatible with the
> clock they are requesting early on during probe.
> 
> Either way, the clk api could use some notes on the restrictions for
> both the callers and the implementers to ensure compatibility between
> architectures.  Which calls can sleep?  Can clk_set_rate or
> clk_set_parent be called on a clock that is already enabled, and, if
> so, what is the expected behavior for the children of the clock that
> is changed?

Some of that is implementation specific, IIRC if they can't return an
error they should be able to. In the case of most of the Samsung code
the user is allowed to set_parent and set_rate on a running clock, and
in some cases the clock has to be temporarily stopped whilst the MUX
change is being sorted out.

For the child case, on the Samsung code it is very rare that we've
ended up having to change the rate of the parent clocks, as we often
have fixed-rate sources for the child clocks, and thus use these as
a really useful stable source. Often the set_rate and the set_parent
calls are being done on the child clocks directly connected to the
peripherals.

I would propose that if we do have a common clk_api, then we have a
common set of notifiers (a-la, or use the current in kernel ones)
that can be called when a clock changes rate so that drivers can take
notice of this. It may be also a good idea for drivers to register
a range of clock rates they can tolerate so that setting the rate of
the parent can take these into account.

(On the above, I belive someone at ST has alreayd been looking at
 this sort of thing, but their implementation was rather large and
 needed a pile of tidying up).

However, I think we should carefully sort out who handles the set_parent
implementation, whether it is in the clk core api, or has at-least
a useful helper in there to ensure that the following is met:

- when parent changes, the parent's child count is changed
- if the child is enabled, the following needs to be done:
  - call clk_enable() for the new parent
  - call the implementation's set_parent
  - call clk_disbale() for the old parent

I believe this sort of thing is very useful to have in the core
implemetation, as it is the sort of thing people will get wrong
on a regular basis, as well as being common to all but the simplest
of clock implementations.

note, this may then cause problems on how you deal with a system
which has booted and is just setting the clocks up, as we may end
up disabling a clock that is being used elsewhere (but we just
don't know it).

second note, this is also even more fun for resume, where clock
control registers may not have been kept over resume. Simply
rewriting these registers from store may end up causing problems
with glitching clocks, etc.
