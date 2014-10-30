From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 30 Oct 2014 01:32:47 +0100
Subject: [PATCH v6 7/7] ARM: dts: add suspend voltage setting for RK808
In-Reply-To: <CAD=FV=VtKdLH51tDvHsRfMYah9cUNcNRfbVJ1rfroxwsZZLTsA@mail.gmail.com>
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>	<1414583525-17395-8-git-send-email-zyw@rock-chips.com>	<CAD=FV=XeGj63_MEPL5i1ihUORuHnwD1ktEjJN5x=B-tkHV088w@mail.gmail.com>	<545115DF.9070008@collabora.co.uk>
 <CAD=FV=VtKdLH51tDvHsRfMYah9cUNcNRfbVJ1rfroxwsZZLTsA@mail.gmail.com>
Message-ID: <5451872F.4050306@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 10/29/2014 05:51 PM, Doug Anderson wrote:
>>
>> In other words, do you want the core to call rk808_set_suspend_voltage() or
>> rk808_set_suspend_enable()? If the later then you can use Chanwoo's bindings:
>>
>> regulator-state-mem {
>>    regulator-on-in-suspend;
>> };
> 
> The rk808 has a separate register for storing the sleep voltage,
> though.  ...so just using "regulator-on-in-suspend" without any
> changes to the rk808 driver won't get us this "for free".  I'd expect
> to need
> 
>  regulator-state-mem {
>     regulator-on-in-suspend;
>     regulator-suspend-microvolts = <3300000>;
>  };
>

I see, then as you said the voltage has to be defined in the DT for the suspend
state.

As I mentioned in my previous email, Chanwoo's original suspend state series had
a "regulator-volt" DT property that was used to fill the struct regulator_state
.uV field so the core could call the .set_suspend_voltage function handler.

AFAIU Mark wanted the property to be renamed to "rebulator-microvolt" [0] to be
consistent with the rest of the binding and also he was not sure if the suspend
voltage needed be in the runtime voltage range specified by the properties
"regulator-{min,max}-microvolt" since Chanwoo's patch had a check for that [1].

Chanwoo decided to drop setting the suspend voltage in a following version, but
given that there is a use case for this feature, I think that those two issues
could be addressed and added that property to the generic regulator DT binding.
 
> IMHO it wouldn't be insane to say that if someone has
> "regulator-on-in-suspend" but no suspend voltage defined that it
> should carry forward the runtime voltage.  I actually argued for that
> earlier and Mark Brown said "no" at
> <http://marc.info/?l=linux-kernel&m=141277262106368&w=2>.  More at
> <http://marc.info/?l=linux-kernel&m=141279245027919&w=2>.  It's
> entirely possible I wasn't making myself clear, though.
> 

What I learned from previous Mark's explanations is that there is always a
reason why the regulator API split different operations. So if there is both
a .set_voltage and .set_suspend_voltage, then that is an indication for me
that if someone wants a particular voltage during suspend then it has to be
explicitly set and should not rely on the runtime voltage previously set.

The fact that the rk808 has different registers to configure the runtime
and suspend voltage seems to confirm that the API split makes sense.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/9/4/652
[1]: https://lkml.org/lkml/2014/9/4/651
