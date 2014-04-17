From: carlo@caione.org (Carlo Caione)
Date: Thu, 17 Apr 2014 12:06:34 +0200
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <20140411161813.GF28800@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
 <20140411161813.GF28800@sirena.org.uk>
Message-ID: <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 6:18 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 11, 2014 at 03:04:32PM +0200, Carlo Caione wrote:
>> On Fri, Apr 11, 2014 at 2:29 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> +                             regulators {
>> >> +                                     compatible = "x-powers,axp20x-reg";
>
>> > This compatible isn't part of the driver.
>
>> Yes I know. The problem here is that in v4 I had to fill in the field
>> .of_compatible of the mfd_cell with "x-powers,axp20x-reg". This
>> because the regulator_dev_lookup() checks for dev->of_node when
>> looking for the supply so I needed the compatible string in the DT to
>> have the dev->of_node filled in by mfd_add_device().
>> What do you suggest? Modify the regulator driver?
>
> You're looking for regulator_bulk_register_supply_alias() in the MFD
> driver (via parent_supplies in the MFD cell probably).

Hi Mark,
I'm fighting with a small issue when using the
regulator_bulk_register_supply_alias(). Problem is that when using the
.parent_supplies entry in the MFD driver, I hit the

WARN_ON(!list_empty(&dev->devres_head));

in linux/drivers/base/dd.c#L272, but, apart from the warning,
everything seems to work correctly.
A possible explanation I gave myself is that in the mfd_add_device()
we try to use the devm_* API when the regulator device is not bound to
the driver yet (I found some information here
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104442.html).
Is this the case?

Thanks,

-- 
Carlo Caione
