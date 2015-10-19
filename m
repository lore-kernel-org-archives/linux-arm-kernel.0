From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Oct 2015 14:20:29 +0800
Subject: [linux-sunxi] Re: [PATCH 3/6] mfd: axp20x: Add support for RSB
 based AXP223 PMIC
In-Reply-To: <20151019060226.GQ2711@lukather>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
 <1444840342-9233-4-git-send-email-wens@csie.org>
 <20151016064159.GG2711@lukather>
 <CAGb2v66B8EbTZkVrt3QT85fKCwOjL8OBWfQvcLHrLAe6NfavNA@mail.gmail.com>
 <20151019060226.GQ2711@lukather>
Message-ID: <CAGb2v66y9+_iemTn-AXQUPBRX=ZEQFfXgbVnwRzviDNfCSm_eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 2:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Oct 16, 2015 at 02:46:23PM +0800, Chen-Yu Tsai wrote:
>> On Fri, Oct 16, 2015 at 2:41 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Thu, Oct 15, 2015 at 12:32:19AM +0800, Chen-Yu Tsai wrote:
>> >> The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
>> >> It is functionally identical to AXP221; only the regulator default
>> >> voltage/status and the external host interface are different.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >> ---
>> >>  drivers/mfd/Kconfig        | 12 ++++++
>> >>  drivers/mfd/Makefile       |  1 +
>> >>  drivers/mfd/axp20x-core.c  |  2 +
>> >>  drivers/mfd/axp20x-rsb.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++
>> >>  include/linux/mfd/axp20x.h |  1 +
>> >>  5 files changed, 109 insertions(+)
>> >>  create mode 100644 drivers/mfd/axp20x-rsb.c
>> >>
>> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> >> index 9ba3feb3f2fc..6e5edb61d42e 100644
>> >> --- a/drivers/mfd/Kconfig
>> >> +++ b/drivers/mfd/Kconfig
>> >> @@ -84,6 +84,7 @@ config MFD_BCM590XX
>> >>  config MFD_AXP20X
>> >>       bool "X-Powers AXP series PMICs"
>> >>       select MFD_AXP20X_I2C
>> >> +     select MFD_AXP20X_RSB
>> >>
>> >>  config MFD_AXP20X_CORE
>> >>       bool
>> >> @@ -102,6 +103,17 @@ config MFD_AXP20X_I2C
>> >>         components like regulators or the PEK (Power Enable Key) under the
>> >>         corresponding menus.
>> >>
>> >> +config MFD_AXP20X_RSB
>> >> +     bool "X-Powers AXP series RSB PMICs"
>> >> +     select MFD_AXP20X_CORE
>> >> +     depends on SUNXI_RSB=y
>> >
>> > Do we need that? Even if the bus is compiled as a module, the driver
>> > will not be probed before that, will it?
>>
>> There's a compile/link dependency on the __devm_regmap_init_sunxi_rsb().
>
> If it's exported, everything should be fine, no?
>
>> And both drivers are bool, i.e. can't be compiled as a module. What we
>> don't want is enabling MFD_AXP20X_RSB without SUNXI_RSB.
>
> What would really be the issue here? The driver wouldn't be probed,
> and that's it. Or am I missing something?

The RSB bus / slave device functions have been merged into the RSB driver
itself. Enabling MFD_AXP20X_RSB without enabling SUNXI_RSB means that RSB
bus/device related functions are not compiled, i.e. link error:

drivers/built-in.o: In function `axp20x_rsb_probe':
/home/wens/sunxi/linux/drivers/mfd/axp20x-rsb.c:64: undefined
reference to `__devm_regmap_init_sunxi_rsb'
drivers/built-in.o: In function `axp20x_rsb_driver_init':
/home/wens/sunxi/linux/drivers/mfd/axp20x-rsb.c:89: undefined
reference to `sunxi_rsb_driver_register'
Makefile:927: recipe for target 'vmlinux' failed

The dependency is like "depends on I2C=y" for the I2C version.

If you're asking about why "=y", I guess it's because MFD_AXP20X_RSB is bool,
and if the depended on symbol is a tristate, which it actually is for I2c,
we'd want it to be compiled in, and not built as a module, or again we'd get
a undefined reference link error.

Would it make sense to have SUNXI_RSB as a tristate symbol, i.e. can be built
as a module? I'm nore sure. For multi-platform kernels, probably? Currently it
isn't.

Hope this clears it up.


Regards
ChenYu
