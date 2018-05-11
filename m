From: djw@t-chip.com.cn (Levin Du)
Date: Fri, 11 May 2018 10:16:48 +0800
Subject: [PATCH v1 2/5] gpio: syscon: Add gpio-syscon for rockchip
In-Reply-To: <c0f520d1-42e3-e8b5-128e-3ff3d532ec4c@arm.com>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-3-git-send-email-djw@t-chip.com.cn>
 <c0f520d1-42e3-e8b5-128e-3ff3d532ec4c@arm.com>
Message-ID: <bbbacb2b-531b-cb41-2d74-618d957c4ab7@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-10 10:56 PM, Robin Murphy wrote:
>
>> diff --git 
>> a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt 
>> b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>> new file mode 100644
>> index 0000000..e4c1650
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>> @@ -0,0 +1,41 @@
>> +* Rockchip GPIO support for GRF_SOC_CON registers
>> +
>> +Required properties:
>> +- compatible: Should contain "rockchip,gpio-syscon".
>> +- gpio-controller: Marks the device node as a gpio controller.
>> +- #gpio-cells: Should be two. The first cell is the pin number and
>
> I would suggest s/pin number/bit number in the associated GRF 
> register/ here. At least in this RK3328 case there's only one pin, 
> which isn't numbered, and if you naively considered it pin 0 of this 
> 'bank' you'd already have the wrong number. Since we're dealing with 
> the "random SoC-specific controls" region of the GRF as opposed to the 
> relatively-consistent and organised pinmux parts, I don't think we 
> should rely on any assumptions about how things are laid out.
>
> I was initially going to suggest a more specific compatible string as 
> well, but on reflection I think the generic "rockchip,gpio-syscon" for 
> basic "flip this single GRF bit" functionality actually is the right 
> way to go. In the specific RK3328 GPIO_MUTE case, there look to be 4 
> bits in total related to this pin - the enable, value, and some pull 
> controls (which I assume apply when the output is disabled) - if at 
> some point in future we *did* want to start explicitly controlling the 
> rest of them too, then would be a good time to define a separate 
> "rockchip,rk3328-gpio-mute" binding (and probably a dedicated driver) 
> for that specialised functionality, independently of this basic one.
>
Good point! I'll fix the doc.

>> ? +static void rockchip_gpio_set(struct gpio_chip *chip, unsigned int 
>> offset,
>> +????????????????? int val)
>> +{
>> +??? struct syscon_gpio_priv *priv = gpiochip_get_data(chip);
>> +??? unsigned int offs;
>> +??? u8 bit;
>> +??? u32 data;
>> +??? int ret;
>> +
>> +??? offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;
>
> data->dat_bit_offset is always 0 here, but given that wrapping large 
> offsets to successive GRF registers doesn't make sense (and wouldn't 
> work anyway with this arithmetic) I don't think you even need this 
> calculation of offs at all...
>
>> +??? bit = offs % SYSCON_REG_BITS;
>
> ... since it would suffice to use offset here...
>
>> +??? data = (val ? BIT(bit) : 0) | BIT(bit + 16);
>> +??? ret = regmap_write(priv->syscon,
>> +?????????????? (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
>
> ... and priv->dreg_offset here.
>

rockchip_gpio_set() follows the conventional offset handling in the 
gpio-syscon driver.
dreg_offset will get multiplied by 8 (dreg_offset <<= 3) in 
syscon_gpio_probe().
I'm not sure if this needs to simplify, or stay the same as others.

Thanks
Levin
