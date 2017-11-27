From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Nov 2017 01:30:18 +0800
Subject: [PATCH] sunxi-rsb: Include OF based modalias in device uevent
In-Reply-To: <2479565.qdx1IVDIGC@pebbles>
References: <a99fc4e8-49e3-486a-b508-d764a952d9f8@rwthex-w2-a.rwth-ad.de>
 <20171127153502.4wcqtimppgpfklmr@flea.home> <2479565.qdx1IVDIGC@pebbles>
Message-ID: <CAGb2v67_-HA=q3+cWwVKrVuG-GaLF3xz4GNQ2+6FJZgSTN=rzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 1:19 AM, Stefan Br?ns
<stefan.bruens@rwth-aachen.de> wrote:
> On Monday, November 27, 2017 4:35:02 PM CET Maxime Ripard wrote:
>> Hi,
>>
>> On Mon, Nov 27, 2017 at 01:17:25PM +0100, Stefan Br?ns wrote:
>> > Include the OF-based modalias in the uevent sent when registering devices
>> > on the sunxi RSB bus, so that user space has a chance to autoload the
>> > kernel module for the device.
>> >
>> > Fixes a regression caused by commit 3f241bfa60bd ("arm64: allwinner: a64:
>> > pine64: Use dcdc1 regulator for mmc0"). When the axp20x-rsb module for
>> > the AXP803 PMIC is built as a module, it is not loaded and the system
>> > ends up with an disfunctional MMC controller.
>> >
>> > Cc: stable <stable@vger.kernel.org>
>> > Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
>> > ---
>> >
>> >  drivers/bus/sunxi-rsb.c | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >
>> > diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
>> > index 328ca93781cf..37cb57244cbe 100644
>> > --- a/drivers/bus/sunxi-rsb.c
>> > +++ b/drivers/bus/sunxi-rsb.c
>> > @@ -173,11 +173,24 @@ static int sunxi_rsb_device_remove(struct device
>> > *dev)>
>> >     return drv->remove(to_sunxi_rsb_device(dev));
>> >
>> >  }
>> >
>> > +static int sunxi_rsb_device_uevent(struct device *dev,
>> > +                              struct kobj_uevent_env *env)
>> > +{
>> > +   int ret;
>> > +
>> > +   ret = of_device_uevent_modalias(dev, env);
>> > +   if (ret != -ENODEV)
>> > +           return ret;
>>
>> A comment explaining why we need to ignore the ENODEV error code would
>> be great here.
>
> Lazy answer - everyone else is doing the same, and nobody cared to add an
> explanation.
>
> For *some* drivers, this is likely because the same device may be enumerated
> from e.g ACPI or OF, and for an ACPI device -ENODEV will be returned, as
> dev->of_node is NULL.
>
> For devices which are only usable in an OF context, this is bogus. Not sure
> about sunxi-rsb.

sunxi-rsb (and Allwinner support in mainline in general) is OF only. With the
exception of mfd sub-devices, if someone is enumerating devices in some other
fashion, it should rightly blow up in their face.

>> > +   return 0;
>> > +}
>> > +
>> >
>> >  static struct bus_type sunxi_rsb_bus = {
>> >
>> >     .name           = RSB_CTRL_NAME,
>> >     .match          = sunxi_rsb_device_match,
>> >     .probe          = sunxi_rsb_device_probe,
>> >     .remove         = sunxi_rsb_device_remove,
>> >
>> > +   .uevent         = sunxi_rsb_device_uevent,
>>
>> Any reason to not use of_device_uevent_modalias directly here?
>
> *If* sunxi-rsb can be used without OF, then yes, otherwise no.

You can just use of_device_uevent_modalias, like the other OF platforms.

ChenYu
