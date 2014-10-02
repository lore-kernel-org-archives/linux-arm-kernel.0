From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 02 Oct 2014 16:28:56 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <CACRpkdbtN-BDEwpJO2swnOjCe3UJhD5WOXXKBV0hPOe2M2=k7Q@mail.gmail.com>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
 <CACRpkda-K7w-bY0uSdnZvzEKEeQg38oExoHPSW61kEv9Wv20mA@mail.gmail.com>
 <20140924124044.GC4992@pengutronix.de>
 <CACRpkdbtN-BDEwpJO2swnOjCe3UJhD5WOXXKBV0hPOe2M2=k7Q@mail.gmail.com>
Message-ID: <1412260136.4875.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Am Donnerstag, den 02.10.2014, 16:02 +0200 schrieb Linus Walleij:
> On Wed, Sep 24, 2014 at 2:40 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Sep 24, 2014 at 01:23:09PM +0200, Linus Walleij wrote:
> 
> >> I haven't got to reviewing the driver, but this looks just wrong.
> >>
> >> Have the magic numbers in the driver.
> >>
> >> Use strings to describe functions, not integers.
> >
> > Interrupts, clocks, gpios, dma channels, nearly everything in the device tree is
> > arbitrarily numbered. Instead of "irq-i2c0" we have <0 36 IRQ_TYPE_LEVEL_HIGH>
> > in the device tree. These numbers can be resolved efficiently in the
> > driver by shifting them to get a bitmask or by adding them as offset to
> > a register base.
> > Why do you want to make pinctrl different?
> 
> Because pin control is about combining groups of pins with
> certain functions.
> 
> > Thanks to the recently
> > introduced defines in the device trees these numbers are not magic at
> > all anymore.
> 
> Yeah that is good but not what I'm after here.
> 
> >> We need to move toward standardized device tree bindings
> >> for this stuff, and that means using strings, not magic
> >> numbers.
> >
> > Agreed for standardized device tree bindings, but not for using strings.
> 
> What is the alternative? Device Tree is very much about strings,
> as is shown by the pin config bindings.
> 
Mhm, maybe we are still talking about different things but I just don't
get your point. Traditionally DT is more about plain numbers than
strings. Look at the early examples of PCI or other bus bindings,
defined back in the IEEE 1275 days. Almost everything back then has
been mapped to plain numbers.

Using strings only bloats the DT, not only in it's source form, but also
as a compiled DTB. Having a verbose string based binding is just painful
to work with (I can tell from experience here, as I personally built the
pinmux setup for two Tegra boards). Working with a condensed number
based binding like the one used on i.MX is much easier IMHO.

Most importantly I don't see any benefit in writing:
pin_state_a {
	pins = "i2c0_scl", "i2c0_sda";
	function = "i2c0";
};

instead of
#include <dt-binding/pinctrl/mediatek_foo.h>
pin_state_a {
	pins = <I2C0_SCL>, <I2C0_SDA>;
	function = <I2C0>;
}

Using plain integers makes it much easier to index into pinctrl driver
specific arrays without doing all this string matching in the kernel. It
seems we are eating CPU cycles here for no good reason.

Could you please explain where you see the benefit of using strings
instead of plain integers with proper binding defines attached to them?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
