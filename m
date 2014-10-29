From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 29 Oct 2014 17:29:19 +0100
Subject: [PATCH v6 7/7] ARM: dts: add suspend voltage setting for RK808
In-Reply-To: <CAD=FV=XeGj63_MEPL5i1ihUORuHnwD1ktEjJN5x=B-tkHV088w@mail.gmail.com>
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>	<1414583525-17395-8-git-send-email-zyw@rock-chips.com>
 <CAD=FV=XeGj63_MEPL5i1ihUORuHnwD1ktEjJN5x=B-tkHV088w@mail.gmail.com>
Message-ID: <545115DF.9070008@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

On 10/29/2014 04:40 PM, Doug Anderson wrote:
>>                                 regulator-min-microvolt = <750000>;
>>                                 regulator-max-microvolt = <1300000>;
>>                                 regulator-name = "vdd_arm";
>> +                               regulator-suspend-mem-disabled;
> 
> NAK.  "regulator-suspend-mem-disabled" is a local property added by
> local Chrome OS patches and doesn't belong in an upstream submission.
> 
> You should using the new patches from Chanwoo.
> 
> 40e20d6 regulator: of: Add support for parsing regulator_state for suspend state
> 291d761 regulator: Document binding for regulator suspend state for PM state
> 
> In your case, it would look like:
> 
> regulator-state-mem {
>   regulator-off-in-suspend;
> };

Agreed.

> 
>> @@ -76,6 +80,7 @@
>>                                 regulator-min-microvolt = <3300000>;
>>                                 regulator-max-microvolt = <3300000>;
>>                                 regulator-name = "vccio_pmu";
>> +                               regulator-suspend-mem-microvolt = <3300000>;
> 
> Similarly this property isn't upstream.  You can see Javier's work on
> this in <https://patchwork.kernel.org/patch/5106351/> and I think
> you'll need an rk808-specific patch just like he needs an max77802
> patch.  You probably want to wait for him to spin it first, though,
> since Mark had feedback on his last patch.
>

I'm working on adding support to configure the regulator mode on startup
and when the system enters in a suspend state.

As Doug said I've to re-spin since Mark wanted things to be more integrated
with the core. So I'm doing some refactoring to pass the static regulator
descriptor to the function extracting the regulator initial data so drivers
should only define a function handler that does the modes translation.
I believe this is the more sensible place to add the mapping function since
the modes translation should be a non-varying property of the regulator.
 
Having said that, I see a different use case here. You want to set a voltage
on system suspend. But the value is the same that is set to your fixed
regulator so I wonder if what you want here is to enable the regulator on
suspend instead?

In other words, do you want the core to call rk808_set_suspend_voltage() or
rk808_set_suspend_enable()? If the later then you can use Chanwoo's bindings:

regulator-state-mem {
   regulator-on-in-suspend;
};

If you want the former then you should look at Chanwoo's previous series that
had support to define the voltage for regulators during a suspend state [0]

Mark had some questions about how that should play with the regulator voltage
range [1] but was not against the idea AFAIU.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/18/22
[1]: https://lkml.org/lkml/2014/9/4/651
