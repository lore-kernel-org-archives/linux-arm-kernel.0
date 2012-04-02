From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 2 Apr 2012 10:30:29 -0700
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <20120402171641.GF15197@opensource.wolfsonmicro.com>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F787392.5040308@codeaurora.org>
 <20120401153450.GC8971@opensource.wolfsonmicro.com>
 <4F79D85F.4020909@codeaurora.org>
 <20120402171641.GF15197@opensource.wolfsonmicro.com>
Message-ID: <CAJOA=zNzoL=i_JYmknHB9ggzS7XHoh3=K5tBUyf5h0oxXSqmJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2012 at 10:16 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 02, 2012 at 09:48:31AM -0700, Stephen Boyd wrote:
>
>> I hope we get a better clk_get() implementation with the unified struct
>> clk. Don't get me wrong, clkdev is a great improvement over open coding
>> clock framework stuff in each platform. But clkdev is really just
>> another platform specific implementation that most platforms decide to
>> use. Each platform has to select the option and it breaks if two
>
>> Sticking devm_clk_get() into clkdev.c is simple, no new file, smaller
>> diff. Great. But linking it to clkdev doesn't sound much better when
>> we're trying to get rid of platform specific code and this code is
>> entirely platform independent.
>
> Why wouldn't we want to continue to use clkdev with the generic clock
> framework? ?There's nothing particularly wrong with clkdev and we need a
> standard mechanism for doing this anyway. ?Frankly I was very surprised
> when I looked just now and realised that the generic framework doesn't
> use it automatically, I might just send a patch for that...

In the interest of getting merged I kept the common clk series as
small as I could.  It still came out much larger than the original
patches, so you can see why non-critical bits like the above are
missing.

I will take this opportunity to chime in and say that we can improve
clk_get.  I'd personally like to see clk_get return an opaque cookie
that is per-device.  This will really help out the clk_set_rate case
where we want to start managing multiple different drivers which might
invoke a set_rate on the same clock (which is increasingly more likely
now that we can propagate rate change requests up to shared parents).

So essentially clk_get(dev, con_id) would return a random u32 (or
maybe not random... maybe generated from a hashing function or
whatever), and all  further clk_* ops would use that id.  Thus the
common clk framework would know exactly which driver was calling any
given function.

The above suggestion is not critical for single dimensional operations
such as clk_(un)prepare and clk_enable/clk_disable.  Use counting is
adequate.  Tracking driver requests is very useful for two-dimensional
calls like clk_set_rate, where we might want to keep a plist of rates
that drivers had requested so that clk_set_rate is no longer a
He-Who-Writes-Last-Wins affair.

/me dons flame-retardant suit.

Regards,
Mike
