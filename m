From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 08 Aug 2013 10:10:27 +0200
Subject: [PATCH V3 2/3] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <CAAgF-BdpsgQk8myq7OOk5zJ8Zxy+J6LUPb3-d40+iE2aNwdwDw@mail.gmail.com>
References: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
 <2116389.OxrlCQ9LXd@amdc1227>
 <CAAgF-BdpsgQk8myq7OOk5zJ8Zxy+J6LUPb3-d40+iE2aNwdwDw@mail.gmail.com>
Message-ID: <3759902.V2gf68Lg3g@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 of August 2013 13:13:02 Padma Venkat wrote:
> Hi Tomasz,
> 
> On Wed, Aug 7, 2013 at 4:43 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > Ahh, one more thing inline.
> 
> [snip]
> 
> >> +static struct samsung_i2s_dai_data i2sv3_dai_type = {
> >> +     .dai_type = TYPE_PRI,
> >> +     .quirks = QUIRK_NO_MUXPSR,
> >> +};
> >> +
> >> +static struct samsung_i2s_dai_data i2sv4_dai_type = {
> >> +     .dai_type = TYPE_PRI,
> >> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_NO_MUXPSR,
> >> +};
> >> +
> >> +static struct samsung_i2s_dai_data i2sv5_c100_dai_type = {
> >> +     .dai_type = TYPE_PRI,
> >> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_NO_MUXPSR | QUIRK_SEC_DAI |
> >> +                     QUIRK_NEED_RSTCLR,
> >> +};
> >> +
> >> +static struct samsung_i2s_dai_data i2sv5_dai_type = {
> >> +     .dai_type = TYPE_PRI,
> >> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR,
> >> +};
> >> +
> >> +static struct samsung_i2s_dai_data samsung_dai_type_sec = {
> >> +     .dai_type = TYPE_SEC,
> >> +};
> >> +
> >> 
> >>  static struct platform_device_id samsung_i2s_driver_ids[] = {
> >>  
> >>       {
> >> 
> >> -             .name           = "samsung-i2s",
> >> -             .driver_data    = TYPE_PRI,
> >> +             .name           = "samsung,s3c6410-i2s",
> >> +             .driver_data    = (kernel_ulong_t)&i2sv3_dai_type,
> >> +     }, {
> >> +             .name           = "samsung,s3c6410-i2s-multi",
> >> +             .driver_data    = (kernel_ulong_t)&i2sv4_dai_type,
> >> +     }, {
> >> +             .name           = "samsung,s5pc100-i2s",
> >> +             .driver_data    = (kernel_ulong_t)&i2sv5_c100_dai_type,
> >> 
> >>       }, {
> >> 
> >> -             .name           = "samsung-i2s-sec",
> >> -             .driver_data    = TYPE_SEC,
> >> +             .name           = "samsung,s5pv210-i2s",
> >> +             .driver_data    = (kernel_ulong_t)&i2sv5_dai_type,
> >> +     }, {
> >> +             .name           = "samsung-i2s-sec",
> >> +             .driver_data    =
> >> (kernel_ulong_t)&samsung_dai_type_sec,
> > 
> > I don't think you need to change the legacy platform IDs at all.
> 
> If legacy platforms not required to change then I need to introduce a
> new samsung_i2s_dai_data structure which holds only dai_type for
> non-dt platforms. If I change legacy platforms it breaks the older
> platforms now. Is it okay adding a samsung_i2s_dai_data structure for
> non-dt platforms which will be removed later?

Sorry, I don't understand the problem here.

Original contents of samsung_i2s_driver_ids[] array already conveyed 
information about dai type inside driver_data field of each 
platform_device_id entry.

If you really need to have samsung_i2s_dai_data struct for both DT and 
non-DT cases you can create dummy dai_data for both platform ID entries, 
which would have only dai type field initialized. This would be fine, 
because the non-DT probe path takes anything else from platform_data and 
would not need samsung_i2s_dai_data struct in any other way than getting 
dai_type in probe.

Best regards,
Tomasz

> > IMHO it would be better to keep the old way of quirk retrieval from
> > platform_data (which I think this patch does anyway, because the probe
> > path without DT is unchanged), as it will be dropped in some point in
> > time anyway.
> > 
> > This would also eliminate the need for patch 1.
> > 
> > Best regards,
> > Tomasz
> 
> Thanks
> Padma
