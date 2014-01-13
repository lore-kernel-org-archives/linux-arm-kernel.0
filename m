From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 10:19:14 +0800
Subject: DT include files
In-Reply-To: <201401122121.20084.arnd@arndb.de>
References: <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <201401111415.29395.arnd@arndb.de>
 <20140112032516.GA23525@S2101-09.ap.freescale.net>
 <201401122121.20084.arnd@arndb.de>
Message-ID: <20140113021912.GB23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 09:21:19PM +0100, Arnd Bergmann wrote:
> I was under the impression that the generic pinctrl binding was designed
> in a way to let you assign labels to each possible (reasonable)
> configuration so you didn't have get to this level of detail at the
> driver.

The generic part of pinctrl binding only covers the procedure how a
client device get its pinctrl state configuration from a pin controller
node.  That's what we defined in bindings/pinctrl/pinctrl-bindings.txt
and implemented in pinctrl core.  But the details of how a pinctrl state
configuration should be interpreted for a particular pin controller is
defined by individual pin controller binding like fsl,imx-pinctrl.txt,
and implemented in the pin controller driver like
drivers/pinctrl/pinctrl-imx.c.

> I'm also surprised that you have to know multiple constants
> (mux register, input register, config register offsets) to select a
> particular pin. I would have expected that you could have one constant
> from which the driver is able to compute the other ones.

That's what we do before.  We define a constant in the binding and have
the driver to maintain these data and look up the data using the
constant.  See commit below for imx6q example.

  d8fe357 pinctrl: pinctrl-imx: add imx6q pinctrl driver

The biggest problem with that approach is we have huge data to maintain
in the driver because of the complexity and flexibility of IMX pin
controller design.  And these data can not be init data.  Check that big
array of struct imx_pin_reg in commit above for what I'm talking about.
So when we build a v7 kernel image for IMX, we will have such big array
for each of these SoCs, imx50, imx51, imx53, imx6sl, imx6dl, imx6q, and
more to come.

That's why we went through the pain of breaking DT compatibility to move
all these data into device tree one year ago with the commit below.

  e164153 pinctrl: imx: move hard-coding data into device tree

Now kernel gets released from the floating and we do not even need to
touch kernel to add these data when new SoC support is added.

Shawn
