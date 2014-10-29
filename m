From: dianders@chromium.org (Doug Anderson)
Date: Wed, 29 Oct 2014 09:51:32 -0700
Subject: [PATCH v6 7/7] ARM: dts: add suspend voltage setting for RK808
In-Reply-To: <545115DF.9070008@collabora.co.uk>
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
 <1414583525-17395-8-git-send-email-zyw@rock-chips.com>
 <CAD=FV=XeGj63_MEPL5i1ihUORuHnwD1ktEjJN5x=B-tkHV088w@mail.gmail.com>
 <545115DF.9070008@collabora.co.uk>
Message-ID: <CAD=FV=VtKdLH51tDvHsRfMYah9cUNcNRfbVJ1rfroxwsZZLTsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Wed, Oct 29, 2014 at 9:29 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
>>> @@ -76,6 +80,7 @@
>>>                                 regulator-min-microvolt = <3300000>;
>>>                                 regulator-max-microvolt = <3300000>;
>>>                                 regulator-name = "vccio_pmu";
>>> +                               regulator-suspend-mem-microvolt = <3300000>;
>>
>> Similarly this property isn't upstream.  You can see Javier's work on
>> this in <https://patchwork.kernel.org/patch/5106351/> and I think
>> you'll need an rk808-specific patch just like he needs an max77802
>> patch.  You probably want to wait for him to spin it first, though,
>> since Mark had feedback on his last patch.
>>
>
> I'm working on adding support to configure the regulator mode on startup
> and when the system enters in a suspend state.
>
> As Doug said I've to re-spin since Mark wanted things to be more integrated
> with the core. So I'm doing some refactoring to pass the static regulator
> descriptor to the function extracting the regulator initial data so drivers
> should only define a function handler that does the modes translation.
> I believe this is the more sensible place to add the mapping function since
> the modes translation should be a non-varying property of the regulator.
>
> Having said that, I see a different use case here. You want to set a voltage
> on system suspend. But the value is the same that is set to your fixed
> regulator so I wonder if what you want here is to enable the regulator on
> suspend instead?
>
> In other words, do you want the core to call rk808_set_suspend_voltage() or
> rk808_set_suspend_enable()? If the later then you can use Chanwoo's bindings:
>
> regulator-state-mem {
>    regulator-on-in-suspend;
> };

The rk808 has a separate register for storing the sleep voltage,
though.  ...so just using "regulator-on-in-suspend" without any
changes to the rk808 driver won't get us this "for free".  I'd expect
to need

 regulator-state-mem {
    regulator-on-in-suspend;
    regulator-suspend-microvolts = <3300000>;
 };

IMHO it wouldn't be insane to say that if someone has
"regulator-on-in-suspend" but no suspend voltage defined that it
should carry forward the runtime voltage.  I actually argued for that
earlier and Mark Brown said "no" at
<http://marc.info/?l=linux-kernel&m=141277262106368&w=2>.  More at
<http://marc.info/?l=linux-kernel&m=141279245027919&w=2>.  It's
entirely possible I wasn't making myself clear, though.

-Doug
