From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 19 Jan 2018 11:35:17 +0100
Subject: [PATCH] phy: work around 'phys' references to usb-nop-xceiv
 devices
In-Reply-To: <CAL_JsqKi30aUiJUdjnen+sty_2horaTVs5LFaFJdxACsvEQpkg@mail.gmail.com>
References: <20180112101223.3661181-1-arnd@arndb.de>
 <CAL_JsqKi30aUiJUdjnen+sty_2horaTVs5LFaFJdxACsvEQpkg@mail.gmail.com>
Message-ID: <c38e54f7-4dbd-72dc-e1fb-9003435cbe0e@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.01.2018 um 20:54 schrieb Rob Herring:
> On Fri, Jan 12, 2018 at 4:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Stefan Wahren reports a problem with a warning fix that was merged
>> for v4.15: we had lots of device nodes with a 'phys' property pointing
>> to a device node that is not compliant with the binding documented in
>> Documentation/devicetree/bindings/phy/phy-bindings.txt
>>
>> This generally works because USB HCD drivers that support both the generic
>> phy subsystem and the older usb-phy subsystem ignore most errors from
>> phy_get() and related calls and then use the usb-phy driver instead.
>>
>> However, it turns out that making the usb-nop-xceiv device compatible with
>> the generic-phy binding changes the phy_get() return code from -EINVAL to
>> -EPROBE_DEFER, and the dwc2 usb controller driver for bcm2835 now returns
>> -EPROBE_DEFER from its probe function rather than ignoring the failure,
>> breaking all USB support on raspberry-pi when CONFIG_GENERIC_PHY is
>> enabled. The same code is used in the dwc3 driver and the usb_add_hcd()
>> function, so a reasonable assumption would be that many other platforms
>> are affected as well.
>>
>> I have reviewed all the related patches and concluded that "usb-nop-xceiv"
>> is the only USB phy that is affected by the change, and since it is by far
>> the most commonly referenced phy, all the other USB phy drivers appear
>> to be used in ways that are are either safe in DT (they don't use the
>> 'phys' property), or in the driver (they already ignore -EPROBE_DEFER
>> from generic-phy when usb-phy is available).
>>
>> To work around the problem, this adds a special case to _of_phy_get()
>> so we ignore any PHY node that is compatible with "usb-nop-xceiv",
>> as we know that this can never load no matter how much we defer. In the
>> future, we might implement a generic-phy driver for "usb-nop-xceiv"
>> and then remove this workaround.
>>
>> Since we generally want older kernels to also want to work with the
>> fixed devicetree files, it would be good to backport the patch into
>> stable kernels as well (3.13+ are possibly affected), even though they
>> don't contain any of the patches that may have caused regressions.
>>
>> Fixes: 014d6da6cb25 ARM: dts: bcm283x: Fix DTC warnings about missing phy-cells
>> Fixes: c5bbf358b790 arm: dts: nspire: Add missing #phy-cells to usb-nop-xceiv
>> Fixes: 44e5dced2ef6 arm: dts: marvell: Add missing #phy-cells to usb-nop-xceiv
>> Fixes: f568f6f554b8 ARM: dts: omap: Add missing #phy-cells to usb-nop-xceiv
>> Fixes: d745d5f277bf ARM: dts: imx51-zii-rdu1: Add missing #phy-cells to usb-nop-xceiv
>> Fixes: 915fbe59cbf2 ARM: dts: imx: Add missing #phy-cells to usb-nop-xceiv
>> Link: https://marc.info/?l=linux-usb&m=151518314314753&w=2
>> Link: https://patchwork.kernel.org/patch/10158145/
>> Cc: stable at vger.kernel.org
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: Felipe Balbi <balbi@kernel.org>
>> Cc: Eric Anholt <eric@anholt.net>
>> Tested-by: Hans Verkuil <hans.verkuil@cisco.com>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Hans tested the earlier version of this patch, I'd like one more
>> confirmation from Hans or Stefan (or anyone else) that this version
>> addresses the regression as well before this gets merged.
>>
>> Greg, can you pick this up into usb-linus for v4.15 once the fix
>> has been confirmed, or should I merge it through arm-soc?
>> ---
>>  drivers/phy/phy-core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> Thanks for fixing this.
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> Rob

ping ...
