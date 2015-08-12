From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 12 Aug 2015 22:20:57 +0800
Subject: [PATCH] regmap: Add function check before called format_val
In-Reply-To: <1437458845.30329.51.camel@mtksdaap41>
References: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
 <20150720150254.GC11162@sirena.org.uk> <1437458845.30329.51.camel@mtksdaap41>
Message-ID: <CAGS+omDa+FhKD2u_VwBG3cWvN+ZiHneqFVz=mtdYuPsiQu4JEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Henry & Mark,

On Tue, Jul 21, 2015 at 2:07 PM, Henry Chen <HenryC.Chen@mediatek.com> wrote:
> On Mon, 2015-07-20 at 16:02 +0100, Mark Brown wrote:
>> On Mon, Jul 20, 2015 at 08:41:50PM +0800, Henry Chen wrote:
>> > The regmap_format will not be initialize since regmap_bus is not assgined
>> > on regmap_init(). It should has a function check before using
>> > format_val() to avoid null function called on regmap_bulk_read().
>>
>> > -                   map->format.format_val(val + (i * val_bytes), ival, 0);
>> > +                   if (map->format.format_val)
>> > +                           map->format.format_val(val + (i * val_bytes), ival, 0);
>> > +                   else
>> > +                           memcpy(val + (i * val_bytes), &ival, val_bytes);
>>
>> Your changelog doesn't explan why we are in this code path in the first
>> place without a format_val() and why a memcpy() is an appropriate
>> replacement.  It should, it's not clear to me that this is a good fix
>> but I don't feel I fully understand the problem.
>
> Sorry for being unclear for issue, the call flow as following,
>
> First, in drivers/mfd/mtk_pmic_wrap.c which registered regmap without
> rebmap_bus.
> devm_regmap_init(wrp->dev, NULL, wrp, &pwrap_regmap_config);
>
> It call to regmap_init() and go to "skip_format_initialization" because
> regmap_bus didn't assign by driver.
>
> if (!bus) {
>         map->reg_read  = config->reg_read;
>         map->reg_write = config->reg_write;
>
>         map->defer_caching = false;
>         goto skip_format_initialization;"
>
> Then in driver rtc-mt6397.c, it used regmap_bulk_read() to get the time
> of PMIC, and hit the null function of format_val(), because the
> regmap_bus was null.
>
> It skipped the initialization of format_val() because bus == null, but
> called the format_val() at regmap_bulk_read() if bus == null.
>
> Maybe it was not the good fix for this, but should be a problem need to
> be reported, or should I need to give the regmap_bus on mtk_pmic_wrap.c?

I ran into this bug when testing Matthias' v4.2-next/for-next branch
on mt8173.  It now crashes on boot.

Since I didn't see it elsewhere in this discussion, I'll point out
that the "regression" here was introduced by commit [0], which added
the call to map->format.format_val from regmap_bulk_read() when
map->bus == NULL.

[0] commit 15b8d2c41fe5839582029f65c5f7004db451cc2b
  Author: Arun Chandran <achandran@mvista.com>
  regmap: Fix regmap_bulk_read in BE mode

Perhaps the easiest work around to unbreak v4.2 is, as Henry mentions,
for mtk_pmic_wrap to define its own regmap_bus, with .read() &
.write() handlers.  This way they will inherit the default built-in
format_val() from the regmap core.

Making mtk_pmic-wrap into a regmap_bus makes a bit of sense
architecturally, too, since it is essentially just a bus for accessing
the registers of an off-chip PMIC.  The CPU sees a platform bus, but
the registers of the remote PMIC are accessed over a dedicated SPI
bus.

WDYT?

Henry, can you try to implement this?

Thanks,
-Dan
