From: robherring2@gmail.com (Rob Herring)
Date: Fri, 7 Aug 2015 08:58:30 -0500
Subject: [PATCH v3 06/18] regulator: core: Probe regulators on demand
In-Reply-To: <20150807120906.GR20873@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-7-git-send-email-tomeu.vizoso@collabora.com>
 <20150807120906.GR20873@sirena.org.uk>
Message-ID: <CAL_JsqJf-ZeAhJjkd-6sPH12xL3FX9pOyTBMYHsvS8PnOkAXDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 7, 2015 at 7:09 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 06, 2015 at 04:11:43PM +0200, Tomeu Vizoso wrote:
>
>> When looking up a regulator through its OF node, probe it if it hasn't
>> already.
>>
>> The goal is to reduce deferred probes to a minimum, as it makes it very
>> cumbersome to find out why a device failed to probe, and can introduce
>> very big delays in when a critical device is probed.
>
> Still the same problem as we had before with this stuff, why is this DT
> only?

The last version was more generic, but it was obvious that doing that
was pointless with current code structure. You have a call sequence
like either:

generic get -> DT specific get -> generic poke  -> DT specific poke

or

generic get -> DT specific get -> DT specific poke

v2 did the former and this version does the latter. However, for some
reason with regulators this is not all contained within
of_get_regulator.

>
>>  #include <linux/regulator/consumer.h>
>> @@ -1336,6 +1337,7 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
>>       if (dev && dev->of_node) {
>>               node = of_get_regulator(dev, supply);
>>               if (node) {
>> +                     of_platform_probe(node);
>
> And why the assumption that this is a platform device?

Agreed on this point.

Rob
