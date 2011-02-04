From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 4 Feb 2011 20:51:15 +0900
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110204111841.GG14627@n2100.arm.linux.org.uk>
References: <20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<4D48741F.8060006@codeaurora.org>
	<20110201212409.GU31216@n2100.arm.linux.org.uk>
	<20110204095424.GB2347@richard-laptop>
	<20110204104832.GE14627@n2100.arm.linux.org.uk>
	<AANLkTi=sfBTHLXejWxAWGa=Tcw+LoQfw6sUtcn6L+JeM@mail.gmail.com>
	<20110204111841.GG14627@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinB7jin5jDyNdTJYN2DZdTA3iJFvGJtsmtCUNsE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 4, 2011 at 8:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 04, 2011 at 08:04:03PM +0900, Jassi Brar wrote:
>> On Fri, Feb 4, 2011 at 7:48 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>
>> > int clk_enable(struct clk *clk)
>> > {
>> > ? ? ? ?unsigned long flags;
>> > ? ? ? ?int ret = 0;
>> >
>> > ? ? ? ?if (clk) {
>> > ? ? ? ? ? ? ? ?if (WARN_ON(!clk->prepare_count))
>> > ? ? ? ? ? ? ? ? ? ? ? ?return -EINVAL;
>> >
>> > ? ? ? ? ? ? ? ?spin_lock_irqsave(&clk->lock, flags);
>> > ? ? ? ? ? ? ? ?if (clk->enable_count++ == 0)
>> > ? ? ? ? ? ? ? ? ? ? ? ?ret = clk->ops->enable(clk);
>> > ? ? ? ? ? ? ? ?spin_unlock_irqrestore(&clk->lock, flags);
>> > ? ? ? ?}
>> > ? ? ? ?return ret;
>> > }
>> >
>> > is entirely sufficient to catch the case of a single-use clock not being
>> > prepared before clk_enable() is called.
>> >
>> > We're after detecting drivers missing calls to clk_prepare(), we're not
>> > after detecting concurrent calls to clk_prepare()/clk_unprepare().
>>
>> I hope you mean 'making sure the clock is prepared before it's enabled
>> ' rather than
>> 'catching a driver that doesn't do clk_prepare before clk_enable'.
>> Because, the above implementation still doesn't catch a driver that
>> doesn't call clk_prepare
>> but simply uses a clock that happens to have been already prepare'd by
>> some other
>> driver or the platform.
>
> No, I mean what I said.
Then, how does that function catch a driver that, say, doesn't do clk_prepare
but share the clk with another already active driver?
Because you said - "We're after detecting drivers missing calls to
clk_prepare()"

The point is, there is difference between detecting drivers that miss
the clk_prepare
and ensuring clk_prepare has been called before any call to
clk_enable. And making
that clear helps get rid of lots of confusion/misunderstanding. Uwe
seems to have
had similar confusions.


> The only way to do what you're asking is to attach a list of identifiers
> which have prepared a clock to the struct clk, where each identifier is
> unique to each driver instance.
I am not asking what you think.
In my second last post, I am rather asking the other way around - that
let us not worry
about drivers missing the clk_prepare and not try to catch those by the new API.


> I think that's going completely over the top, and adds needless complexity
> to drivers, which now have to pass an instance specific cookie into every
> clk API call.
Exactly.
All we need is to ensure clk_prepare has been called atleast once before
any call to clk_enable.
