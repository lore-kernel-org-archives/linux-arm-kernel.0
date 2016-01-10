From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sun, 10 Jan 2016 22:37:21 +0100
Subject: [PATCH v6 2/3] spi: sun4i: Fix clock calculations to be
 predictable and never exceed the requested rate
In-Reply-To: <20160110194450.GI9631@lukather>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
 <1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
 <20151227210946.GL30359@lukather>
 <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
 <CAGNoLaMsdPe4BE7+skYR45doEcXkZGA7QdFOidUA_yPZmiE9eg@mail.gmail.com>
 <20160110194450.GI9631@lukather>
Message-ID: <CAGNoLaOnpCLALNMscQC1XsnPjf55rXMomYdJPJFdpk=FuFgK4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-01-10 20:44 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> On Mon, Dec 28, 2015 at 05:22:35PM +0100, Marcus Weseloh wrote:
>> 2015-12-28 0:29 GMT+01:00 Marcus Weseloh <mweseloh42@gmail.com>:
>> > 2015-12-27 22:09 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
[...]
>> > Oh, and I just noticed a mistake in the comment: the clock driver
>> > rounds up _or_ down, so I should drop the "up".
>>
>> As I'm looking further into this, I think the comment should read
>> "possibly rounded down", as the clk framework is expected to set a
>> frequency that is less or equal to the requested frequency.
>
> AFAIK, there's no such expectation in the clock framework. You
> treating this from a maximum frequency perspective, but it would be
> the exact opposite if you were talking about a minimum frequency, as
> might be the case for other consumers.

I was looking though the clk driver source and found this comment in
drivers/clk/sunxi/clk-factors.c (Line 89):

/* find the parent that can help provide the fastest rate <= rate */

And that comments seems to be correct, because that is what the code
is doing (and the comment is copied from the core clk framework). So
it checks every parent to see if that parent could be used to get a
clock rate that is less or equal to the requested clock. If it can't
find one, i.e. all parents can only supply a larger clock, then
-EINVAL is returned. Or am I missing something here?

Up to now this driver would never return -EINVAL, because of the
problems in the mod0 clock driver I mentioned. But the intended effect
seems to be actual rate <= requested rate. And it seems like clk
drivers on other platforms do this as well.

[...]
>> That clk_set_rate sets a higher frequency than requested seems to be a
>> problem in itself. I had a look at clk/sunxi/clk-mod0.c and noticed a
>> few small problems there. Will post an RFC patch in a couple of
>> minutes.
>
> Did you post these patches already? I think I missed them if that's
> the case.

Yes, I've posted the patch to the clk-mod0.c here:
https://groups.google.com/d/msg/linux-sunxi/BQWhOHGqliI/fMtirUFsBgAJ

Cheers,

  Marcus
