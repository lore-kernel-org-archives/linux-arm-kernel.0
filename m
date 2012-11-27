From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Nov 2012 15:16:20 +0100
Subject: [PATCH] clk: ux500: assume PRCC clocks are off by default
In-Reply-To: <CAPDyKFrqvtFJZHi3tGQ6x8tyHXv6-S7K8_CrqCYf8TQJ0h6jFw@mail.gmail.com>
References: <1354024310-22021-1-git-send-email-linus.walleij@stericsson.com>
 <CAPDyKFrqvtFJZHi3tGQ6x8tyHXv6-S7K8_CrqCYf8TQJ0h6jFw@mail.gmail.com>
Message-ID: <CACRpkdZEFVs+OMT2d3=KoTimpJ_HYFq3aL1EvoL4qQdjtocs2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 2:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 27 November 2012 14:51, Linus Walleij <linus.walleij@stericsson.com> wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>

>> So instead assume that the PRCC clocks are *not* on, and
>> everything starts working. This may cause a few extra writes
>> to the enable registers but it's worth it. We cannot read
>> the status registers to find out if the clock is on at
>> this point as that means we first have to turn on the
>> clock to the peripheral cluster.
>>
>> Reported-by: Lee Jones <lee.jones@linaro.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Philippe Begnic <philippe.begnic@st.com>
>> Cc: Per Forlin <per.forlin@stericsson.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Mike: this needs to go into v3.7. (Yes, sorry for not seeing
>> this earlier, but the problem did manifest itself in very
>> strange ways.) If v3.7 is not possible, make sure to add the
>
> Hold on!
>
> I see what you are trying to solve. But the next problem when going
> ahead with this patch is that some clocks, which are default on, will
> be kept on unless some client explicit disables it. This is not OK. I
> will get back to you with some more ideas how to proceed.

OK ... well that means if we don't come up with a better solution
we need to choose the lesser of two evils:

- Apply this and get a power regression

- Not apply this and get a GPIO regression which cascades
  to child devices, for example STMPE keypad and SD Card
  detect on older boards is
  not working at all without this.

So let's see if we can fix the perfect patch to avoid having to
choose...

Yours,
Linus Walleij
