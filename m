From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 00:20:59 +0200
Subject: [PATCH 5/8] pinctrl: aspeed: Enable capture of off-SCU pinmux
 state
In-Reply-To: <CACPK8Xc7y3GtcJCVYYs-JKTqBZvqVeZaz5MUk=UX151SX1xEFw@mail.gmail.com>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <a266046d34009e6e92c4c76699c550c2ba44bd5c.1474986045.git-series.andrew@aj.id.au>
 <CACPK8Xc7y3GtcJCVYYs-JKTqBZvqVeZaz5MUk=UX151SX1xEFw@mail.gmail.com>
Message-ID: <CACRpkdazJzE=Oa-0-FEYTvUk=-kPLojHY3afZKX5cpmzrUZHGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 8:45 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Wed, Sep 28, 2016 at 12:20 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

>> On the AST2400 and AST2500 a number of pins depend on state in one of
>> the SIO, LPC or GFX IP blocks, so add support to at least capture what
>> that state is. The pinctrl engine for the Aspeed SoCs doesn't try to
>> inspect or modify the state of the off-SCU IP blocks. Instead, it logs
>> the state requirement with the expectation that the platform
>> designer/maintainer arranges for the appropriate configuration to be
>> applied through the associated drivers.
(...)
>
> This is unfortunate.
>
> This patch kicks the can down the road, but doesn't solve the problem
> for a user who wants to configure some functionality that depends on
> the non-SCU bits. Because of this I'm not sure if we want to put it in
> the tree.
>
> However, I'm not sure what a proper solution would look like. Perhaps
> Linus can point out another SoC that has a similar problem?

If I could only understand it.

Don't you actually want to go and read a few registers on another
IO range?

What we generally do when pin control is spread out in a system is try
to consolidate it, meaning expose the necessary registers on the remote
end using syscon (drivers/mfd/syscon) so that we can easily get a handle
on these registers withe regmap MMIO.

Since regmap handles atomic access to the registers, that way we
protect from disasters and keep the state in the hardware.

I don't know if this is helpful. For a normal peripheral you may not want
to put a regmap over all its registers but you prefer to ioremap it, and then
we get the spaghetti of accessor functions to peek and poke into another
peripherals I/O space, and that is undesireable.

Maybe this is completely not understanding what you want to do, so
sorry, please elaborate. I am afraid the two of you are the only people on
the planet who actually understand what is going on here.

Also the hardware engineer who wrote the Aspeed pin controller, I would
like to read this persons design specification, I am pretty sure it is very
interesting.

>> -  * @reg: The register offset from base in bytes
>> +  * @reg: Split into three fields:
>> +  *       31:24: IP selector
>> +  *       23:12: Reserved
>> +  *       11:0: Register offset

That seems like unnecessary shoehorning. Is it reflecting the register layout
of the hardware or are you trying to save bits? For the latter, let it
go and instead
have one member for offset and one member for selector.

Yours,
Linus Walleij
