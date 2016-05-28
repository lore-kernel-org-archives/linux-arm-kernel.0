From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 28 May 2016 15:42:24 +0200
Subject: [linux-sunxi] Re: [PATCH] regulator: axp20x: Add support for the
 (external) drivebus regulator
In-Reply-To: <CAGb2v67iPsUAG=Sgk8z-G3KjVb4WoMUutUPKdQ9s=OOCk_jgqg@mail.gmail.com>
References: <1463248545-16543-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v67iPsUAG=Sgk8z-G3KjVb4WoMUutUPKdQ9s=OOCk_jgqg@mail.gmail.com>
Message-ID: <4fe76e77-6743-fa95-2d19-2625316420bc@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-05-16 19:06, Chen-Yu Tsai wrote:
> Hi,
>
> On Sun, May 15, 2016 at 1:55 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The axp20x pmics have 2 power inputs, one called ACIN which is intended
>> for to be supplied via a powerbarrel on the board and one called VBUS
>> which is intended to be supplied via an otg connector.
>>
>> In the VBUS case the pmic needs to know if the board is supplying power
>> to the otg connector, because then it should not take any power from
>> its VBUS pin. The axp209 pmic has a N_VBUSEN input pin via which the
>> board can signal to the pmic whether the board is supplying power to the
>> otg connector or not.
>>
>> On the axp221/axp223 this pin can alternatively be used as an output
>> which controls an external regulator which (optionally) supplies
>> power to the otg connector from the board. When the pin is used as
>> output it is called DRIVEBUS in the datasheet.
>
> The datasheet actually calls it DRIVEVBUS. DRIVEBUS seems to be some
> typo Allwinner has in their code.

Fixed for v2.

>> This commit adds support for the DRIVEBUS pin as an extra pmic
>> controlled regulator. Since this is optional a new x-powers,drivebus dt
>> property is added. When this is present the misc-control register is
>> written to change the N_VBUSEN input pin to DRIVEBUS output pin mode and
>> the extra drivebus regulator is registered with the regulator subsystem.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/axp20x.txt |  5 ++++
>>  drivers/regulator/axp20x-regulator.c             | 30 ++++++++++++++++++++++++
>>  2 files changed, 35 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
>> index d20b103..7a88479 100644
>> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
>> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
>> @@ -22,6 +22,11 @@ Optional properties:
>>                       AXP152/20X: range:  750-1875, Default: 1.5 MHz
>>                       AXP22X/80X: range: 1800-4050, Default: 3   MHz
>>
>> +- x-powers,drivebus: axp221 / axp223 only boolean, set this when the N_VBUSEN
>> +                  pin is used as an output pin to control an external regulator
>> +                  to drive the OTG VBus, rather then as an input pin which
>> +                  signals whether the board is driving OTG VBus or not.
>> +
>
> You should also add it to the regulators table further down in the binding.
> And, as Rob mentioned, x-powers,drive-vbus-en (or drivevbus-en) is better
> for a boolean property.

Both fixed for v2.

>>  - <input>-supply: a phandle to the regulator supply node. May be omitted if
>>                   inputs are unregulated, such as using the IPSOUT output
>>                   from the PMIC.
>> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
>> index 514a5e8..2422ddd 100644
>> --- a/drivers/regulator/axp20x-regulator.c
>> +++ b/drivers/regulator/axp20x-regulator.c
>> @@ -36,6 +36,8 @@
>>
>>  #define AXP20X_FREQ_DCDC_MASK          0x0f
>>
>> +#define AXP22X_MISC_N_VBUSEN_FUNC      BIT(4)
>> +
>>  #define AXP_DESC_IO(_family, _id, _match, _supply, _min, _max, _step, _vreg,   \
>>                     _vmask, _ereg, _emask, _enable_val, _disable_val)           \
>>         [_family##_##_id] = {                                                   \
>> @@ -230,6 +232,18 @@ static const struct regulator_desc axp22x_regulators[] = {
>>         AXP_DESC_FIXED(AXP22X, RTC_LDO, "rtc_ldo", "ips", 3000),
>>  };
>>
>> +static const struct regulator_desc axp22x_drivebus_regulator = {
>> +       .name           = "drivebus",
>> +       .supply_name    = "ips",
>
> Given that you are approximating a gpio (in this case, the
> N_VBUSEN/DRIVEVBUS pin)
> controlled fixed voltage regulator, it would be better if you could:
>
> a) have some way to specify the output voltage, so it looks like a fixed voltage
>    regulator that can be turned on/off.

This is fixed by your suggestion b) actually, if no get_voltage* ops are specified,
it will inherit the voltage of it supply.

> And
>
> b) have a separate supply name for this so it properly propagates enable/disable
>    calls. It would also pass the upstream voltage, thus behaving like a switch
>    you intended with the axp20x_ops_sw below.

Ack, fixed for v2.

Thanks for the review.

Regards,

Hans
