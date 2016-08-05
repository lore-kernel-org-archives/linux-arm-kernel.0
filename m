From: robh@kernel.org (Rob Herring)
Date: Thu, 4 Aug 2016 21:45:05 -0500
Subject: [PATCH v2 1/2] ARM64: dts: meson-gxbb: add MMC support
In-Reply-To: <m2oa58nntc.fsf@baylibre.com>
References: <20160803231843.23012-1-khilman@baylibre.com>
 <20160804181556.GA13000@rob-hp-laptop>
 <m2oa58nntc.fsf@baylibre.com>
Message-ID: <CAL_JsqK18UPAUFCqfN7TJqz4AoLBbNA7fOgeQXqPES06fuhgFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+dtc list

On Thu, Aug 4, 2016 at 5:58 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Rob,
>
> Rob Herring <robh@kernel.org> writes:
>
>> On Wed, Aug 03, 2016 at 04:18:42PM -0700, Kevin Hilman wrote:
>>> Add binding and basic support for the SD/eMMC controller on Amlogic
>>> S905/GXBB devices.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> [...]
>
>>> +    mmc_iv: gpio-regulator {
>>> +            compatible = "regulator-gpio";
>>> +
>>> +            regulator-name = "mmc-gpio-supply";
>>> +            regulator-min-microvolt = <1800000>;
>>> +            regulator-max-microvolt = <3300000>;
>>> +
>>> +            gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
>>> +            gpio-states = <0 1>;
>>> +
>>> +            /*
>>> +             * Based on ODROID-C2 schematics:
>>> +             * signal name: IO_TF_3V3N_1V8, GPIOAO bit 3
>>> +             */
>>> +            states = <3300000 0
>>> +                      1800000 1>;
>>
>> There are multiple things wrong in this node based on the regulator-gpio
>> documentation.
>
> I see I got the property name wrong, and the number of elements wrong,
> and this fixes those issues:
>
> -               gpio-states = <0 1>;
> +               gpios-states = <0>;
>
> By "multiple", did you mean more than those 2?  If so, I'm not seeing
> what else is wrong.

I was thinking it needed an enable-gpio property, but now I see that
is separate from "gpios".

> [...]
>
>>> +    mmc_iv: gpio-regulator {
>>> +            compatible = "regulator-gpio";
>>> +
>>> +            regulator-name = "mmc-gpio-supply";
>>> +            regulator-min-microvolt = <1800000>;
>>> +            regulator-max-microvolt = <3300000>;
>>> +
>>> +            gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
>>> +            gpio-states = <0 1>;
>>> +
>>> +            /* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
>>> +            states = <1800000 0
>>> +                      3300000 1>;
>>> +    };
>>> +
>>> +    vddio_boot: regulator {
>> [...]
>>> +    vcc_3v3: regulator {
>>
>> This won't even compile as you have the same node name twice.
>
> Oops, it's wrong indeed, but in fact, it does compile, otherwise I
> would've caught that..  Even if I remove the labels, it still compiles.
> Interesting.

Humm, news to me. I will have to do some testing unless the dtc folks
have any insight.

Rob
