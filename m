From: joel@jms.id.au (Joel Stanley)
Date: Mon, 11 Dec 2017 21:14:23 +1030
Subject: [PATCH 05/20] ARM: dts: aspeed: Add proper clock references
In-Reply-To: <CAK8P3a10wjXvFpE5zbwCfQNC-UiRCzKE+9-ENg-Sr577ZCF+Xw@mail.gmail.com>
References: <20171211050704.20621-1-joel@jms.id.au>
 <20171211050704.20621-6-joel@jms.id.au>
 <CAK8P3a10wjXvFpE5zbwCfQNC-UiRCzKE+9-ENg-Sr577ZCF+Xw@mail.gmail.com>
Message-ID: <CACPK8XeTtiejw1SyDHNn5w6be-FqCQFuT5PT-yeRho2Hhs2K8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 6:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Dec 11, 2017 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
>> The existing device trees use fixed-clocks in order to boot without a
>> clk driver. The newly added clk driver provides proper clock support,
>> including gating, so we move the device trees over to properly request
>> clocks.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Can you clarify here whether this will break running old kernels with
> new DT files or vice versa, and why this is ok here?

This device tree will break kernels that do not have the clk patches
applied (no clocksource, as we don't know the speed of the APB clock.
You can boot if you pass a lpj value on the command line, but won't
have a uart).

Older device trees running with the newer kernel will function as well
as pre-4.16 kernels. That is, that some IP blocks (i2c, pwm/tach, adc)
will not work as the kernel lacks reset controller and clock enabling.

> I assume you have thought about it carefully, but I'd still like to document
> every time we intentionally break compatibility like this. It looks like
> you too care to merge the driver changes and the DT binding change first,
> so we don't get any bisection problems.

Thanks for calling it out. I will modify the commit message to say
that this device tree change depends on the newer driver, and it will
not boot with kernels that lack the driver.

>
> What I'm not completely clear about is the difference between the
> "aspeed,g4-scu" binding and the "aspeed,ast2400-scu" binding.
> They are listed as equal in
> Documentation/devicetree/bindings/mfd/aspeed-scu.txt, so why do you
> change it here?

The g4-scu string made it into the tree before we had decided that we
would settle on aspeed,astX000-<ip> as the format for the strings. We
list both in the docs, but I would like to deprecate the old one.

If I was doing this again, I would make sure we had the clock driver
upstream before completing the other driver. It's caused a lot of
pain. Thanks for your help getting us there.

Cheers,

Joel
