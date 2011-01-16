From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 15 Jan 2011 23:59:51 -0700
Subject: Locking in the clk API
In-Reply-To: <20110115151507.GD15996@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<4D2D184A.8020405@codeaurora.org>
	<20110112090301.GS11039@n2100.arm.linux.org.uk>
	<4D31A8F1.4080301@weinigel.se>
	<20110115145358.GC15996@n2100.arm.linux.org.uk>
	<20110115150331.GB6917@pengutronix.de>
	<20110115151507.GD15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikw-O-VJxSnmtRubiWx=9Ykt3939x4Nx-QsUs1a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Jan 15, 2011 at 04:03:31PM +0100, Uwe Kleine-K?nig wrote:
>> Hi Russell,
>>
>> On Sat, Jan 15, 2011 at 02:53:58PM +0000, Russell King - ARM Linux wrote:
>> > We've been around returning EAGAIN, WARN_ONs, BUG_ONs, having clk_enable()
>> > vs clk_enable_atomic(), clk_enable_cansleep() vs clk_enable(), etc.
>> >
>> > There's been a lot of talk on this issue for ages with no real progress
>> > that I'm just going to repeat: let's unify those implementations which
>> > use a spinlock for their clks into one consolidated solution, and
>> > a separate consolidated solution for those which use a mutex.
>> >
>> > This will at least allow us to have _some_ consolidation of the existing
>> > implementations - and it doesn't add anything to the problem at hand.
>> > It might actually help identify what can be done at code level to resolve
>> > this issue.
>> Great, so how should we do it? ?Take Jeremy's patch and make the
>> differenciation between sleeping and atomic implementation a Kconfig
>> variable?
>
> No - I've been suggesting for about a week now about doing two entirely
> separate consolidations.
>
> I think it would be insane to do the consolidation of the two different
> implementations in one patch or even one patch set. ?There needs to be
> a consolidation of spinlock-based clks as one patch set, which is
> entirely separate and independent from the consolidation of mutex-based
> clks.

+1

>
> What if one of the consolidations turns out to be a problem? ?Do we want
> to throw both out, or do we want to keep as much as we possibly can?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
