From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Jan 2017 10:42:04 +0100
Subject: [PATCH v7 3/8] PWM: add pwm-stm32 DT bindings
In-Reply-To: <20170118092021.GE18989@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-4-git-send-email-benjamin.gaignard@st.com>
 <20170118092021.GE18989@ulmo.ba.sec>
Message-ID: <CA+M3ks5t8j8bgyK7iq7oig_7+swiWzhB12=Q4q-umesWk4-m9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-18 10:20 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> On Thu, Jan 05, 2017 at 10:25:39AM +0100, Benjamin Gaignard wrote:
>> Define bindings for pwm-stm32
>>
>> version 6:
>> - change st,breakinput parameter format to make it usuable on stm32f7 too.
>>
>> version 2:
>> - use parameters instead of compatible of handle the hardware configuration
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> new file mode 100644
>> index 0000000..866f222
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> @@ -0,0 +1,33 @@
>> +STMicroelectronics STM32 Timers PWM bindings
>> +
>> +Must be a sub-node of an STM32 Timers device tree node.
>> +See ../mfd/stm32-timers.txt for details about the parent node.
>> +
>> +Required parameters:
>> +- compatible:                Must be "st,stm32-pwm".
>> +- pinctrl-names:     Set to "default".
>> +- pinctrl-0:                 List of phandles pointing to pin configuration nodes for PWM module.
>> +                     For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
>> +
>> +Optional parameters:
>> +- st,breakinput:     Arrays of three u32 <index level filter> to describe break input configurations.
>> +                     "index" indicates on which break input the configuration should be applied.
>
> It might be useful to specify what the valid values are for the break
> input index.

It could 0 and 1, I will add this information.

>
> Also, u32 is kind of a Linuxism, perhaps "Arrays of three cells"? Also,
> does this mean there can be multiple entries? Such as 6 cells for two
> configurations? What's the maximum number of such configurations?
>
> If it's possible to specify multiple configurations, maybe a slightly
> clearer wording would be: "One or more <index level filter> triplets to
> describe..."
>

You can have one configuration per index so I will rephrase it like that:
One or two <index level filter> to describe break input configurations.
"index" indicates on which break input (0 or 1 ) the configuration
should be applied.


>> +                     "level" gives the active level (0=low or 1=high) for this configuration.
>
> So how does this work exactly? "level" specifies the output level if the
> filter value is matched?

No it specify on which input level the break event is generated

>
>> +                     "filter" gives the filtering value to be applied.
>
> Is this a single value at which "level" will be applied? Or is it an
> upper/lower bound that can be used to restrict the output to "level" if
> the signal goes beyond/below a certain threshold?

Very very basically filter is more a debounce value set on the signal
to avoid glitches.
The goal of break input feature is to stop PWM generation in hardware
errors failure case.

For a more completed description you can read "using break input
function" (starting page 645) in this doc:

http://www.st.com/content/ccc/resource/technical/document/reference_manual/c5/cf/ef/52/c0/f1/4b/fa/DM00124865.pdf/files/DM00124865.pdf/jcr:content/translations/en.DM00124865.pdf

>
> Maybe an example would clarify this. Or perhaps a reference to a manual
> where a more in-depth description of this functionality can be found.
>
> Thierry



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
