From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Oct 2017 09:35:42 +0200
Subject: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
In-Reply-To: <CACPK8XeQDdisecoHo7+_7LQNxYWh7yDj99O=NxWSoHyuk7LRxg@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-12-linus.walleij@linaro.org>
 <CACRpkdbJhTmSZDudJCb_8nOfk6802Z8Op2+gjY9vdDT9Cg+6eQ@mail.gmail.com>
 <CACPK8XeQDdisecoHo7+_7LQNxYWh7yDj99O=NxWSoHyuk7LRxg@mail.gmail.com>
Message-ID: <CACRpkdazjg3C7Dt2KbTuYbMnmkeUXT7KyE=AZWSko4=ZWSb2_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 5:37 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Wed, Oct 11, 2017 at 4:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Joel could you merge this through the Aspeed tree? I think
>> the compatible string is completely uncontroversial
>> (binding ACKed) to add and all should just work fine so we
>> can slap in "EXTCLK" later as well.
>
> How do the clock-names work? I have been writing the aspeed clk driver
> and updating the bindings without clock names, and instead using a
> identifier in phandle to reference which clock the device wants.
>
> eg:
>
>  clocks = <&syscon 10>;

This works fine as long as there is just one clock.

clocks = <&syscon 10>, <&syscon 11>, <&syscon 12>;

becomes a problem, right?

clk_get() has this signature:
struct clk *clk_get(struct device *dev, const char *id);

So clk_get(dev, NULL); will return <&syscon 10>;

How to get the rest?

clocks = <&syscon 10>, <&syscon 11>, <&syscon 12>;
clock-names = "FOO", "BAR", "BAZ";

clk_get(dev, "BAR");

gets the second clock.

Yours,
Linus Walleij
