From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Jan 2013 09:59:53 +0100
Subject: [PATCH 04/18] power: ab8500_fg: Replace msleep() with
 usleep_range() for greater accuracy
In-Reply-To: <20130115084821.GT12385@gmail.com>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
 <1357909986-9262-5-git-send-email-lee.jones@linaro.org>
 <1358183857.19400.13.camel@joe-AO722>
 <20130115084821.GT12385@gmail.com>
Message-ID: <CACRpkdY2Lxhct53qGJVAmVUrQM8hb1gYRUJZ=oLpAQAd6x36KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 9:48 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 14 Jan 2013, Joe Perches wrote:

>> > -           msleep(5);
>> > +           usleep_range(5000, 5001);
>>
>> If you're going to give a range that small
>> you might as well use usleep instead.
>>
>> Otherwise, add some tolerance to allow any
>> other coalesced wakeup to occur.
>
> I can't increase the tolerance, as I don't know how that would
> effect the running of the system, and the person who would know
> is off on parental leave.
>
> What I can tell you is we're only using usleep_range() because
> there is no usleep in the kernel. At least that's what we've
> been led to believe:
>
> Documentation/timers/timers-howto.txt:
>
>                 - Why is there no "usleep" / What is a good range?
>                         Since usleep_range is built on top of hrtimers, the
>                         wakeup will be very precise (ish), thus a simple
>                         usleep function would likely introduce a large number
>                         of undesired interrupts.

And I think the above is why we have this in the kernel:
arch/arm/mach-davinci/board-da850-evm.c:
usleep_range(1000, 1000);
arch/arm/mach-tegra/pcie.c:             usleep_range(1000, 1000);
drivers/clk/clk-wm831x.c:       usleep_range(2000, 2000);
drivers/media/i2c/m5mols/m5mols_core.c: usleep_range(200, 200);
drivers/media/i2c/s5k6aa.c:     usleep_range(4000, 4000);
drivers/media/i2c/smiapp/smiapp-core.c: usleep_range(1000, 1000);
drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:
usleep_range(1000, 1000);

There are quite a few of these.

Let's ping John Stultz for some clarification ...

Yours,
Linus Walleij
