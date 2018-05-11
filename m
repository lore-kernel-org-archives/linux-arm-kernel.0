From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 11 May 2018 07:24:43 -0500
Subject: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
In-Reply-To: <3fdfcc9b-90b5-191c-37e0-c99389a4e872@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
 <76f2bbde-e158-a186-f136-9fb610a810c5@arm.com>
 <3fdfcc9b-90b5-191c-37e0-c99389a4e872@t-chip.com.cn>
Message-ID: <CAL_JsqLujC0nx9LpkWuSR0+fsZn4UJL9Ln6SHWyBmZ-7ErMzfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 10:45 PM, Levin Du <djw@t-chip.com.cn> wrote:
> On 2018-05-10 8:50 PM, Robin Murphy wrote:
>>
>> On 10/05/18 10:16, djw at t-chip.com.cn wrote:
>>>
>>> From: Levin Du <djw@t-chip.com.cn>
>>>
>>> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
>>> access to the pins defined in the syscon GRF_SOC_CON10.
>>
>>
>> This is the GPIO_MUTE pin, right? The public TRM is rather vague, but
>> cross-referencing against the datasheet and schematics implies that it's the
>> "gpiomut_*" part of the GRF bit names which is most significant.
>>
>> It might be worth using a more descriptive name here, since "syscon10" is
>> pretty much meaningless at the board level.
>>
>> Robin.
>>
> Previously I though other bits might be able to reference from syscon10,
> other than GPIO_MUTE alone.
> If it is renamed to gpio-mute, then the GPIO_MUTE pin is accessed as
> `<&gpio-mute 1>`. Yet other
> bits in syscon10 can also be referenced, say, `<&gpio-mute 10>`, which is
> not good.
>
> I'd like to add a `gpio,syscon-bit` property to gpio-syscon, which overrides
> the properties
> of bit_count,  data_bit_offset and dir_bit_offset in the driver. For

No. Once you are describing individual register bits, it is too low
level for DT.

> example:
>
>                 gpio_mute: gpio-mute {
>                         compatible = "rockchip,gpio-syscon";
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         gpio,syscon-dev = <0 0x0428 0>;
>                         gpio,syscon-bit = <1 1 0>;
>                 };
>
> That way, the mute pin is strictly specified as <&gpio_mute 0>, and
> <&gpio_mute 1> will be invalid.
> I think that is neat, and consistent with the gpio_mute name.
>
> Thanks
> Levin
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
