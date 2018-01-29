From: mlyle@lyle.org (Michael Lyle)
Date: Mon, 29 Jan 2018 10:54:29 -0800
Subject: [PATCH] ARM: dts: exynos-artik5: add support for wlan
In-Reply-To: <CAJKOXPfRWUN3t43SqwxFtda8T=3Hn4oUh0HBit3b97eFj+6T4g@mail.gmail.com>
References: <20180129031640.17939-1-mlyle@lyle.org>
 <CAJKOXPfRWUN3t43SqwxFtda8T=3Hn4oUh0HBit3b97eFj+6T4g@mail.gmail.com>
Message-ID: <CAJ+L6qeyf9L9jUyhGL2yPwVb0=SOJqXXi0tvqnpvkoo-09BQ0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[note: earlier on this thread I assumed linux-arm-kernel was on
vger.kernel.org, so the patch was initially sent to the wrong address.
When I resend, I will be sure to use the correct list address]

Krzystztof--

Thank you for your review.  I appreciate your patience as I've not
worked on devicetree files before.

On Mon, Jan 29, 2018 at 7:16 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> Thanks for the patch. Few notes below.
>
>> ---
>>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 36 ++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> index 0aa577fe9f95..b2d441b1a7e3 100644
>> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> @@ -245,6 +245,7 @@
>>                                 regulator-name = "VLDO23_1.8V";
>>                                 regulator-min-microvolt = <1800000>;
>>                                 regulator-max-microvolt = <1800000>;
>> +                               regulator-always-on;
>>                         };
>>
>>                         ldo24_reg: LDO24 {
>> @@ -316,6 +317,41 @@
>>         status = "okay";
>>  };
>>
>> +&pinctrl_1 {
>
> Please order the nodes alphabetically.

OK, I will in an V2.

>> +       wlanen: wlanen {
>> +               samsung,pins = "gpx2-3";
>> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
>> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV3>;
>> +               samsung,pin-val = <1>;
>> +       };
>
> Are you sure you do not need a power sequence? It works fine during
> warm resets or after u-boot initialization?

Yes, it seems to (I have about 20 or so cycles on it in informal test).

I have no idea what the actual hardware is-- this pin is not mentioned
in the module datasheet and there is no schematic.  I found it through
exploring an upstream vendor kernel.  It's altogether possible this is
"naughty" but it seems to work OK.

>> +};
>> +
>> +&mshc_1 {
>> +       cap-sd-highspeed;
>> +       cap-sdio-irq;
>> +       disable-wp;
>> +       broken-cd;
>
> Is this really broken-cd or non-removable card?

I'll check if non-removable works.  I remember it not working once,
but I had other problems in my testing.

>> +       bypass-smu;
>> +       keep-power-in-suspend;
>> +       fifo-depth = <0x40>;
>> +       vqmmc-supply = <&ldo11_reg>;
>> +       /* Voltage negotiation is broken for the SDIO periph so we
>> +        * can't actually set the voltage here.
>> +        * vmmc-supply = <&ldo23_reg>;
>> +        */
>
> Did you try using properties for respective voltage? For example mmc-hs200-1_8v?

This is the vmmc supply, not vqmmc-- that would be for vqmmc, right
(and signalling speed).  The card says it wants a range of vmmc
voltages, but the actual regulator is forced to 1.8V, and 1.8V is not
one of those voltages.  So absent a new quirk, I think I need to nail
the regulator on.

>
>> +       card-detect-delay = <500>;
>> +       clock-frequency = <100000000>;
>> +       max-frequency = <100000000>;
>> +       samsung,dw-mshc-ciu-div = <3>;
>> +       samsung,dw-mshc-sdr-timing = <0 1>;
>> +       samsung,dw-mshc-ddr-timing = <1 2>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&sd1_cmd &sd1_clk &sd1_bus1 &sd1_bus4 &wlanen>;
>> +       bus-width = <4>;
>> +       status = "okay";
>
> There is no brcm/wifi node here?

It enumerates the card currently and then uses the card product
information to load brcmfmac.  Is there a reason to put a description
of the actual card in?

>
> Best regards,
> Krzysztof
>

Thanks,

Mike
