From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 3 Jul 2013 05:03:05 +0000
Subject: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
 <51D26CFA.5090500@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EC4E7AB@DBDE04.ent.ti.com>
 <51D26E98.9040303@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EC4E7CC@DBDE04.ent.ti.com>
 <51D27052.6080303@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC4F8CA@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Kindly ignore this message. It was sent in wrong format.

Sorry for the noise

Regards, 
Gururaja

On Wed, Jul 03, 2013 at 10:26:57, Hebbar, Gururaja wrote:
> Below is the code snippet I was referring to
>  
>  
> From drivers/rtc/rtc-omap.c
>  
> static struct platform_device_id omap_rtc_devtype[] = {
>       {
>             .name = DRIVER_NAME,
>       },
>       [OMAP_RTC_DATA_AM3352_IDX] = {
>             .name = "am3352-rtc",
>             .driver_data = OMAP_RTC_HAS_KICKER | OMAP_RTC_HAS_IRQWAKEEN,
>       },
>       [OMAP_RTC_DATA_DA830_IDX] = {
>             .name = "da830-rtc",
>             .driver_data = OMAP_RTC_HAS_KICKER,
>      },
>       {},
> };
> MODULE_DEVICE_TABLE(platform, omap_rtc_devtype);
>  
> static const struct of_device_id omap_rtc_of_match[] = {
>       {     .compatible = "ti,da830-rtc",
>             .data       = &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
>       },
>       {     .compatible = "ti,am3352-rtc",
>             .data       = &omap_rtc_devtype[OMAP_RTC_DATA_AM3352_IDX],
>       },
>       {},
> };
> MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
>  
>  
> From arch/arm/boot/dts/am33xx.dtsi
>  
>             rtc at 44e3e000 {
>                   compatible = "ti,da830-rtc", "ti,am3352-rtc";
>                   reg = <0x44e3e000 0x1000>;
>                   interrupts = <75
>                               76>;
>                   ti,hwmods = "rtc";
>             };
>  
>  
> As seen from above snippet, 2 compatible items are specified for
> compatible dt property (ti,da830-rtc" & "ti,am3352-rtc?)
> These are the same compatibles that are mentioned in the of_device_id
> structure inside rtc-omap driver.
>  
> What I observed is, if we mention both compatible in the .dtsi file that
> are under one single of_device_id structure, the first match from the
> of_device_id structure is considered (ti,da830-rtc in above case)
>  
> To confirm, I switched the 2 compatible inside of_device_id structure as
> below
>  
>  
> static const struct of_device_id omap_rtc_of_match[] = {
>       {     .compatible = "ti,am3352-rtc",
>             .data       = &omap_rtc_devtype[OMAP_RTC_DATA_AM3352_IDX],
>       },
>       {     .compatible = "ti,da830-rtc",
>             .data       = &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
>       },
>       {},
> };
>  
> In this case, the first match from compatible field was chosen
> (ti,am3352-rtc now).
>  
>  
> Hope this is clear.
>  
> Kindly let me know when you are free to discuss.
>  
>  
> Regards
> Gururaja
>  
> > -----Original Message-----
> > From: Nori, Sekhar
> > Sent: Tuesday, July 02, 2013 11:47 AM
> > To: Hebbar, Gururaja
> > Cc: khilman at linaro.org; tony at atomide.com; Cousson, Benoit; linux-
> > omap at vger.kernel.org; devicetree-discuss at lists.ozlabs.org; linux-
> > kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > davinci-linux-open-source at linux.davincidsp.com; Bedia, Vaibhav;
> > Rajashekhara, Sudhakar; Grant Likely; Rob Herring; Rob Landley;
> > Alessandro Zummo; rtc-linux at googlegroups.com; linux-
> > doc at vger.kernel.org
> > Subject: Re: [PATCH 3/4] rtc: omap: add rtc wakeup support to
> > alarm events
> > 
> > 
> > 
> > On 7/2/2013 11:41 AM, Hebbar, Gururaja wrote:
> > > On Tue, Jul 02, 2013 at 11:39:28, Nori, Sekhar wrote:
> > >> On 7/2/2013 11:34 AM, Hebbar, Gururaja wrote:
> > >>> On Tue, Jul 02, 2013 at 11:32:34, Nori, Sekhar wrote:
> > >>>> On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
> > >>>>> On some platforms (like AM33xx), a special register
> > (RTC_IRQWAKEEN)
> > >>>>> is available to enable Alarm Wakeup feature. This register
> > needs to be
> > >>>>> properly handled for the rtcwake to work properly.
> > >>>>>
> > >>>>> Platforms using such IP should set "ti,am3352-rtc" in rtc
> > device dt
> > >>>>> compatibility node.
> > >>>>>
> > >>>>> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com
> <mailto:gururaja.hebbar@ti.com> >
> > >>>>> Cc: Grant Likely <grant.likely@linaro.org
> <mailto:grant.likely@linaro.org> >
> > >>>>> Cc: Rob Herring <rob.herring@calxeda.com
> <mailto:rob.herring@calxeda.com> >
> > >>>>> Cc: Rob Landley <rob at landley.net <mailto:rob@landley.net> >
> > >>>>> Cc: Sekhar Nori <nsekhar at ti.com <mailto:nsekhar@ti.com> >
> > >>>>> Cc: Kevin Hilman <khilman at linaro.org <mailto:khilman@linaro.org>
> >
> > >>>>> Cc: Alessandro Zummo <a.zummo@towertech.it
> <mailto:a.zummo@towertech.it> >
> > >>>>> Cc: rtc-linux at googlegroups.com
> <mailto:rtc-linux@googlegroups.com> 
> > >>>>> Cc: devicetree-discuss at lists.ozlabs.org
> <mailto:devicetree-discuss@lists.ozlabs.org> 
> > >>>>> Cc: linux-doc at vger.kernel.org <mailto:linux-doc@vger.kernel.org>
> > >>>>> ---
> > >>>>
> > >>>> [...]
> > >>>>
> > >>>>> -#define  OMAP_RTC_DATA_DA830_IDX 1
> > >>>>> +#define  OMAP_RTC_DATA_DA830_IDX       1
> > >>>>> +#define  OMAP_RTC_DATA_AM335X_IDX      2
> > >>>>>
> > >>>>>  static struct platform_device_id omap_rtc_devtype[] = {
> > >>>>>     {
> > >>>>> @@ -309,6 +321,9 @@ static struct platform_device_id
> > omap_rtc_devtype[] = {
> > >>>>>     }, {
> > >>>>>           .name = "da830-rtc",
> > >>>>>           .driver_data = OMAP_RTC_HAS_KICKER,
> > >>>>> +   }, {
> > >>>>> +         .name = "am335x-rtc",
> > >>>>
> > >>>> may be use am3352-rtc here just to keep the platform device
> > name and of
> > >>>> compatible in sync.
> > >>>
> > >>> Correct. I will update the same in v2.
> > >>>
> > >>>>
> > >>>>> +         .driver_data = OMAP_RTC_HAS_KICKER |
> > OMAP_RTC_HAS_IRQWAKEEN,
> > >>>>>     },
> > >>>>>     {},
> > >>>>
> > >>>> It is better to use the index defined above in the static
> > initialization
> > >>>> so they remain in sync.
> > >>>
> > >>> Sorry. I didn?t get this.
> > >>>
> > >>
> > >> See example below I provided. If its still not clear, let me
> > know what
> > >> is not clear.
> > >>
> > >>>>      ...
> > >>>>      [OMAP_RTC_DATA_DA830_IDX] = {
> > >>>>            .name = "da830-rtc",
> > >>>>            .driver_data = OMAP_RTC_HAS_KICKER,
> > >>>>      },
> > >
> > > Thanks for the clarification. In this case will it ok if I
> > update the previous
> > > member also.
> > 
> > You dont really reference [0] in omap_rtc_of_match[] so even if
> > you
> > leave it as-is, that's fine with me. I am mostly concerned with
> > the
> > index definitions and initialization order being out of sync and
> > that's
> > really not an issue with [0].
> > 
> > Thanks,
> > Sekhar
> 
