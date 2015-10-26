From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 26 Oct 2015 09:59:09 +0000
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <562AFBD5.3050508@codeaurora.org>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org>
Message-ID: <562DF96D.6020307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/10/15 04:32, Timur Tabi wrote:
> Jun Nie wrote:
>> I am OK to add a new driver for ZTE UART if no other's objection
>> though I do not agree you. Without this last patch, other patches are
>> just for minor refactor for register access.
> 
> In that case, my vote is to drop the whole patchset.  Just copy/paste
> the amba-pl011 driver and make whatever changes you need.  That sort of
> thing happens all the time.

I don't agree here. The driver _is_ very similar (all the semantics and
behaviour), it's just the register addresses that are different.
In so far I'd go with that approach of supporting it within the PL011
driver - whether this has to be in this very same file is another
question. I think by using register accessors (avoiding direct calls to
writel/readl in the code) we can hide a lot of these differences in just
two functions.
Also, as I said earlier, I guess we don't need all those #ifdefs.
So in the end the driver wouldn't be too different, it's just that those
diffs that look a bit scary (because they touch every readl/writel).

I tried to refactor the driver lately to split up SBSA and PL011 support
and got something that compiles, though I wasn't fully satisfied and I
ran out of time. The refactor idea was to split driver runtime from
initialization, so the different probe and init functions can be moved
into separate files. There would be one stub file with all the core
driver logic (DMA, IRQ handling, buffer handling, communication
parameters setup) and one file for each subtype (PL011, SBSA, ZTE, you
name it).
If people are interested, I can try to clean this up and post it as an RFC.

Cheers,
Andre.
