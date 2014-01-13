From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jan 2014 10:26:10 -0800
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <CACRpkdboVtY2nBxGeWj_ReHJ5J8WuyuPHCwHM=yELBdePkX7Vw@mail.gmail.com>
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
 <87bo0clved.fsf@linaro.org> <20131219221758.GS14866@pengutronix.de>
 <20131220184715.GT14866@pengutronix.de>
 <52CBE3DE.5010706@atmel.com>
 <CACRpkdboVtY2nBxGeWj_ReHJ5J8WuyuPHCwHM=yELBdePkX7Vw@mail.gmail.com>
Message-ID: <CAOesGMgLuR_HSHZjHLGcgQrnaoYHCqGOXE-Tab=DNC5qc2YfGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 5:36 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jan 7, 2014 at 12:24 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> On 20/12/2013 19:47, Uwe Kleine-K?nig :
>
>>> Please pull
>>>
>>>       git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh
>>>
>>> which points to 79f08d9ed217318b4f325b7fcf8f26dcd0e41689 now provided
>>> you are happy with Linus W.'s series, too.
>>
>> Hi all,
>>
>> Is this pull-request is foreseen to be integrated in arm-soc for 3.14? I
>> may have some material for Linus W. that I would like to queue that
>> depend on these patches.
>
> I'd like to know the status here. If the <timex.h> material is not
> going into v3.14 I'd very much like my single patch to the serial
> driver to go in, and the removal of AT91's <mach/gpio.h>.

Uwe made it a pain to review these patches, so it's taking a while.
Instead of removing the header contents in the same commit, he just
adds to the non-include-file code so I have to manually go find the
right include file, check the value, and then move to the next one.
Since he removes the headers in the last change that means checking
out a different tree back and forth.

> In that case I'm requesting an ACK on the ARM portions from the
> ARM SoC folks, so I can take it through the GPIO tree.

Most of the series looks OK, but the IXP4xx change looks fishy. This
is exactly why I wanted to get the header touched at the same time. It
says:


/*
 * We use IXP425 General purpose timer for our timer needs, it runs at
 * 66.66... MHz. We do a convulted calculation of CLOCK_TICK_RATE b/c the
 * timer register ignores the bottom 2 bits of the LATCH value.
 */
#define IXP4XX_TIMER_FREQ 66666000
#define CLOCK_TICK_RATE \
        (((IXP4XX_TIMER_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)



But all he does in the C file now is:

+#define IXP4XX_TIMER_FREQ 66666000
+#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, HZ)

So it seems that this code is now broken. Uwe?


-Olof
