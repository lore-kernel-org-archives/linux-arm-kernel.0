From: stefan@agner.ch (Stefan Agner)
Date: Mon, 30 Mar 2015 15:11:55 +0200
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
In-Reply-To: <20150330095820.GD17728@pengutronix.de>
References: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
 <139dc298c0914b3536445dddd37be286@agner.ch>
 <CACRpkdZ5UqTCHqXjBF5JWjmzHkbh2vwdDvTtn+UOkmrcmKxf9A@mail.gmail.com>
 <20150330095820.GD17728@pengutronix.de>
Message-ID: <aee354623d135ce40177effddeafcbbd@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-30 11:58, Uwe Kleine-K?nig wrote:
> On Mon, Mar 30, 2015 at 11:40:47AM +0200, Linus Walleij wrote:
>> On Fri, Mar 27, 2015 at 11:32 AM, Stefan Agner <stefan@agner.ch> wrote:
>> > On 2015-03-24 16:26, Markus Pargmann wrote:
>>
>> >> 0 is used in all pinfunction definitions when a config register is not
>> >> available, for example imx25-pinfunc.h. If a configuration value is used
>> >> for such a pinfunction the driver will always write it to the
>> >> configuration register if it is not -1. For a 0 configuration register
>> >> the configuration value is written to offset 0x0. This can lead to a
>> >> crashing/hanging system without any warning message.
>> >
>> > 0 is a valid offset for Vybrid's mux register, however, since Vybrid set
>> > the SHARE_MUX_CONF_REG, intepreting a 0 in conf_reg as "not set"
>> > actually works.
>> >
>> > What is a bit a bummer is that we now have different meanings of 0,
>> > depending on the field:
>> > - For the first field (mux), 0 is a valid offset
>> > - For the second field (config), 0 means not valid
>>
>> What is generally scary about DTS files is that the DT formats
>> are not ruled by a context-free grammar.
>>
>> There were attempts to formalize some bindings using BNF
>> but they seems to have been given up.
>>
>> We need to combat this by trying to be strict and logic ...
>> I can't really understand from the discussion here whether
>> the patch should be applied or not, so I'm not applying it
>> until Stefan | Uwe gives an explicit ACK.
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> I just have a small bad feeling because -1 and 0 both mean "no config
> register". But that is a problem already there without Markus' patch.
> And I see that this patch really fixes a problem. As Stefan sait it
> should be fine for Vybrid I think applying it is the right thing to do
> here.

Yes, that is how I feel too. As far as I see the situation, it is too
late to be strict and logic here. We already have device trees out there
which use that different logic, it is only that currently, the code
interprets that wrong. This probably worked once, and is actually a
regression fix of 3dac1918a491 ("pinctrl: imx: detect uninitialized
pins").

For a better future, we could add a define like IMX_NO_PAD_CTL, which
uses the highest bit to define that a register does not exist. This
would make sure that we don't have a collision with a valid offset (0)
as we have today...

To be sure that this does not introduce another regression on Vybrid, I
also quickly tested the patch on Vybrid. The pinmux worked smoothly,
hence:
Tested-by: Stefan Agner <stefan@agner.ch>
Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Best regards
> Uwe
